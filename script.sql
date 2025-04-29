-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui

CREATE TABLE student_prediction(
	student_id SERIAL PRIMARY KEY,
	grade INT,
	father_edu INT,
	mother_edu INT,
	prep_study INT,
	prep_exam INT,
	salary INT
);

ALTER TABLE student_prediction ALTER COLUMN student_id TYPE VARCHAR(200);

SELECT * FROM student_prediction;
-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------