from flask import Flask, request, jsonify
from flask_cors import CORS
import pandas as pd

app = Flask(__name__)
CORS(app)

# Carrega os dados do CSV (certifique-se de que o operadoras.csv esteja na mesma pasta ou ajuste o caminho)
csv_path = "operadoras.csv"
operadoras_df = pd.read_csv(csv_path, encoding="utf-8")

@app.route('/busca', methods=['GET'])
def busca_operadoras():
    termo = request.args.get('q', '').lower()
    if termo:
        filtro = operadoras_df['nome_fantasia'].str.lower().str.contains(termo) | \
                 operadoras_df['razao_social'].str.lower().str.contains(termo)
        resultados = operadoras_df[filtro]
    else:
        resultados = operadoras_df
    return jsonify(resultados.to_dict(orient='records'))

if __name__ == '__main__':
    app.run(debug=True, port=5000)
