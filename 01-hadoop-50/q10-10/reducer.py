import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
import itertools
class Reducer:

    def __init__(self, stream):
        self.stream = stream
    
    def emit(self, key, lista):
        sys.stdout.write("{}\t{}\n".format(key, lista))
    
    def reduce(self):
        groups = {}
        for key, group in itertools.groupby(self, lambda x: x[0]):
            groups[key] = list(group)
            lista =[]
            for elemento in groups[key]:
                lista.append(round(elemento[1]))
            #print(key, *sorted(lista), sep = ",")
            lista_lineal = ",".join(str(x) for x in sorted(lista))
            self.emit(key=key, lista=lista_lineal)

    def __iter__(self):

        for line in self.stream:
            ##
            ## Lee el stream de datos y lo parte
            ## en (clave, valor)
            ##
            key, val = line.strip().split("\t")
            val = float(val)

            ##
            ## retorna la tupla (clave, valor)
            ## como el siguiente elemento del ciclo for
            ##
            yield (key, val)


if __name__ == '__main__':

    reducer = Reducer(sys.stdin)
    reducer.reduce()