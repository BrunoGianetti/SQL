CREATE TABLE log_instrutores (
	id SERIAL PRIMARY KEY,
	informacao VARCHAR(255),
	momento_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--

DROP FUNCTION cria_instrutor;

CREATE OR REPLACE FUNCTION cria_instrutor() RETURNS TRIGGER AS $$
	DECLARE
		media_salarial DECIMAL;
		instrutores_recebem_menos INTEGER DEFAULT 0;
		total_instrutores INTEGER DEFAULT 0;
		salario DECIMAL;
		percentual DECIMAL(5,2);
		cusor_salarios refcursor;
	BEGIN
		SELECT AVG(instrutor.salario) INTO media_salarial FROM instrutor WHERE id <> NEW.id;
		
		IF NEW.salario > media_salarial THEN
			INSERT INTO log_instrutores (informacao) VALUES (NEW.nome || ' recebe acima da média');
		END IF;
		
		SELECT instrutores_internos(NEW.id) INTO cursor_salarios;
		LOOP
			FETCH instrutores_internos(NEW.id) INTO cursor_salarios;
			EXIT WHEN NOT FOUND
			total_instrutores := total_intrutores + 1;
			
			IF NEW.salario > salario THEN
				instrutores_recebem_menos := instrutores_recebem_menos + 1;
			END IF;
		END LOOP;
		
		percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;
		ASSERT percentual < 100::DECIMAL, 'Instrutores novos não podem receber mais do que todos os antigos';
		
		
		INSERT INTO log_instrutores (informacao, teste) VALUES (NEW.nome || ' recebe mais do que ' || percentual || '% da grade de instrutores', '');
		
		RETURN NEW;
	
	EXCEPTION
		WHEN undefined_column THEN
			RAISE NOTICE 'Algo de errado ocorrendo';
			RAISE EXCEPTION 'Erro complicado de resolver';
		WHEN raise_exception THEN
			RETURN NEW;
	
	END;

$$ LANGUAGE plpgsql;

-- 

DROP TRIGGER cria_log_instrutores ON instrutor;

CREATE TRIGGER cria_log_instrutores BEFORE INSERT ON instrutor 
	FOR EACH ROW EXECUTE FUNCTION cria_instrutor();

--

SELECT cria_instrutor ('Fulana de tal', 1000);

SELECT * FROM instrutor;

SELECT * FROM log_instrutores;

BEGIN;
INSERT INTO instrutor (nome, salario) VALUES ('Ludovico', 2000);
END;