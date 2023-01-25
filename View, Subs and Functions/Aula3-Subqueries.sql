SELECT * FROM curso;
SELECT * FROM categoria;

SELECT * FROM curso WHERE categoria_id = 1 OR categoria_id = 2;

--da mesma forma, eu posso usar o IN ()

SELECT * FROM curso WHERE categoria_id IN (1, 2);

-- Queries aninhadas

SELECT * FROM categoria WHERE nome NOT LIKE '% %';

SELECT * FROM curso WHERE categoria_id IN (
	SELECT id FROM categoria WHERE nome NOT LIKE '% %'
);

SELECT curso.nome FROM curso WHERE categoria_id IN (
	SELECT id FROM categoria WHERE nome NOT LIKE '% %'
);

SELECT curso.nome FROM curso WHERE categoria_id IN (
	SELECT id FROM categoria WHERE nome LIKE '% de %'
);

-- Personalizando tabela

SELECT *
  FROM aluno
  JOIN aluno_curso ON aluno_curso.id = curso.id
  JOIN curso ON curso.id = aluno_curso.curso_id
  
  SELECT categoria.nome AS categoria,
         COUNT(curso.id) AS numero_cursos
	FROM categoria
	JOIN curso ON curso.categoria_id = categoria.id
GROUP BY categoria;

  SELECT categoria,
  		 numero_cursos
	FROM (
			SELECT categoria.nome AS categoria,
				   COUNT(curso.id) AS numero_cursos
			  FROM categoria
			  JOIN curso ON curso.categoria_id = categoria.id
			GROUP BY categoria
	 ) AS categoria_cursos
	WHERE numero_cursos > 3;
	
-- Conceito de view: é apenas uma tabela virtual sem condições de alteração dos dados.
-- Queremos apenas nomear consulta, seja para melhorar legibilidade, seja para fornecer
-- acesso ao banco de dados para terceiros.


CREATE VIEW vw_cursos_por_categoria AS SELECT categoria.nome AS categoria,
        COUNT(curso.id) AS numero_cursos
   FROM categoria
   JOIN curso ON curso.categoria_id = categoria.id
GROUP BY categoria

	SELECT * FROM vw_cursos_por_categoria;
	
CREATE VIEW vw_cursos_programacao AS SELECT	nome FROM curso WHERE categoria_id = 2;
	
	SELECT * FROM vw_cursos_programacao;
	
	SELECT * FROM vw_cursos_programacao WHERE nome = 'PHP';
	
	SELECT categoria.id AS categoria_id,
	       vw_cursos_por_categoria
	  FROM vw_cursos_por_categoria 
	  JOIN categoria ON categoria.nome = vw_cursos_por_categoria.categoria;

	