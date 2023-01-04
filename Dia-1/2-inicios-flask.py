from flask import Flask, request
from flask_cors import CORS

# Varible que indica si este es el archivo principal de todo mi proyecto
# Si el archivo es el principal del proyecto __name__ será main sino None(vacio)

app = Flask(__name__)

# No se recomienda permitir todo, pero se hace asi:
# Permitir todos los origenes: origins = "*"
# Permitir todos los methods: methods = "*"

# Ahora configuramos nuestro CORS (CoOntrol de acceso de Recursos Cruzados)
CORS(app=app, origins=['http://127.0.0.1:5500','http://localhost:5500'], methods=['GET','POST'])

# Patron de diseño de software (Singleton)
usuarios = [
    {
        'nombre': "Eduardo",
        'apellido': 'Jaurez'
    },
    {
        'nombre': 'Juana',        
        'apellido': 'Rodriguez'
    },
    {
        "nombre": "Roberto",
        "apellido": "Castillo"
    },
]

# Patron de diseño de software (Singleton)

# Un decorador se usa con el "@" sirve para modificar el funcionamiento natural
# (es una modificacion parcial) luego de utilizar el decorador
# se crea una funcion  que sera la nueva funcionalidad de ese metodo


@app.route("/")
def inicio():
    return "Hola desde mi servidor flask"


@app.route("/mostrar-hora", methods=["GET", "POST"])
def mostrarHora():
    # CONTROLLER (Controlador) > Es la funcionalidaa qye se realiza dentro de determinado endpoint
    # request > Nos da toda la informacion que viene desde el cliente (Navegador, IP, metodo, etc)
    print(request.method)
    if request.method == "GET":
        return {
            "content": "Me hiciste GET"
        }
    elif request.method == "POST":
        return {
            "content": "Me hiciste POST"
        }

    # Esta parte del codigo sera inaccesible ya que los metodos para acceder sera GET y POST según 
    # lo indicado arriba
    # no se suele retornar string sino se utiliza diccionarios
    return {
        "content": "22:50:15"
    }



@app.route("/usuarios", methods=["GET", "POST"])
def gestionUsuario():
    if request.method == "GET":
        #Devolver usuario
        return{
            "message": " Los usuarios son",
            "content" : usuarios          
        }
    elif request.method == "POST":
        # Agregar nuevo usuario
        print(request.get_json())
        # get_json convierte el json en un diccionario
        data = request.get_json()
        usuarios.append(data)
        return{
            "message": "usuario agregado exitosamente"
        }



# Levanta el servidor
# debug > Cada vez qeu guardemos el archivos actualizara el servidor automaticamente
app.run(debug=True)

# No escribir codigo debajo sino cuelga el servidor
