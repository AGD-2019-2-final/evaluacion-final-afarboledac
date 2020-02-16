import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#

class Mapper:

    def __init__(self, stream):
        self.stream = stream

    def emit(self, key, fecha, letra):
        sys.stdout.write("{}\t{}\t{}\n".format(key, fecha, letra))

    def map(self):
        for numero, fecha, letra in self:
            self.emit(key=numero, fecha=fecha, letra = letra)

    def __iter__(self):
        ##
        ## itera sobre cada linea de codigo recibida
        ## a traves del flujo de entrada
        ##
        for line in self.stream:
            letra, fecha, numero = line.strip().split('   ')
            #print(letra, fecha, numero)
            yield int(numero), fecha, letra


if __name__ == "__main__":
    ##
    ## inicializa el objeto con el flujo de entrada
    ##
    mapper = Mapper(sys.stdin)

    ##
    ## ejecuta el mapper
    ##
    mapper.map()
