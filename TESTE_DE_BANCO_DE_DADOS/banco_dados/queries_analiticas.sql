-- Top s 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre
SELECT 
    o.razao_social,
    o.cnpj,
    FORMAT(SUM(CASE 
        WHEN dc.codigo_conta_contabil LIKE '3%' THEN dc.valor_saldo_final - dc.valor_saldo_inicial
        ELSE 0 
    END), 2) AS total_despesas,
    COUNT(*) AS qtde_registros
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras o ON dc.registro_ans = o.registro_ans,
    (SELECT 
        MAX(data) AS data_fim,
        DATE_SUB(MAX(data), INTERVAL 3 MONTH) AS data_inicio
     FROM demonstracoes_contabeis) AS periodo
WHERE 
    (dc.descricao_conta LIKE '%SINISTROS CONHECIDOS%' OR
     dc.descricao_conta LIKE '%EVENTOS/SINISTROS%' OR
     dc.descricao_conta LIKE '%ASSISTÊNCIA MÉDICO-HOSPITALAR%')
    AND dc.data BETWEEN periodo.data_inicio AND periodo.data_fim
    AND (dc.valor_saldo_final <> dc.valor_saldo_inicial)
GROUP BY 
    o.razao_social, o.cnpj
HAVING
    total_despesas > 0
ORDER BY 
    total_despesas DESC
LIMIT 10;



-- Top 10 operadoras com maiores despesas no último ano
SELECT 
    o.razao_social,
    o.cnpj,
    FORMAT(SUM(CASE 
        WHEN dc.codigo_conta_contabil LIKE '3%' THEN dc.valor_saldo_final - dc.valor_saldo_inicial
        ELSE 0 
    END), 2) AS total_despesas,
    COUNT(*) AS qtde_registros,
    MAX(dc.data) AS ultima_atualizacao
FROM 
    demonstracoes_contabeis dc
JOIN 
    operadoras o ON dc.registro_ans = o.registro_ans,
    (SELECT 
        MAX(data) AS data_fim,
        DATE_SUB(MAX(data), INTERVAL 1 YEAR) AS data_inicio
     FROM demonstracoes_contabeis) AS periodo
WHERE 
    (dc.descricao_conta LIKE '%SINISTROS CONHECIDOS%' OR
     dc.descricao_conta LIKE '%EVENTOS/SINISTROS%' OR
     dc.descricao_conta LIKE '%MEDICO-HOSPITALAR%')
    AND dc.data BETWEEN periodo.data_inicio AND periodo.data_fim
    AND (dc.valor_saldo_final <> dc.valor_saldo_inicial)
GROUP BY 
    o.razao_social, o.cnpj
HAVING
    total_despesas > 0
ORDER BY 
    total_despesas DESC
LIMIT 10;


