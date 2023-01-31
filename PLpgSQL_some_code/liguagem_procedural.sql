DROP FUNCTION primeira_pl();

CREATE OR REPLACE FUNCTION primeira_pl() RETURNS INTEGER AS $$
	BEGIN
		-- Vários comandos em SQL
		RETURN 1;
	END
$$ LANGUAGE plpgsql;

SELECT primeira_pl();

-- Declarações de variáveis

CREATE OR REPLACE FUNCTION primeira_pl() RETURNS INTEGER AS $$
	DECLARE
		primeira_variavel INTEGER DEFAULT 3;
	BEGIN
		primeira_variavel := primeira_variavel * 2;
		-- Vários comandos em SQL
		RETURN primeira_variavel;
	END
$$ LANGUAGE plpgsql;

SELECT primeira_pl();

-- Eu também posso utilizar o '=' em vez de ':=', mas com certeza eu acabarei
-- em conflitos com comparações booleanas futuramente

-- Blocos e sublocos

CREATE OR REPLACE FUNCTION primeira_pl() RETURNS INTEGER AS $$
	DECLARE
		primeira_variavel INTEGER DEFAULT 3;
	BEGIN
		primeira_variavel := primeira_variavel * 2;
		DECLARE
			primeira_variavel INTEGER;
		BEGIN
			primeira_variavel := 7;
		END;
		
		RETURN primeira_variavel;
	END
$$ LANGUAGE plpgsql;

SELECT primeira_pl();

-- Se dentro do subloco eu declarar uma variável de mesmo nome do bloco
-- anterior, o retorno será a variável original, do bloco pai.
-- No entanto, se eu retiro o 'DECLARE' do subloco, aí sim eu tenho um
-- novo valor sendo assumido para a variável.




