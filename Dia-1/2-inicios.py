from flask import Flask

# Varible que indica si este es el archivo principal de todo mi proyecto
# Si el archivo es el principal del proyecto __name__ será main sino None(vacio)

app = Flask(__name__)

# Patron de diseño de software (Singleton)

# Un decorador se usa con el "@" sirve para modificar el funcionamiento natural
# (es una modificacion parcial) luego de utilizar el decorador 
# se crea una funcion  que sera la nueva funcionalidad de ese metodo
@app.route("/")

def inicio():
    return "Hola desde mi servidor flask"




















# Levanta el servidor
# debug > Cada vez qeu guardemos el archivos actualizara el servidor automaticamente
app.run(debug=True)

# No escribir codigo debajo sino cuelga el servidor