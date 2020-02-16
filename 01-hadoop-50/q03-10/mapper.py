import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
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
            val, key = line.strip().split(",")
            key = int(key)
            yield (key, val)


if __name__ == "__main__":
    ##
    ## inicializa el objeto con el flujo de entrada
    ##
    mapper = Mapper(sys.stdin)

    ##
    ## ejecuta el mapper
    ##
    mapper.map()
