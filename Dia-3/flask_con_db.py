from flask import Flask, request
from flask_mysqldb import MySQL

# Devulve todas las variables de entorno de este dispositivo
from os import environ

from dotenv import load_dotenv

load_dotenv()

# print(environ)

app = Flask(__name__)
# Cuando tenemos un diccionario podemos OBTENER el valor de una de sus llaves con el metodo GET (No para asignar valores)
# Si no existe valor colocara None (vacio) 
app.config["MYSQL_HOST"] = environ.get("MYSQL_HOST")
app.config["MYSQL_USER"] = environ.get("MYSQL_USER")
app.config["MYSQL_PASSWORD"] = environ.get("MYSQL_PASSWORD")
app.config["MYSQL_DB"] = environ.get("MYSQL_DB")
app.config["MYSQL_PORT"] = int(environ.get("MYSQL_PORT"))

# print(app.config)

# Cuando a una variable se le asigna una clase se llama INSTANCIA 
# Esto inicializa la conexion seteando los parametros , pero aun NO ESTA CONECTADO
mysql = MySQL(app)

@app.route('/productos', methods=['GET', 'POST'])
def gestion_productos():
    if request.method == 'GET' :
        # Esto crea una conexion a la base de datos mediante un cursor
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM productos")
        productos = cursor.fetchall() # LIMIT INFINITO
        #cursor.fetchone() # LIMIT 1
        # print(productos)
        # Cerrar la conexion
        cursor.close()

        resultado= []
        for producto in productos:
            producto_dic={
                'id': producto[0],
                'nombre': producto[1],
                'imagen': producto[2],
                'fecha:vencimiento': producto[3].strftime('%Y-%m-%d'),#&H:&M:%S
                'precio': producto[4],
                'disponible': producto[5],
                'categoria_id': producto[6],
            }
            resultado.append(producto_dic)
            print(producto_dic)

        return{
        'message' : 'Los productos son ',
        'content' : resultado
    }
    elif request.method == 'POST':
        cursor = mysql.connection.cursor()
        information = request.get_json()
        # El %s covierter el contenido a un string,
        # el %f convierte a flotante ,
        # el % d covierte a entero
        cursor.execute("INSERT INTO productos (id, nombre, imagen, fecha_vencimiento, precio, disponible, categoria_id)VALUES (DEFAULT,'%s','%s','%s',%f,%s,%d)" %(
            information.get('nombre'),
            information.get('imagen'),
            information.get('fecha_vencimiento'),
            information.get('precio'),
            information.get('disponible'),
            information.get('categoria_id'),
        ))
        mysql.connection.commit()
        cursor.close()

        return {
        'message' : 'Producto creado exitosamente'
    }


def validar_producto(id):
    # Creamos la conexion 
        conexion = mysql.connection.cursor()
        # Ejecutamos el select con la clausula del id
        conexion.execute("SELECT * FROM productos WHERE id= %d" % (id))
        # Esto es lo mismo pero agregar la f para dar formato
        # conexion.execute(f"SELECT * FROM productos WHERE id = {id}")
        resultado = conexion.fetchone()
        conexion.close()
        print(resultado)
        return resultado



@app.route("/producto/<int:id>", methods = ['GET', 'PUT', 'DELETE'])
def gestion_un_producto(id):
    if request.method == 'GET':
        resultado = validar_producto(id)
        if resultado is None:
            return{
                'message':'Producto no existe'
            }
        else:
            producto={
                    'id':resultado[0],
                    'nombre':resultado[1],
                    'imagen':resultado[2],
                    'fecha_vencimiento':resultado[3].strftime('%Y-%m-%d'),
                    'precio':resultado[4],
                    'disponible':resultado[5],
                    'categoria_id':resultado[6]
            }

            # conexion.close()
            # print(resultado)        

            return {
                'content':producto                                
            }
    elif request.method == 'PUT':
        # Primero validamos que4 esista el producto
        # conexion = mysql.connection.cursor()
        # conexion.execute(f"SELECT * FROM productos WHERE id = {id}") 
        # resultado = conexion.fetchone()
        resultado = validar_producto(id)
        if resultado is None:
            return{
                'message': 'Producto no existe'
            }
        else:
            data=request.get_json()

            conexion =mysql.connection.cursor()
            conexion.execute("UPDATE productos SET nombre= %s, precio=%s, fecha_vencimiento=%s, categoria_id=%s, disponible=%s, imagen=%s WHERE id = %s" , [
                data.get('nombre'),
                data.get('precio'),
                data.get('fecha_vencimiento'),
                data.get('categoria_id'),
                data.get('disponible'),
                data.get('imagen'),
                resultado[0] # id del producto
            ])
            mysql.connection.commit()
            conexion.close()

            return {
                'message': 'Producto actualizado exitosamente'                
            }
    elif request.method == 'DELETE':
        # DELETE FROM productos WHERE id = .....
        # no se necesita nada del boy 
        # hacer la validacion si el producto no existe 
        resultado = validar_producto(id)
        if resultado is None:
            return{
                'message':'El producto no existe'
            }
        else:
            # data=request.get_json()
            conexion =mysql.connection.cursor()
            # primero eliminar ese producto en los almacenes 
            conexion.execute("DELETE FROM productos WHERE id = %s AND delete_rule='CASCADE' " , [id])
            
            mysql.connection.commit()
            conexion.close()

            return {
                'message': 'Producto ELIMINADO exitosamente'                
            }



























# load_dotenv > cargamos todas las variables definidas en el archivo .env como si fueran variables de entorno

app.run(debug=True,load_dotenv=True)
