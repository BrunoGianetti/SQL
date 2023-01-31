-- Condicionais (solução melhor com apenas uma consulta no banco)

CREATE FUNCTION salario_ok(instrutor instrutor) RETURNS VARCHAR AS $$
	BEGIN
		IF instrutor.salario > 200 THEN
			RETURN 'Salário está ok';
		ELSE
			RETURN 'Salário pode aumentar';
		END IF;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor) FROM instrutor;

-- Outra forma para a mesma solução

DROP FUNCTION salario_ok;

CREATE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		
		IF instrutor.salario > 200 THEN
			RETURN 'Salário está ok';
		ELSE
			RETURN 'Salário pode aumentar';
		END IF;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;

-- ELSEIF

-- Estrutura aninha sem ELSEIF

CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		
		IF instrutor.salario > 300 THEN
			RETURN 'Salário está ok';
		ELSE
			IF instrutor.salario = 300 THEN
				RETURN 'Salário pode aumentar';
			ELSE
				RETURN 'Salário está defasado';
			END IF;
		END IF;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;

-- Estrutura aninha com ELSEIF

CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		
		IF instrutor.salario > 300 THEN
			RETURN 'Salário está ok';
		ELSEIF instrutor.salario = 300 THEN
				RETURN 'Salário pode aumentar';
		ELSE
			RETURN 'Salário está defasado';
		END IF;
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;

-- CASE WHEN

CREATE OR REPLACE FUNCTION salario_ok(id_instrutor INTEGER) RETURNS VARCHAR AS $$
	DECLARE
		instrutor instrutor;
	BEGIN
		SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
		
		/*IF instrutor.salario > 300 THEN
			RETURN 'Salário está ok';
		ELSEIF instrutor.salario = 300 THEN
				RETURN 'Salário pode aumentar';
		ELSE
			RETURN 'Salário está defasado';
		END IF;*/
		
		CASE
			WHEN instrutor.salario = 100 THEN
				RETURN 'Salário muito baixo';
			WHEN instrutor.salario = 200 THEN
				RETURN 'Salário baixo';
			WHEN instrutor.salario = 300 THEN
				RETURN 'Salário ok';
			ELSE
				RETURN 'Salário ótimo';
		END CASE;	
	END;
$$ LANGUAGE plpgsql;

SELECT nome, salario_ok(instrutor.id) FROM instrutor;

-- Return Next (loop)

DROP FUNCTION tabuada;

CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE
		multiplicador INTEGER DEFAULT 1;
	BEGIN
		LOOP
			RETURN NEXT numero || ' x ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador + 1;
			EXIT WHEN multiplicador = 10;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT tabuada(2);

-- WHILE (loop)

DROP FUNCTION tabuada;

CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	DECLARE
		multiplicador INTEGER DEFAULT 1;
	BEGIN
		WHILE multiplicador < 10 LOOP
			RETURN NEXT numero || ' x ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador + 1;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT tabuada(2);

-- FOR (loop)

DROP FUNCTION tabuada;

CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
	BEGIN
		FOR multiplicador IN 1..9 LOOP
			RETURN NEXT numero || ' x ' || multiplicador || ' = ' || numero * multiplicador;
			multiplicador := multiplicador + 1;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT tabuada(2);

-- All In

DROP FUNCTION instrutor_com_salario;

CREATE FUNCTION instrutor_com_salario(OUT nome VARCHAR, OUT salario_ok VARCHAR) RETURNS SETOF record AS $$
	DECLARE
		instrutor instrutor;
	BEGIN
		FOR instrutor IN SELECT * FROM instrutor LOOP
			nome := instrutor.nome;
			salario_ok = salario_ok(instrutor.id); -- tabela puxada da query no início deste script
		
			RETURN NEXT;
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

SELECT * FROM instrutor_com_salario();



















