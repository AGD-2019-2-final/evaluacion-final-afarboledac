-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<

--
fs -rm -f data.tsv ;
fs -put -f data.tsv ;

datos = LOAD 'data.tsv' USING PigStorage('\t') AS (letra:CHARARRAY, bolsa: bag{T: tuple(v:CHARARRAY)}, mapa : MAP[]);


letras = FOREACH datos GENERATE FLATTEN(bolsa) AS letra, FLATTEN(KEYSET(mapa)) as llave;

agrupados = GROUP letras BY (letra, llave);
contar_letras = FOREACH agrupados GENERATE group, COUNT(letras);

STORE contar_letras INTO 'output' USING PigStorage('\t');
fs -get output ;
