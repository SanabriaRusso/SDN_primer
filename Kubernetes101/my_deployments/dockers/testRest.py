from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/system")
def system():
    name = 'Docker'
    mail = 'my_email@gmail.com'
    return jsonify(
            system=name,
            email=mail
            )

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5200)

