-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui

-- CREATE TABLE student_prediction(
-- 	student_id SERIAL PRIMARY KEY,
-- 	grade INT,
-- 	father_edu INT,
-- 	mother_edu INT,
-- 	prep_study INT,
-- 	prep_exam INT,
-- 	salary INT
-- );

-- ALTER TABLE student_prediction ALTER COLUMN student_id TYPE VARCHAR(200);

-- SELECT * FROM student_prediction;
-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui

-- DO $$ 
-- DECLARE 
--     cur_phd_pais REFCURSOR; 
--     student_id VARCHAR(200); 
--     father_edu INT; 
--     mother_edu INT; 
--     grade INT;
-- BEGIN 
--     OPEN cur_phd_pais FOR 
--     SELECT student_prediction.student_id, student_prediction.grade, student_prediction.father_edu, student_prediction.mother_edu 
--     FROM student_prediction;
--     LOOP 
--         FETCH cur_phd_pais INTO student_id, grade, father_edu, mother_edu;
--         EXIT WHEN NOT FOUND;
--         IF (father_edu = 6 OR mother_edu = 6) AND grade <> 0 THEN 
-- 		    RAISE NOTICE 'alunos com pais com phd e aprovados: %', student_id;
--         END IF;
--     END LOOP;
--     CLOSE cur_phd_pais;
-- END; 
-- $$

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui

-- DO $$
-- DECLARE
--     cur_aprov_so REFCURSOR;
--     qtd_aprov INT;
--     tabela VARCHAR(100) := 'student_prediction';
-- BEGIN
--     OPEN cur_aprov_so FOR EXECUTE format(
-- 	        'SELECT COUNT(*) FROM %I WHERE grade >= 6 AND prep_study = 1',
-- 	        tabela
-- 	    );
-- 	    FETCH cur_aprov_so INTO qtd_aprov;
--     CLOSE cur_aprov_so;
--     IF qtd_aprov = 0 THEN
--         RAISE NOTICE '%', -1;
--     ELSE
--         RAISE NOTICE 'Resultado: %', qtd_aprov;
--     END IF;
-- END 
-- $$;

-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui

-- DO $$
-- DECLARE
--     cur_prep CURSOR FOR
--         SELECT * FROM student_prediction
--         WHERE salary = 5 AND prep_exam = 2;
--     tupla RECORD;
--     qtd_prep INT := 0;
-- BEGIN
--     OPEN cur_prep;
--     FETCH cur_prep INTO tupla; 
-- 	    WHILE FOUND LOOP
-- 	        qtd_prep := qtd_prep + 1;
-- 	        FETCH cur_prep INTO tupla;
-- 	    END LOOP;
--     CLOSE cur_prep;
--     RAISE NOTICE 'Alunos com salario maior que 410: %', qtd_prep;
-- END;
-- $$

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

DO $$
DECLARE
	cur_delete REFCURSOR;
	tupla RECORD;
BEGIN
	OPEN cur_delete SCROLL FOR
	SELECT
	*
	FROM
	student_prediction;
		LOOP
			FETCH cur_delete INTO tupla;
			EXIT WHEN NOT FOUND;
			IF tupla.grade IS NULL THEN
			DELETE FROM student_prediction WHERE CURRENT OF cur_delete;
			END IF;
		END LOOP;
		LOOP
			FETCH BACKWARD FROM cur_delete INTO tupla;
			EXIT WHEN NOT FOUND;
			RAISE NOTICE '%', tupla;
		END LOOP;
	CLOSE cur_delete;
END;
$$

-- ----------------------------------------------------------------