import sys
#
# >>> Escriba el codigo del reducer a partir de este punto <<<
#
import itertools

class Reducer:

    def __init__(self, stream):
        self.stream = stream

    def emit(self, key):
        sys.stdout.write("{}\n".format(key))

    def reduce(self):
        for key, value in self:
            self.emit(key=key)

    def __iter__(self):

        for line in self.stream:
            ##
            ## Lee el stream de datos y lo parte
            ## en (clave, valor)
            ##
            key, val = line.strip().split("\t")
            ##
            ## retorna la tupla (clave, valor)
            ## como el siguiente elemento del ciclo for
            ##
            yield (key, val)


if __name__ == '__main__':

    reducer = Reducer(sys.stdin)
    reducer.reduce()