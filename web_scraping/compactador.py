import zipfile
import os

# Caminho do arquivo ZIP final
zip_anexos_path = "../data/Anexos.zip"

# Lista de anexos a serem compactados
anexos = ["../data/Anexo_I.pdf", "../data/Anexo_II.pdf"]

# Criar o ZIP e adicionar os anexos
with zipfile.ZipFile(zip_anexos_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for anexo in anexos:
        if os.path.exists(anexo):
            zipf.write(anexo, os.path.basename(anexo))
            print(f"✅ '{anexo}' adicionado ao '{zip_anexos_path}'")
        else:
            print(f"❌ Erro: O arquivo {anexo} não foi encontrado!")

