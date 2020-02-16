import sys
#
#  >>> Escriba el codigo del reducer a partir de este punto <<<
#
import itertools

class Reducer:

    def __init__(self, stream):
        self.stream = stream

    def emit(self, key, value):
        sys.stdout.write("{}\t{}\n".format(key, value))

    def reduce(self):
        for key, group in itertools.groupby(self, lambda x: x[0]):
            maximo_grupo = max(group)
            self.emit(key=key, value=maximo_grupo[1])

    def __iter__(self):

        for line in self.stream:
            ##
            ## Lee el stream de datos y lo parte
            ## en (clave, valor)
            ##
            key, val = line.split("\t")
            val = int(val)

            ##
            ## retorna la tupla (clave, valor)
            ## como el siguiente elemento del ciclo for
            ##
            yield (key, val)


if __name__ == '__main__':

    reducer = Reducer(sys.stdin)
    reducer.reduce()