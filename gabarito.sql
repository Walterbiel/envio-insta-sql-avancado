-- 1
WITH por_regiao AS (
    SELECT regiao, SUM(valor) AS total FROM vendas GROUP BY regiao
)
SELECT * FROM por_regiao ORDER BY total DESC;

-- 2
SELECT vendedor, data, valor,
       SUM(valor) OVER (PARTITION BY vendedor) AS total_vendedor
FROM vendas;

-- 3
SELECT vendedor, SUM(valor) AS total,
       DENSE_RANK() OVER (ORDER BY SUM(valor) DESC) AS posicao
FROM vendas
GROUP BY vendedor;

-- 4
WITH ranqueado AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY vendedor ORDER BY valor DESC) AS pos
    FROM vendas
)
SELECT vendedor, data, valor FROM ranqueado WHERE pos = 1;

-- 5
SELECT vendedor, data, valor,
       valor - LAG(valor) OVER (PARTITION BY vendedor ORDER BY data) AS diferenca
FROM vendas;

-- 6
SELECT data, valor, SUM(valor) OVER (ORDER BY data) AS acumulado
FROM vendas;

-- 7
SELECT vendedor,
       SUM(CASE WHEN strftime('%m', data) = '01' THEN valor ELSE 0 END) AS janeiro,
       SUM(CASE WHEN strftime('%m', data) = '02' THEN valor ELSE 0 END) AS fevereiro
FROM vendas
GROUP BY vendedor;
-- No PostgreSQL troque strftime('%m', data) por EXTRACT(MONTH FROM data) = 1

-- 8
WITH RECURSIVE hierarquia AS (
    SELECT id, nome, gestor_id, 1 AS nivel FROM funcionarios WHERE gestor_id IS NULL
    UNION ALL
    SELECT f.id, f.nome, f.gestor_id, h.nivel + 1
    FROM funcionarios f
    JOIN hierarquia h ON f.gestor_id = h.id
)
SELECT nome, nivel FROM hierarquia ORDER BY nivel, nome;
