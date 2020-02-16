-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Compute la cantidad de registros por cada letra de la columna 1.
-- Escriba el resultado ordenado por letra. 
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
DROP TABLE IF EXISTS tabla1;
CREATE TABLE tabla1 (
    letra STRING,
    fecha STRING,
    numero INT
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE tabla1;


INSERT OVERWRITE LOCAL DIRECTORY 'output/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT letra, COUNT(1) FROM tabla1 GROUP BY letra ORDER BY letra;
