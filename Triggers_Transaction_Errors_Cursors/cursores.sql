CREATE FUNCTION instrutores_internos(id_instrutor INTEGER) RETURNS refcursor AS $$
	DECLARE
		cursor_salario refcursor;
		salario DECIMAL;
	BEGIN
    	OPEN cursor_salario FOR SELECT instrutor.salario 
								  FROM instrutor 
								 WHERE id <> id_instrutor 
								   AND salario > 0;
		-- Move e Busca os valores
		FETCH LAST FROM cursor_salario INTO salario;
		FETCH NEXT FROM cursor_salario INTO salario;
		FETCH PRIOR FROM cursor_salario INTO salario;
		FETCH FIRST FROM cursor_salario INTO salario;
		-- Move o cursor para os valores
		MOVE LAST FROM cursor_salario;
		MOVE NEXT FROM cursor_salario;
		MOVE PRIOR FROM cursor_salario;
		MOVE FIRST FROM cursor_salario;
		
		-- Fechamos o cursos no TRIGGER criado anteriormente
		RETURN cursor_salario;
	END;

$$ LANGUAGE plpgsql;