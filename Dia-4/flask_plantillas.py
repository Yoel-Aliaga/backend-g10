from flask import Flask, render_template
from os import environ
from    dotenv import load_dotenv
load_dotenv()


app = Flask(__name__)


@app.route("/")
def inicio():
    return """
        <p>Hola desde el backend</p>       
        <h1>Hola </H1>  
    """


@app.route("/productos")
def productos():
    # TODO consumir labase de datos para devolver los productos
    lista_productos=[
        {
            'id':1,
            'nombre':'coliflor',
            'precio':4.5
        },
        {
            'id':2,
            'nombre':'berengena',
            'precio':5.8
        },
        {
            'id':3,
            'nombre':'berengena',
            'precio':5.8
        },
    ]



    return render_template("listar-productos.html", nombre='Yoel', lista_productos=lista_productos)














app.run(debug=True)