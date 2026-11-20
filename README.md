# SQL Avançado

Material gratuito do QG da Engenharia de Dados. Você recebeu porque comentou **WINDOW**.

## Como usar este material

1. Leia o guia abaixo
2. Rode os exemplos na base [base/vendas.sql](base/vendas.sql) com [rodar.py](rodar.py) (só precisa do Python)
3. Resolva [exercicios.sql](exercicios.sql) → confira em [gabarito.sql](gabarito.sql)

```bash
python rodar.py exercicios.sql
```

## A base

```
vendas (id, vendedor, regiao, data, valor)
funcionarios (id, nome, gestor_id)
```

## 1. CTE: consulta com nome

```sql
WITH total_vendedor AS (
    SELECT vendedor, SUM(valor) AS total
    FROM vendas
    GROUP BY vendedor
)
SELECT * FROM total_vendedor WHERE total > 5000;
```

Deixa a consulta legível → cada etapa vira um bloco.

## 2. Window functions: calcular sem perder as linhas

```sql
SELECT vendedor, data, valor,
       SUM(valor) OVER (PARTITION BY vendedor) AS total_vendedor,
       valor * 100.0 / SUM(valor) OVER () AS pct_do_total
FROM vendas;
```

`GROUP BY` → junta as linhas
`OVER()` → mantém as linhas e adiciona o cálculo ao lado

## 3. Ranking

```sql
SELECT vendedor, valor,
       ROW_NUMBER() OVER (ORDER BY valor DESC) AS row_number,  -- 1, 2, 3, 4
       RANK()       OVER (ORDER BY valor DESC) AS rank,        -- 1, 2, 2, 4
       DENSE_RANK() OVER (ORDER BY valor DESC) AS dense_rank   -- 1, 2, 2, 3
FROM vendas;
```

## 4. Top N por grupo

```sql
WITH ranqueado AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY regiao ORDER BY valor DESC) AS pos
    FROM vendas
)
SELECT * FROM ranqueado WHERE pos = 1;   -- maior venda de cada região
```

## 5. LAG e LEAD: comparar com a linha anterior

```sql
SELECT data, valor,
       LAG(valor) OVER (ORDER BY data) AS anterior,
       valor - LAG(valor) OVER (ORDER BY data) AS diferenca
FROM vendas;
```

## 6. Acumulado e média móvel

```sql
SELECT data, valor,
       SUM(valor) OVER (ORDER BY data) AS acumulado,
       AVG(valor) OVER (ORDER BY data ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS media_3
FROM vendas;
```

## 7. CTE recursiva: hierarquia

```sql
WITH RECURSIVE hierarquia AS (
    SELECT id, nome, gestor_id, 1 AS nivel FROM funcionarios WHERE gestor_id IS NULL
    UNION ALL
    SELECT f.id, f.nome, f.gestor_id, h.nivel + 1
    FROM funcionarios f
    JOIN hierarquia h ON f.gestor_id = h.id
)
SELECT * FROM hierarquia;
```

## 8. Pivot com CASE

```sql
SELECT vendedor,
       SUM(CASE WHEN regiao = 'Sul' THEN valor ELSE 0 END) AS sul,
       SUM(CASE WHEN regiao = 'Norte' THEN valor ELSE 0 END) AS norte
FROM vendas
GROUP BY vendedor;
```

## QG da Engenharia de Dados

Este material é uma amostra do que você encontra no QG.

→ Trilha completa do zero ao sênior
→ Projetos reais para o portfólio
→ Comunidade para tirar dúvidas

Acesse → [qg-engenharia-de-dados.com.br](https://qg-engenharia-de-dados.com.br)
YouTube → [@gonzagadosdados](https://www.youtube.com/@gonzagadosdados)
