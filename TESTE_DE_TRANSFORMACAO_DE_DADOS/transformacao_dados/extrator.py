import pdfplumber
import pandas as pd
import os
import logging
from datetime import datetime
import zipfile

# Configuração de logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[logging.StreamHandler()]
)

COLUNAS = [
    'PROCEDIMENTO', 'RN', 'VIGÊNCIA', 'Segmento Odontológico', 'Segmento Ambulatorial',
    'Segmento Hospitalar com Obstetrícia', 'Segmento Hospitalar sem Obstetrícia', 'Plano Referência',
    'Procedimento de Alta Complexidade', 'Diretriz de Utilização', 'SUBGRUPO', 'GRUPO', 'CAPÍTULO'
]

def processar_linha(linha):
    """Processa uma linha da tabela com substituição correta das abreviações"""
    return [
        linha[0].replace('\n', ' ').strip(),
        linha[1].strip(),
        linha[2].strip(),
        'Odontologia' if 'OD' in linha[3] else '',
        'Ambulatorial' if 'AMB' in linha[4] else '',
        'Sim' if 'HCO' in linha[5] else 'Não',
        'Sim' if 'HSO' in linha[6] else 'Não',
        linha[7].strip(),
        linha[8].strip(),
        linha[9].strip(),
        linha[10].strip(),
        linha[11].strip(),
        linha[12].strip()
    ]

def extrair_tabela(pdf_path, inicio=3, fim=181):
    """Extrai tabelas das páginas específicas com tratamento robusto"""
    dados = []
    with pdfplumber.open(pdf_path) as pdf:
        for i in range(inicio-1, fim):  # pdfplumber usa indexação 0-based
            pagina = pdf.pages[i]
            
            # Configuração otimizada para tabelas grandes
            config = {
                "vertical_strategy": "lines", 
                "horizontal_strategy": "lines",
                "explicit_vertical_lines": pagina.curves + pagina.edges,
                "explicit_horizontal_lines": pagina.curves + pagina.edges,
                "snap_tolerance": 5
            }
            
            try:
                tabela = pagina.extract_table(table_settings=config)
                if tabela:
                    for linha in tabela:
                        if len(linha) >= 13 and 'PROCEDIMENTO' not in linha[0]:
                            dados.append(processar_linha(linha))
                    logging.info(f"Página {i+1}: {len(tabela)} linhas processadas")
            except Exception as e:
                logging.error(f"Erro na página {i+1}: {str(e)}")
                continue
                
    return pd.DataFrame(dados, columns=COLUNAS)

def validar_dados(df):
    """Realiza validações críticas na estrutura dos dados"""
    if len(df.columns) != 13:
        raise ValueError("Número de colunas incorreto")
    if df.empty:
        raise ValueError("Nenhum dado foi extraído")
    return True

def salvar_resultados(df, nome):
    """Salva os resultados nos formatos solicitados"""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    csv_path = f"../output/Procedimentos_ANS_{timestamp}.csv"
    zip_path = f"../output/Teste_{nome}.zip"
    
    os.makedirs('../output', exist_ok=True)
    
    # Salvar CSV
    df.to_csv(csv_path, index=False, sep=';', encoding='utf-8-sig')
    
    # Criar ZIP
    with zipfile.ZipFile(zip_path, 'w') as zipf:
        zipf.write(csv_path, os.path.basename(csv_path))
    
    return zip_path

if __name__ == "__main__":
    PDF_PATH = '../data/Anexo_I.pdf'
    NOME_USUARIO = 'SamuelNeves'
    
    try:
        logging.info("Iniciando extração das páginas 3 a 181...")
        df = extrair_tabela(PDF_PATH)
        validar_dados(df)
        
        logging.info(f"Total de registros extraídos: {len(df):,}")
        caminho_zip = salvar_resultados(df, NOME_USUARIO)
        
        logging.info(f"Processo concluído com sucesso! Arquivo gerado: {caminho_zip}")
        logging.info("\nAmostra dos dados:\n%s", df.head(3).to_markdown(index=False))
        
    except Exception as e:
        logging.error(f"Falha no processamento: {str(e)}")
        exit(1)