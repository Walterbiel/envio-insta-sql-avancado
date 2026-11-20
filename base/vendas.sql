CREATE TABLE vendas (
    id       INTEGER PRIMARY KEY,
    vendedor VARCHAR(50),
    regiao   VARCHAR(20),
    data     DATE,
    valor    DECIMAL(10, 2)
);

CREATE TABLE funcionarios (
    id        INTEGER PRIMARY KEY,
    nome      VARCHAR(50),
    gestor_id INTEGER
);

INSERT INTO vendas VALUES
    (1, 'Ana', 'Sul', '2026-01-03', 1200), (2, 'Bruno', 'Norte', '2026-01-04', 800),
    (3, 'Ana', 'Sul', '2026-01-10', 3000), (4, 'Carla', 'Norte', '2026-01-12', 3000),
    (5, 'Bruno', 'Sul', '2026-01-15', 450), (6, 'Carla', 'Norte', '2026-01-20', 2200),
    (7, 'Ana', 'Norte', '2026-02-02', 1900), (8, 'Bruno', 'Norte', '2026-02-05', 5100),
    (9, 'Carla', 'Sul', '2026-02-08', 700), (10, 'Ana', 'Sul', '2026-02-14', 2500);

INSERT INTO funcionarios VALUES
    (1, 'Diretora Rita', NULL), (2, 'Gerente Paulo', 1), (3, 'Gerente Sônia', 1),
    (4, 'Ana', 2), (5, 'Bruno', 2), (6, 'Carla', 3);
