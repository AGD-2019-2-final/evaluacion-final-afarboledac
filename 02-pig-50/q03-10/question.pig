-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

fs -rm -f data.tsv ;
fs -put -f data.tsv ;


datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS (letra:CHARARRAY,
        fecha:CHARARRAY,
        cantidad:INT);


columna_cantidad = FOREACH datos GENERATE cantidad;
datos_ordenados = ORDER columna_cantidad BY cantidad;
primeros_cinco =  LIMIT datos_ordenados 5;


STORE primeros_cinco INTO 'output' USING PigStorage('\t');
fs -get output ;
