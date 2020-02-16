-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra. 
-- Escriba el resultado a la carpeta `output` del directorio actual.
--
fs -rm -f -r output ;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

-- Cargamos los archivos
fs -rm -f data.tsv ;
fs -put -f data.tsv ;


datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS (letra:CHARARRAY,
        fecha:CHARARRAY,
        cantidad:INT);



agrupados = GROUP datos BY letra;
contar_letras = FOREACH agrupados GENERATE group, COUNT(datos);

STORE contar_letras INTO 'output' USING PigStorage('\t');

fs -get output ;
