from fastapi import FastAPI, Query, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pandas as pd
import uvicorn
import unicodedata
from typing import List, Dict, Optional
import unittest
import httpx
from fastapi.testclient import TestClient
from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend
from fastapi_cache.decorator import cache
import redis
import time
import os

app = FastAPI()

# Configuração CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class SearchResult(BaseModel):
    query: str
    count: int
    results: List[Dict]
    page: Optional[int] = None
    processing_time_ms: Optional[float] = None

def normalize_text(text: str) -> str:
    """Normaliza uma string usando a forma NFC."""
    if isinstance(text, str):
        return unicodedata.normalize("NFC", text)
    return text

def load_operadoras():
    try:
        df = pd.read_csv(
            'Relatorio_cadop.csv',
            sep=';',
            encoding='latin1',
            dtype={'CNPJ': str, 'Registro_ANS': str},
            na_values=['', 'NA', 'N/A']
        )
        df.columns = [col.lower().replace(' ', '_') for col in df.columns]

        for col in ['nome_fantasia', 'razao_social', 'modalidade']:
            if col in df.columns:
                df[col] = df[col].apply(normalize_text)

        df = df.where(pd.notnull(df), None)
        return df
    except Exception as e:
        print(f"Erro crítico ao carregar dados: {str(e)}")
        raise

# Inicialização do Redis e Cache
@app.on_event("startup")
async def startup():
    redis_url = os.getenv("REDIS_URL", "redis://localhost:6379")
    redis_conn = redis.from_url(redis_url, encoding="utf-8", decode_responses=True)
    FastAPICache.init(RedisBackend(redis_conn), prefix="operadoras-cache")

try:
    df_operadoras = load_operadoras()
    # Criar índice para otimizar buscas
    if not df_operadoras.empty:
        df_operadoras['search_index'] = (
            df_operadoras['nome_fantasia'].str.lower() + " " + 
            df_operadoras['razao_social'].str.lower()
        )
except Exception as e:
    print(f"❌ Falha ao iniciar: {str(e)}")
    exit(1)

@app.get("/api/health")
async def health_check():
    return {"status": "online", "message": "API operacional"}

@app.get("/api/buscar", response_model=SearchResult)
@cache(expire=300)  # Cache de 5 minutos
async def buscar_operadoras(
    request: Request,
    query: str = Query(..., min_length=2),
    limit: int = Query(50, ge=1, le=100),
    page: int = Query(1, ge=1)
):
    start_time = time.time()
    
    try:
        # Otimização: usar índice criado
        query_lower = query.lower()
        mask = df_operadoras['search_index'].str.contains(query_lower, na=False)
        
        # Paginação eficiente
        offset = (page - 1) * limit
        resultados = df_operadoras[mask].iloc[offset:offset + limit].to_dict(orient='records')
        
        processing_time_ms = round((time.time() - start_time) * 1000, 2)
        
        return {
            "query": query,
            "count": len(resultados),
            "results": resultados or [],
            "page": page,
            "processing_time_ms": processing_time_ms
        }
        
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Erro interno: {str(e)}"
        )

@app.get("/metrics")
async def get_metrics():
    return {
        "cache_status": FastAPICache.get_backend().status(),
        "performance": {
            "avg_response_time": "N/A"  # Implementar lógica de métricas reais
        }
    }

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)

# Teste Automatizado
class TestAPI(unittest.TestCase):
    def setUp(self):
        self.client = TestClient(app)
    
    def test_health_check(self):
        response = self.client.get("/api/health")
        self.assertEqual(response.status_code, 200)
        self.assertIn("online", response.json()["status"])
    
    def test_busca_operadoras(self):
        response = self.client.get("/api/buscar?query=saude&limit=5")
        self.assertEqual(response.status_code, 200)
        self.assertTrue(isinstance(response.json()["results"], list))
    
    def test_paginacao(self):
        response = self.client.get("/api/buscar?query=saude&limit=5&page=2")
        self.assertEqual(response.status_code, 200)
        self.assertIn("page", response.json())