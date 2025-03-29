import requests
import os

# URL do site onde os anexos estão disponíveis
URL_BASE = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-dasociedade/atualizacao-do-rol-de-procedimentos"
ANEXOS = {
    "Anexo_I.pdf": "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf",
    "Anexo_II.pdf": "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_II_DUT_2021_RN_465.2021_RN628.2025_RN629.2025.pdf"
}

# Criar pasta para armazenar os anexos
os.makedirs("data", exist_ok=True)

def baixar_anexos():
    for nome_arquivo, url in ANEXOS.items():
        caminho_arquivo = os.path.join("data", nome_arquivo)
        print(f"Baixando {nome_arquivo}...")

        response = requests.get(url)
        if response.status_code == 200:
            with open(caminho_arquivo, "wb") as f:
                f.write(response.content)
            print(f"✅ {nome_arquivo} salvo em {caminho_arquivo}")
        else:
            print(f"❌ Erro ao baixar {nome_arquivo}: {response.status_code}")

if __name__ == "__main__":
    baixar_anexos()
