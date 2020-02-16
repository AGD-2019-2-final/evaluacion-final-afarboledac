import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#
class Mapper:

    def __init__(self, stream):
        self.stream = stream

    def emit(self, key,  fecha, numero):
        sys.stdout.write("{}\t{}\t{}\n".format(key, fecha, numero))

    def map(self):
        for key, fecha, numero in self:
            self.emit(key=key, fecha=fecha,numero=numero)

    def __iter__(self):
        ##
        ## itera sobre cada linea de codigo recibida
        ## a traves del flujo de entrada
        ##
        for line in self.stream:
            key, fecha, numero = line.strip().split('   ')
            yield key, fecha, numero


if __name__ == "__main__":
    ##
    ## inicializa el objeto con el flujo de entrada
    ##
    mapper = Mapper(sys.stdin)

    ##
    ## ejecuta el mapper
    ##
    mapper.map()