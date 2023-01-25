-- Tudo visto antes é SQL puro
-- Funções em PostgreSQL

SELECT (primeiro_nome || ultimo_nome) AS nome_completo FROM aluno;

SELECT (primeiro_nome ||' '|| ultimo_nome) AS nome_completo FROM aluno; -- Concat

SELECT ('Vinicius' || ' ' || NULL); -- Resulta null sem concat

SELECT CONCAT('Vinicius', NULL); -- Agora sim com concat

SELECT CONCAT('Vinicius', NULL, 'Dias'); -- Dessa forma o Null é ignorado

-- na documentação oficial do Postgre tem todas as funções

SELECT UPPER(CONCAT('Vinicius', ' ', 'Dias')); -- É possível juntar funções

SELECT TRIM(UPPER(CONCAT('Vinicius', ' ', 'Dias')) || ' '); -- Eliminando espaços

-- Funções de Data

SELECT (primeiro_nome ||' '|| ultimo_nome) AS nome_completo, 
       (NOW()::DATE - data_nascimento) / 365 AS idade
  FROM aluno;

-- Mas temos uma função

SELECT (primeiro_nome ||' '|| ultimo_nome) AS nome_completo, 
       (NOW()::DATE - data_nascimento) / 365 AS idade
  FROM aluno;
  
SELECT (primeiro_nome ||' '|| ultimo_nome) AS nome_completo, 
       AGE(data_nascimento) AS idade
  FROM aluno;
  
SELECT (primeiro_nome ||' '|| ultimo_nome) AS nome_completo, 
       EXTRACT(YEAR FROM AGE(data_nascimento)) AS idade
  FROM aluno;
  
-- Funções matemáticas

SELECT pi();

SELECT @ 172348814;

-- Conversões de dados

SELECT NOW()::DATE;

SELECT TO_CHAR(NOW(), 'DD/MM/YYYY');
SELECT TO_CHAR(NOW(), 'DD/MONTH/YYYY');

SELECT TO_CHAR(128.3::REAL, '999D99');
