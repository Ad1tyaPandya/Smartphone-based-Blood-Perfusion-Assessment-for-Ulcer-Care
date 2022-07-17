from flask import Flask, request
from numpy import byte
# import ml
import json
import something
import base64
import os
import subprocess
import time

app = Flask(__name__)


@app.route('/')
def hello_world():
    return f'Hellos World'


@app.route('/heat_map', methods=['GET'])
def mlapi():

    vid1 = request.args['vid1']
    arr = json.loads(vid1)
    bytearr = bytearray(arr)
    # print(arr)
    input_path = '/heatmap_input'
    joined_input_path = os.path.join(input_path, "input1.mp4")
    with open('input1.mp4', mode='wb') as file:
        file.write(bytearr)
    # outputfile = (joined_input_path.replace('.avi', '.mp4'))
    # subprocess.call(['ffmpeg', '-i','-y', joined_input_path,
    #                 os.path.join(input_path, "input.avi")])
    # print("starting")
    # time.sleep(3)
    # something.cool()
    # print('stopping')
    d = {}
    with open('Images/figure2.png', 'rb') as image:
        f = image.read()

        d["img"] = base64.b64encode(f).decode('ascii')
    d['heat_map1'] = 'taco'
    return d


@app.route('/hemoglobin', methods=['GET'])
def hemo():
    # the output image will be determined by the model output (send cuffed image if abnormal and vice versa)
    # vid1 = (request.args['vid1'])
    # vid2 = request.args['vid2']
    # arr = json.loads(vid1)
    # arr2 = json.laods(vid2)
    # bytearr = bytearray(arr)
    # bytearr2 = bytearray(arr2)
    # with open('vid650', mode='wb') as file:
    #     file.write(bytearr)
    # with open('vid950', mode='wb') as file:
        # file.write(bytearr2)

    # something.hot()
    d = {}
    with open('output/oxy.png', 'rb') as image:
        f = image.read()

        d["img"] = base64.b64encode(f).decode('ascii')
    with open('output/deoxy.png','rb') as image:
        f = image.read()
        d['img2'] = base64.b64encode(f).decode('ascii')
    d['heat_map1'] = 'taco'
    return d


if __name__ == '__main__':
    app.run(host='0.0.0.0',port=8080, debug = True)
