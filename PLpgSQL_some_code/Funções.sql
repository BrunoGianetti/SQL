CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS '
	SELECT (5 - 3) * 2
' LANGUAGE SQL;

SELECT primeira_funcao() AS numero;

-- Exemplo de função

CREATE FUNCTION soma_dois_numeros(numero_1 INTEGER, numero_2 INTEGER) RETURNS INTEGER AS '
	SELECT numero_1 + numero_2;
' LANGUAGE SQL; 

SELECT soma_dois_numeros(3,17);

-- Variação do Exemplo acima

DROP FUNCTION soma_dois_numeros;

CREATE FUNCTION soma_dois_numeros(INTEGER, INTEGER) RETURNS INTEGER AS '
	SELECT $1 + $2;
' LANGUAGE SQL;

SELECT soma_dois_numeros(3,17);

-- Detalhes de Funções - Com retorno

CREATE TABLE a (nome VARCHAR(255) NOT NULL);

DROP FUNCTION criar_a;

CREATE OR REPLACE FUNCTION criar_a(nome VARCHAR(255)) RETURNS VARCHAR AS '
	INSERT INTO a (nome) VALUES (criar_a.nome);
	
	SELECT nome;
' LANGUAGE SQL;

SELECT criar_a('Bruno Gianetti');

-- Detalhes de Funções - Sem retorno

CREATE OR REPLACE FUNCTION criar_a(nome VARCHAR(255)) RETURNS void AS '
	INSERT INTO a (nome) VALUES (criar_a.nome);
' LANGUAGE SQL;

-- Detalhes de Funções - Inserção de string em VALUES

CREATE OR REPLACE FUNCTION criar_a(nome VARCHAR(255)) RETURNS void AS $$
	INSERT INTO a (nome) VALUES ('Bruno Gianetti');
$$ LANGUAGE SQL;


