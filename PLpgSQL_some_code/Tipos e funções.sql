CREATE TABLE instrutor (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	salario DECIMAL(10,2)
);

INSERT INTO instrutor (nome, salario) VALUES ('Bruno Gianetti', 100);

CREATE FUNCTION dobro_do_salario(instrutor) RETURNS DECIMAL AS $$
	SELECT $1.salario * 2 AS dobro;
$$ LANGUAGE SQL;

-- 'instrutor' como parâmetro da função é o TIPO. Se eu tenho uma tabela já
-- criada, eu posso utilizar o nome dessa tabela como TIPO da função.

-- '$1' é o registro completo (linha inteira) que pega 'salário'

SELECT nome, dobro_do_salario(instrutor.*) FROM instrutor;

-- *, como parâmetro, pega a coluna inteira e aplica o cálculo da função.
-- Eu poderia deixar sem o * e funcionaria da mesma forma, mas deixando
-- eu torno o código mais explícito.

-- TIPO COMPOSTO: é um conjunto de valores como id, nome e salário. Esses
-- tipos podem ser passados como parâmetro, assim como o próprio nome da 
-- tabela.

CREATE OR REPLACE FUNCTION cria_instrutor_falso() RETURNS instrutor AS $$
	SELECT 22, 'Nome falso', 200::DECIMAL;
$$ LANGUAGE SQL;

SELECT cria_instrutor_falso(); -- entre '()' na tabela é uma linha, um conjunto de dados

SELECT * FROM cria_instrutor_falso();

-- Retornando conjuntos

INSERT INTO instrutor (nome, salario) VALUES ('Leo', 300);
INSERT INTO instrutor (nome, salario) VALUES ('Paulo', 400);
INSERT INTO instrutor (nome, salario) VALUES ('Juliana', 500);
INSERT INTO instrutor (nome, salario) VALUES ('Lilian', 600);

DROP FUNCTION instrutores_bem_pagos;

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
	SELECT * FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL;

SELECT * FROM instrutores_bem_pagos(300);

-- Para retornar um conjunto de instrutores, eu preciso do SETOF após RETURNS

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS TABLE (id INTEGER, nome VARCHAR, salario DECIMAL) AS $$
	SELECT * FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL;

-- Acima eu tenho o mesmo retorno, mas com outra possibilidade que é mais
-- trabalhosa. O SETOF vem para agregara todo o conjunto da tabela

-- Parâmetros de saída

CREATE FUNCTION soma_e_produto (numero_1 INTEGER, numero_2 INTEGER, OUT soma INTEGER, OUT produto INTEGER) AS $$
	SELECT numero_1 + numero_2 AS soma, numero_1 * numero_2 AS produto;
$$ LANGUAGE SQL;

-- eu poderia ter colocado 'IN' nos parâmetros da função antes de numero_1 e numero_2 para indicar 'entrada'

SELECT * FROM soma_e_produto(3,3);

-- Eu poderia ter feito isso de forma mais concisa.

CREATE TYPE dois_valores AS (soma INTEGER, produto INTEGER);

DROP FUNCTION soma_e_produto;

CREATE FUNCTION soma_e_produto (IN numero_1 INTEGER, IN numero_2 INTEGER) RETURNS dois_valores AS $$
	SELECT numero_1 + numero_2 AS soma, numero_1 * numero_2 AS produto;
$$ LANGUAGE SQL;

SELECT * FROM soma_e_produto(3,3);

-- Tipo 'record'

DROP FUNCTION instrutores_bem_pagos;

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL, OUT nome VARCHAR, OUT salario DECIMAL) RETURNS SETOF record AS $$
	SELECT nome, salario FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL;

-- uso o 'record' porque não preciso informar o que foi explícito nos parâmetros 'OUT'

SELECT * FROM instrutores_bem_pagos(300);



