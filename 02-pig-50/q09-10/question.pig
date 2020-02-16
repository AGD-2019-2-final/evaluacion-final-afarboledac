-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.csv` escriba una consulta en Pig que genere la 
-- siguiente salida:
-- 
--   Vivian@Hamilton
--   Karen@Holcomb
--   Cody@Garrett
--   Roth@Fry
--   Zoe@Conway
--   Gretchen@Kinney
--   Driscoll@Klein
--   Karyn@Diaz
--   Merritt@Guy
--   Kylan@Sexton
--   Jordan@Estes
--   Hope@Coffey
--   Vivian@Crane
--   Clio@Noel
--   Hope@Silva
--   Ayanna@Jarvis
--   Chanda@Boyer
--   Chadwick@Knight
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f data.csv ;
fs -put -f data.csv ;
--


----fs -put data.csv

datos = LOAD 'data.csv' USING PigStorage(',') AS (id:INT,
        firstname:CHARARRAY,
        surname:CHARARRAY,
        birtday:CHARARRAY,
        color:CHARARRAY,
        quantity:INT);


mail = FOREACH datos GENERATE CONCAT(firstname, '@', surname); 
STORE mail INTO 'output' USING PigStorage('\t');
fs -get output ;
