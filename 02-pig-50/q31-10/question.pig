-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f data.csv ;
fs -put -f data.csv ;
-- 
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
columna_year = FOREACH u GENERATE  GetYear( ToDate(birthday, 'yyyy-MM-dd')) as year;
grupo_year = GROUP columna_year BY year;
agrupar_year = FOREACH grupo_year GENERATE group, COUNT(columna_year);


STORE agrupar_year INTO 'output' USING PigStorage(',');
fs -get output ;
