from camelcase import CamelCase

#Instancia : Copiar toda la funcionalidad de la clase Camelcase
instancia = CamelCase()
otraInstancia = CamelCase()

texto = "Hola yo deberia estar camel caseado"

resultado = instancia.hump(texto)

print(resultado)

