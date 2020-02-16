-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f data.tsv ;
fs -put -f data.tsv ;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

----fs -put data.tsv

prueba = LOAD 'data.tsv' USING PigStorage('\t') AS (letra:CHARARRAY, bolsa: bag{T: tuple(v:CHARARRAY)}, mapa : MAP[]);

lista_letra_size = FOREACH prueba GENERATE letra, SIZE(bolsa), SIZE(mapa);

datos_ordenados = ORDER lista_letra_size BY $0,$1,$2;


STORE datos_ordenados INTO 'output' USING PigStorage(',');
fs -get output ;


