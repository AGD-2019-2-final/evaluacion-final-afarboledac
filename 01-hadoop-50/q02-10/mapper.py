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
        for purpose in self:
            self.emit(key=purpose[0], value=purpose[1])

    def __iter__(self):
        ##
        ## itera sobre cada linea de codigo recibida
        ## a traves del flujo de entrada
        ##
        for line in self.stream:
            purpose = line.split(",")[3]
            amount = line.split(",")[4]

            yield purpose, amount


if __name__ == "__main__":
    ##
    ## inicializa el objeto con el flujo de entrada
    ##
    mapper = Mapper(sys.stdin)

    ##
    ## ejecuta el mapper
    ##
    mapper.map()
