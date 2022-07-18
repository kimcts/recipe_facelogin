import pymysql
from flask import Flask, request
from flask_cors import CORS
from face_rec import FaceRec, faces
from PIL import Image
import base64
import io
import os
import shutil
import time

app = Flask(__name__)
CORS(app)


def sql_data(name):
    result = []
    db = pymysql.connect(host='localhost', user='root', db='linkface', password='1234', charset='utf8')
    curs = db.cursor()
    sql = 'select * from userinfo where user_name="' + name + '"'
    curs.execute(sql)
    rows = curs.fetchall()
    for elements in rows:
        temp = {'key': elements[0], 'id': elements[1], 'password': elements[2]}
        result.append(temp)
    db.commit()
    db.close()
    return result


@app.route('/getData', methods=['POST', 'GET'])
def get_data():
    data = request.get_json()
    result = data['data']
    sql = sql_data(result)
    return {'id': sql[0]['id'], 'password': sql[0]['password']}


@app.route('/username', methods=['POST'])
def get_username():
    data = request.get_json()
    os.rename('unknown/newFace.jpg', './known-people/' + str(data) + '.jpg')
    faces.__init__()
    return 'success'


@app.route('/register', methods=['POST', 'GET'])
def register():
    data = request.get_json()
    directory = './stranger'
    known_directory = './known-people'

    if data:
        if os.path.exists(directory):
            shutil.rmtree(directory)

        if not os.path.exists(directory):
            try:
                os.mkdir(directory)
                time.sleep(1)
                image_src = data['data']
                b = bytes(image_src, 'utf-8')
                image = b[b.find(b'/9'):]
                im = Image.open(io.BytesIO(base64.b64decode(image)))
                im.save(directory + '/unknown.jpg')
                find_face = faces.recognize_faces()

                if find_face == 'unknown':
                    im.save(known_directory + '/newFace.jpg')
                    faces.__init__()
                if find_face == 'newFace':
                    return 'checked'
            except:
                pass
    if os.path.isfile(known_directory + '/newFace.jpg'):
        return 'success'
    return 'fail'


@app.route('/api', methods=['POST', 'GET'])  # image & user data from react
def api():
    data = request.get_json()
    resp = 'unknown'
    directory = './stranger'

    if data:
        if os.path.exists(directory):
            shutil.rmtree(directory)

        if not os.path.exists(directory):
            try:
                os.mkdir(directory)
                time.sleep(1)
                image_src = data['data']
                b = bytes(image_src, 'utf-8')
                image = b[b.find(b'/9'):]
                im = Image.open(io.BytesIO(base64.b64decode(image)))
                im.save(directory + '/unknown.jpeg')

                find_face = faces.recognize_faces()
                print('find_face: ', find_face)

                if find_face != 'unknown':
                    resp = find_face
            except:
                pass
    return resp


if __name__ == '__main__':
    app.run()
