import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#

class Mapper:

    def __init__(self, stream):
        self.stream = stream

    def emit(self, key, value):
        sys.stdout.write("{}\t{}\n".format(key, value))

    def map(self):
        for key, value in self:
            self.emit(key=key, value=value)

    def __iter__(self):
        ##
        ## itera sobre cada linea de codigo recibida
        ## a traves del flujo de entrada
        ##
        for line in self.stream:
            linea = line.strip().split('   ')
            key_fecha= linea[1].split('-')[1]
            yield (key_fecha, 1)


if __name__ == "__main__":
    ##
    ## inicializa el objeto con el flujo de entrada
    ##
    mapper = Mapper(sys.stdin)

    ##
    ## ejecuta el mapper
    ##
    mapper.map()