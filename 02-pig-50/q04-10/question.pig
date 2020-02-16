--
-- Pregunta
-- ===========================================================================
-- 
-- El archivo `truck_event_text_partition.csv` tiene la siguiente estructura:
-- 
--   driverId       INT
--   truckId        INT
--   eventTime      STRING
--   eventType      STRING
--   longitude      DOUBLE
--   latitude       DOUBLE
--   eventKey       STRING
--   correlationId  STRING
--   driverName     STRING
--   routeId        BIGINT
--   routeName      STRING
--   eventDate      STRING
-- 
-- Escriba un script en Pig que carge los datos y obtenga los primeros 10 
-- registros del archivo para las primeras tres columnas, y luego, ordenados 
-- por driverId, truckId, y eventTime. 
--
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f truck_event_text_partition.csv ;
fs -put -f truck_event_text_partition.csv ;

-- 
--  >>> Escriba su respuesta a partir de este punto <<<
-- 


--fs -put truck_event_text_partition.csv

datos = LOAD 'truck_event_text_partition.csv' USING PigStorage(',')
    AS (driverId:INT,
        truckId:INT,
        eventTime:CHARARRAY,
        eventType:CHARARRAY,
        longitude:DOUBLE,
        latitude:DOUBLE,
        eventKey:CHARARRAY,
        correlationId:CHARARRAY,
        driverName:CHARARRAY,
        routeId:CHARARRAY,
        routeName:CHARARRAY,
        eventDate:CHARARRAY
        );

tres_columnas = FOREACH datos GENERATE driverId, truckId, eventTime;
primeros_diez =  LIMIT tres_columnas 10;
datos_ordenados = ORDER primeros_diez BY driverId, truckId, eventTime;


STORE datos_ordenados INTO 'output' USING PigStorage(',');
fs -get output ;
