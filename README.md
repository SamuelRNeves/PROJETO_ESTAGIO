# 🚀 Projeto estágio intutive care 

### 📌 **Requisitos**  

- Python 3.8+  
- pip instalado  



Execute o comando abaixo no terminal:  


 # 1. Executando a api
    cd TESTE_DE_API
    cd server
# Crie o ambiente virtual
    python -m venv env
# Ativar o ambiente virtual:
# No Windows (cmd ou PowerShell):
    env\Scripts\activate
# No Git Bash:
    source env/Scripts/activate
    pip install -r requirements.txt
# Rodar o servidor
    python server.py

Exemplo de requisição:
curl http://localhost:8000/api/buscar?query=Bradesco



# 2. Frontend (Vue.js)
# após voltar para o diretório raiz do projeto
    cd TESTE_DE_API
    cd frontend
# Instale as dependências do Node.js:
    npm install
# Rode o servidor de desenvolvimento
    npm run serve
 A página estará disponivel em http://localhost:8080


 # 3. Transformação de Dados 📊

O módulo extrator.py extrai tabelas de arquivos PDF e salva os dados processados em formatos CSV e ZIP.
# vá para o diretório
    cd TESTE_DE_TRANSFORMACAO_DE_DADOS
    cd transformacao_dados
# Crie o ambiente virtual
    python -m venv venv
# Ative o ambiente virtual
    source venv/Scripts/activate
# baixe as dependencias 
    pip install -r requirements.txt
# Execute o script
    python extrator.py
 O script vai gerar uma pasta chamada output que contera o arquivo zipado e o csv


 # 4. Web Scraping e Compactação 🌐

O arquivo scraper.py faz o download de documentos oficiais do site do ministério da saúde .

Execute o seguinte comando para baixar:

    cd TESTE_DE_WEB_SCRAPING
# Crie o ambiente virtual
    python -m venv venv
# Ative o ambiente virtual
    source venv/Scripts/activate
# Baixe as dependecias 
    pip install -r requirements.txt
# Rode o script        
    python scraper.py

  # 4.2 Compactar Arquivos

# Rode o script
        python compactador.py
    O script vai gerar um arquivo zipado chamado Anexos.zip     


🧪

## 📝 Testando a API com Postman

O arquivo **Postman** para testar as APIs está disponível na pasta `teste/` dentro da pasta TESTE_DE_API. Para usá-lo:

1. Baixe e abra o arquivo **`api_collection.json`** no [Postman](https://www.postman.com/).
2. Configure o **Postman** para fazer requisições às APIs do seu ambiente local.

A coleção inclui endpoints para testar a API com Flask e FastAPI.


🛠 6. Tecnologias Utilizadas
O projeto foi desenvolvido com as seguintes tecnologias:

FastAPI & Flask → APIs para consulta de operadoras

Pandas → Manipulação e transformação de dados

pdfplumber → Extração de tabelas de PDFs

Requests → Web scraping

Redis → Cache para melhorar a performance da API