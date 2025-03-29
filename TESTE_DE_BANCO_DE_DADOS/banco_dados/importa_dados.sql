SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'secure_file_priv';


-- Importa o CSV das Operadoras para a tabela operadoras
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv'
INTO TABLE operadoras
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(registro_ans, @cnpj_var, razao_social, nome_fantasia, 
 modalidade, logradouro, numero, complemento, bairro,
 cidade, uf, cep, ddd, telefone, fax, endereco_eletronico,
 representante, cargo_representante, regiao_comercializacao, @data_var)
SET 
    cnpj = NULLIF(@cnpj_var, ''),
    data_registro_ans = CASE 
        WHEN @data_var REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_var, '%d/%m/%Y')
        WHEN @data_var REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_var, '%Y-%m-%d')
        ELSE NULL
    END;



-- Importa os dados contábeis do 1T2023
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS//data/demonstracoes_contabeis/1T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');



-- Importa os dados contábeis do 1T2024
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/1T2024.csv'

INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');





-- Importa os dados contábeis do 2T2023
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/2T2023.csv'

INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');





-- Importa os dados contábeis do 2T2024
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/2T2024.csv'

INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');



-- Importa os dados contábeis do 3T2023
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/3T2023.csv'

INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');




-- Importa os dados contábeis do 3T2024
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/3T2024.csv'

INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');



-- Importa os dados contábeis do 4T2023
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/4T2023.csv'

INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');


-- Importa os dados contábeis do 4T2024
LOAD DATA LOCAL INFILE 'C:/Users/samue/OneDrive/Área de Trabalho/projeto_estagio/TESTE_DE_TRANSFORMACAO_DE_DADOS/data/demonstracoes_contabeis/4T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@data_str, registro_ans, codigo_conta_contabil, descricao_conta, valor_saldo_inicial, valor_saldo_final)
SET 
    data = CASE
        WHEN @data_str REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(@data_str, '%d/%m/%Y')
        WHEN @data_str REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(@data_str, '%Y-%m-%d')
        ELSE NULL
    END,
    valor_saldo_inicial = REPLACE(REPLACE(valor_saldo_inicial, '.', ''), ',', '.'),
    valor_saldo_final = REPLACE(REPLACE(valor_saldo_final, '.', ''), ',', '.');




SELECT * FROM operadoras LIMIT 10;
SELECT * FROM demonstracoes_contabeis LIMIT 10;





