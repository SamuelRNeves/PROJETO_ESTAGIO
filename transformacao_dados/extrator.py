import camelot
import pandas as pd
import zipfile
import os

# Caminho para o Anexo I (PDF)
pdf_path = '../data/Anexo_I.pdf' 

# Usando Camelot para ler a tabela no PDF
tables = camelot.read_pdf(pdf_path, pages='all', flavor='stream')

# Verifica se encontrou tabelas
if tables:
    # Combina todas as tabelas extraídas
    all_data = []
    for table in tables:
        all_data.extend(table.df.values.tolist())

    # Cria um DataFrame com os dados extraídos
    df = pd.DataFrame(all_data)

    # Substitui as abreviações OD e AMB por suas descrições completas
    df.replace({'OD': 'Odontologia', 'AMB': 'Ambulatorial'}, inplace=True)

    # Salva os dados extraídos em um arquivo CSV
    csv_path = '../data/tabela_estruturada.csv'  # Caminho atualizado para salvar o CSV na pasta 'data'
    df.to_csv(csv_path, index=False)

    print(f"Dados extraídos e salvos em {csv_path}")

    # Compactação do CSV em um arquivo ZIP
    zip_path = '../data/Teste_SamuelNeves.zip'  # Caminho do arquivo ZIP final
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        if os.path.exists(csv_path):
            zipf.write(csv_path, os.path.basename(csv_path))
            print(f"✅ CSV '{csv_path}' compactado em '{zip_path}'")
        else:
            print(f"❌ Erro: O arquivo {csv_path} não foi encontrado!")
else:
    print("Nenhuma tabela encontrada no PDF!")
