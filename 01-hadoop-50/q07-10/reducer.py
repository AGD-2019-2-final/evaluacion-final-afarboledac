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
        sys.stdout.write("{}   {}   {}\n".format(key, fecha, numero))
    
    def reduce(self):
        rows=[]
        columns = ['letra','fecha','numero']
        for key, fecha, numero in self:
            row = [key, fecha, numero]
            rows.append(row)
        df = pd.DataFrame(rows, columns=columns).sort_values(['letra', 'numero'])
        for i, j in df.iterrows():
            self.emit(key=j['letra'], fecha=j['fecha'], numero= j['numero']) 

    def __iter__(self):

        for line in self.stream:
            ##
            ## Lee el stream de datos y lo parte
            ## en (clave, valor)
            ##
            key, fecha, numero = line.strip().split("\t")
            numero = int(numero)

            ##
            ## retorna la tupla (clave, valor)
            ## como el siguiente elemento del ciclo for
            ##
            yield   key, fecha, numero 


if __name__ == '__main__':

    reducer = Reducer(sys.stdin)
    reducer.reduce()
