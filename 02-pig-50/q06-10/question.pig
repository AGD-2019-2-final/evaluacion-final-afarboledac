-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
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

datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS(letra:CHARARRAY,
        bolsa:CHARARRAY,
        mapa:MAP[]
    );

columna_mapa = FOREACH datos GENERATE mapa;
mapa_llaves = foreach columna_mapa GENERATE KEYSET($0) as llave;
llaves = foreach mapa_llaves generate FLATTEN(llave) as llave;


agrupados = GROUP llaves BY llave;
contar_letras = FOREACH agrupados GENERATE group, COUNT(llaves);

STORE contar_letras INTO 'output' USING PigStorage(',');
fs -get output ;
