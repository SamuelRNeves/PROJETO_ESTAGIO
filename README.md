# 🚀 Projeto de Testes e Processamento de Dados  

Este repositório contém diferentes módulos que realizam testes de API, transformação de dados e web scraping. O projeto usa **FastAPI** para servir a API, **pandas** para manipulação de dados, **pdfplumber** para extração de informações de PDFs e **requests** para web scraping.

## 🔧 **1. Instalação das Dependências**  

Antes de rodar o projeto, é necessário instalar as bibliotecas necessárias.    

### 📌 **Requisitos**  

- Python 3.8+  
- pip instalado  

### 📥 **Instalar as Dependências**  

Execute o comando abaixo no terminal:  

```sh
pip install -r requirements.txt

-----

🏃 2. Executando os Módulos
cd TESTE_DE_API
python app.py

📡 2.1 API com Flask
A API básica está no arquivo app.py e serve para buscar operadoras armazenadas em um CSV.

Exemplo de requisição:
curl http://localhost:8000/api/buscar?query=Bradesco


⚡ 2.2 API com FastAPI
A API mais avançada está no arquivo server.py e inclui cache com Redis para melhorar o desempenho.

Execute o comando abaixo para rodar a API FastAPI:
cd TESTE_DE_API
cd server
python server.py


📊 3. Extração e Transformação de Dados
O módulo extrator.py extrai tabelas de arquivos PDF e salva os dados processados em formatos CSV e ZIP.

--cd TESTE_DE_TRANSFORMACAO_DE_DADOS
--cd transformacao_dados
--python extrator.py


🌐 4. Web Scraping e Compactação

📥 4.1 Baixar Arquivos
O arquivo scraper.py faz o download de documentos oficiais de um site público.

Execute o seguinte comando para baixar:

cd TESTE_DE_WEB_SCRAPING
python scraper.py

🗜️ 4.2 Compactar Arquivos
Após baixar os arquivos, você pode compactá-los com o arquivo compactador.py.

Execute o seguinte comando para compactar os arquivos:

python compactador.py

🧪 5. Testes Automatizados
O projeto contém testes unitários para validar a API FastAPI. Para rodar os testes, execute o seguinte comando:
Para rodar os testes, execute:
cd TESTE_DE_API
python -m unittest server.py

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