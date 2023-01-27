-- Select genérico
SELECT *
  FROM academico.curso
  JOIN academico.categoria ON academico.categoria.id = academico.curso.categoria_id
 WHERE categoria_id = 2;
 
-- Select específico

SELECT academico.curso.id,
       academico.curso.nome
  FROM academico.curso
  JOIN academico.categoria ON academico.categoria.id = academico.curso.categoria_id
 WHERE categoria_id = 2;
 
--

CREATE TEMPORARY TABLE cursos_programacao (
	id_curso INTEGER PRIMARY KEY,
	nome_curso VARCHAR(255) NOT NULL
);

-- É inviável fazer isso na mão para uma quantidade de cursos infindável
INSERT INTO cursos_programacao VALUES (4, 'PHP'), (5, 'Java'), (6, 'C++');

-- Portanto eu uso um SELECT num INSERT para compor valores numa tabela.

INSERT INTO cursos_programacao

SELECT academico.curso.id,
       academico.curso.nome
  FROM academico.curso
 WHERE categoria_id = 2;
 
DROP TABLE cursos_programacao

SELECT * FROM cursos_programacao

-- Para o Postgree, a ordem importa. É necessário manter a ordem no SELECT

-- Importação e Exportação de arquivos

CREATE SCHEMA teste;
CREATE TABLE teste.cursos_programacao (
	id_curso INTEGER PRIMARY KEY,
	nome_curso VARCHAR(255) NOT NULL
);

INSERT INTO teste.cursos_programacao
SELECT academico.curso.id,
       academico.curso.nome
  FROM academico.curso
 WHERE categoria_id = 2;

SELECT * FROM teste.cursos_programacao;

-- Alteração/Atualização de tabelas e sincronização de Schemas.

UPDATE academico.curso SET nome= 'C++ básico' WHERE id = 6;

SELECT * FROM academico.curso ORDER BY id;

UPDATE teste.cursos_programacao SET nome_curso = nome
  FROM academico.curso WHERE teste.cursos_programacao.id_curso = academico.curso.id
  AND academico.curso.id < 10;
  
-- Sempre fazer um SELECT antes de um DELETE ou um UPDATE

DELETE FROM cursos_programacao; -- aqui eu removo tudo!

SELECT * FROM teste.cursos_programacao; -- Primeiro isso!

DELETE FROM teste.cursos_programacao WHERE id_curso = 10; -- Depois isso!

-- Transações (Conceito do 'checkpoint')

BEGIN; -- Inicio a transação (pode ser feito com TRANSACTION também)
DELETE FROM teste.cursos_programacao WHERE id_curso=60; -- deleto dado da tabela
COMMIT; -- salva a modificação após DELETE
ROLLBACK; -- volto para trás antes do delete
-- ao se desconectar do servidor sem salvar, automaticamente o Postgre faz o ROLLBACK
SELECT * FROM teste.cursos_programacao;

-- Sequências

CREATE SEQUENCE eu_criei;

SELECT CURRVAL('eu_criei');-- ERROR:  currval of sequence "eu_criei" is not yet defined in this session
SELECT NEXTVAL('eu_criei');-- registra e avança a numeração
-- voltando ao CURRVAL(), agora ele devolve o valor corrente

CREATE TEMPORARY TABLE auto (
	id INTEGER PRIMARY KEY DEFAULT NEXTVAL('eu_criei'),
	nome VARCHAR(30) NOT NULL
);

DROP TABLE auto;

CREATE TEMPORARY TABLE auto (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(30) NOT NULL
);

INSERT INTO auto (nome) VALUES ('Vinicius Dias');
INSERT INTO auto (id, nome) VALUES (2, 'Vinicius Dias');
INSERT INTO auto (nome) VALUES ('Outro nome'); -- Rodando a primeira vez dá erro. 
-- Rodando novamente corrige exatamente porque o mecanismo de sequência do 
-- Postgre (SERIAL) voltou a funcionar na posição correta.

SELECT * FROM auto

-- Tipos

CREATE TYPE CLASSIFICACAO AS ENUM('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS');

CREATE TEMPORARY TABLE filme (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	-- classificacao VARCHAR(255) CHECK (classificacao IN ('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS'))
	-- classificacao ENUM ('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS') -- mesma coisa da linha anterior, mas mais suscinto
	classificacao CLASSIFICACAO
);

INSERT INTO filme (nome, classificacao) VALUES ('Um filme qualquer', '18_ANOS');

SELECT * FROM filme;








