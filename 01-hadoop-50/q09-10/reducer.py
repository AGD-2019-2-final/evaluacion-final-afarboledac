import sys
#
#  >>> Escriba el codigo del mapper a partir de este punto <<<
#
import itertools
import pandas as pd

class Reducer:

    def __init__(self, stream):
        self.stream = stream
    
    def emit(self, key, fecha, numero):
        sys.stdout.write("{}\t{}\t{}\n".format(key, fecha, numero))
    
    def reduce(self):
        rows=[]
        columns = ['numero','fecha','letra']
        for key, fecha, letra in self:
            row = [int(key), fecha, letra]
            rows.append(row)
        df = pd.DataFrame(rows, columns=columns).sort_values(by='numero')
        for i in range (0,5):
            numero1, fecha1, letra1 = df[['numero', 'fecha', 'letra']].iloc[i]
            self.emit(key=letra1, fecha=fecha1, numero= numero1)

    def __iter__(self):

        for line in self.stream:
            ##
            ## Lee el stream de datos y lo parte
            ## en (clave, valor)
            ##
            key, fecha, letra = line.strip().split("\t")
            val = float(key)

            ##
            ## retorna la tupla (clave, valor)
            ## como el siguiente elemento del ciclo for
            ##
            yield key, fecha, letra


if __name__ == '__main__':

    reducer = Reducer(sys.stdin)
    reducer.reduce()
