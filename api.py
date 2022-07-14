from flask import Flask, request
from numpy import byte
# import ml
import json
import something
import base64

app = Flask(__name__)


@app.route('/')
def hello_world():
    return f'Hellos World'


@app.route('/heat_map', methods=['GET'])
def mlapi():
    something.cool()
    d = {}
    with open('Images\\figure1.png', 'rb') as image:
        f = image.read()

        d["img"] = base64.b64encode(f).decode('ascii')
    d['heat_map1'] = 'taco'
    return d


@app.route('/hemoglobin', methods=['GET'])
def hemo():
    # the output image will be determined by the model output (send cuffed image if abnormal and vice versa)
    img1 = (request.args['img1'])
    arr = json.loads(img1)
    bytearr = bytearray(arr)
    with open('test.png', mode='wb') as file:
        file.write(bytearr)

    something.hot()
    d = {}
    with open('Images\\figure3.png', 'rb') as image:
        f = image.read()

        d["img"] = base64.b64encode(f).decode('ascii')
    d['heat_map1'] = 'taco'
    return d


if __name__ == '__main__':
    app.run()
