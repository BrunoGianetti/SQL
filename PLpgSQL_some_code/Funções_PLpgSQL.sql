-- Quando o retorno é 'void', basta não adicionar retorno nenhum.

DROP FUNCTION criar_a;

CREATE OR REPLACE FUNCTION criar_a(nome VARCHAR(255)) RETURNS void AS $$
	BEGIN
		INSERT INTO a (nome) VALUES ('Bruno Gianetti');
	END;
$$ LANGUAGE plpgsql;

SELECT criar_a('Bruno Gianetti');

SELECT * FROM a;

-- Retorno de tipo composto

DROP FUNCTION cria_instrutor_falso;

CREATE OR REPLACE FUNCTION cria_instrutor_falso() RETURNS instrutor AS $$
	BEGIN
		RETURN ROW(22, 'Nome falso', 200::DECIMAL)::instrutor;
	END;
$$ LANGUAGE plpgsql;

SELECT cria_instrutor_falso();

SELECT id, salario FROM cria_instrutor_falso();

-- Aumentando a complexidade do exemplo anterior

DROP FUNCTION cria_instrutor_falso;

CREATE OR REPLACE FUNCTION cria_instrutor_falso() RETURNS instrutor AS $$
	DECLARE
		retorno instrutor;
	BEGIN
		SELECT 22, 'Nome falso', 200::DECIMAL INTO retorno;
		
		RETURN retorno;
	END;
$$ LANGUAGE plpgsql;

SELECT cria_instrutor_falso();

SELECT id, salario FROM cria_instrutor_falso();

-- Retorno de tipos

DROP FUNCTION instrutores_bem_pagos;

CREATE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
	BEGIN
		RETURN QUERY SELECT * FROM instrutor WHERE salario > valor_salario;
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM instrutores_bem_pagos(300);




