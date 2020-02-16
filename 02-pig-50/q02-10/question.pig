-- Pregunta
-- ===========================================================================
-- 
-- Ordene el archivo `data.tsv`  por letra y valor (3ra columna).
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
--  >>> Escriba el codigo del mapper a partir de este punto <<<
-- 

fs -rm -f data.tsv ;
fs -put -f data.tsv ;


datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS (letra:CHARARRAY,
        fecha:CHARARRAY,
        cantidad:INT);



datos_ordenados = ORDER datos BY letra,cantidad;


STORE datos_ordenados INTO 'output' USING PigStorage('\t');

fs -get output ;
