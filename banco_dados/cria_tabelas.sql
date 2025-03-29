CREATE DATABASE projeto_estagio;
USE projeto_estagio;

DROP TABLE demonstracoes_contabeis;

-- Tabela para os dados cadastrais das operadoras (arquivo CSV das operadoras)
CREATE TABLE operadoras (
    registro_ans VARCHAR(20),
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(3),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_comercializacao VARCHAR(20),
    data_registro_ans DATE,
    id INT AUTO_INCREMENT PRIMARY KEY
);

-- Tabela para as demonstrações contábeis (dados dos últimos 2 anos)
CREATE TABLE demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE NOT NULL,
    registro_ans VARCHAR(20) NOT NULL,
    codigo_conta_contabil VARCHAR(50) NOT NULL,
    descricao_conta VARCHAR(255) NOT NULL,
    valor_saldo_inicial DECIMAL(15,2) DEFAULT 0.00,
    valor_saldo_final DECIMAL(15,2) DEFAULT 0.00,
    ano INT GENERATED ALWAYS AS (YEAR(data)) STORED,
    mes INT GENERATED ALWAYS AS (MONTH(data)) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_registro_ans (registro_ans),
    INDEX idx_data (data),
    INDEX idx_codigo_conta (codigo_conta_contabil)
);
