-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
-- aparece cada letra minúscula en la columna 2.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f data.tsv ;
fs -put -f data.tsv ;

--
-- >>> Escriba su respuesta a partir de este punto <<<
--

--fs -put data.tsv

datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS(letra:CHARARRAY,
        bolsa:CHARARRAY,
        mapa:CHARARRAY
    );

columna_bolsa = FOREACH datos GENERATE bolsa;


letras = FOREACH columna_bolsa GENERATE FLATTEN(TOKENIZE(bolsa)) AS letra;
agrupados = GROUP letras BY letra;
contar_letras = FOREACH agrupados GENERATE group, COUNT(letras);
limite =  LIMIT contar_letras 7;


STORE limite INTO 'output' USING PigStorage('\t');
fs -get output ;
