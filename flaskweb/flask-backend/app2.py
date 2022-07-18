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

pre_b = None
pre_image = None
pre_im = None


def sql_data(name):
    print('sql_data: ', name)
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
    print('sql: ', sql)
    print('re data: ', result)
    return {'id': sql[0]['id'], 'password': sql[0]['password']}


@app.route('/username', methods=['POST'])
def get_username():
    data = request.get_json()
    print('사용자 이름: ', data)
    os.rename('unknown/newFace.jpg', './known-people/' + str(data) + '.jpg')
    return 'success'


@app.route('/register', methods=['POST', 'GET'])
def register():
    data = request.get_json()
    directory = './stranger'
    known_directory = './known-people'
    unknown_directory = './unknown'

    if os.path.exists(directory):
        shutil.rmtree(directory)
    os.mkdir(directory)
    time.sleep(1)
    result = data['data']
    key = data['key']

    global pre_b, pre_image, pre_im
    if not os.listdir('unknown'):
        pre_b = bytes(result, 'utf-8')
        pre_image = pre_b[pre_b.find(b'/9'):]
        pre_im = Image.open(io.BytesIO(base64.b64decode(pre_image)))
        pre_im.save(unknown_directory + '/unknown' + str(key) + '.jpg')
        return 'fail'
    pre_im = Image.open(io.BytesIO(base64.b64decode(pre_image)))
    pre_im.save(unknown_directory + '/unknown' + str(key) + '.jpg')
    pre_b = bytes(result, 'utf-8')
    pre_image = pre_b[pre_b.find(b'/9'):]
    pre_im = Image.open(io.BytesIO(base64.b64decode(pre_image)))
    pre_im.save(unknown_directory + '/unknown' + str(key) + '.jpg')

    b = bytes(result, 'utf-8')
    image = b[b.find(b'/9'):]
    im = Image.open(io.BytesIO(base64.b64decode(image)))
    im.save(directory + '/unknown.jpeg')
    # im.save(unknown_directory + '/unknown' + key + '.jpg')
    check = faces.register_faces()
    if check == 'success':
        # im.save(known_directory + '/newFace.jpg')
        pre_im.save(known_directory + '/newFace.jpg')
        # if os.path.exists('./unknown'):
        #     for file in os.scandir('./unknown'):
        #         os.remove(file)
    return check


@app.route('/api', methods=['POST', 'GET'])  # image & user data from react
def api():
    data = request.get_json()
    resp = 'unknown'
    directory = './stranger'
    known_directory = './known-people'
    if data:
        if os.path.exists(directory):
            shutil.rmtree(directory)

        if not os.path.exists(directory):
            try:
                os.mkdir(directory)
                time.sleep(1)
                result = data['data']
                b = bytes(result, 'utf-8')
                image = b[b.find(b'/9'):]
                im = Image.open(io.BytesIO(base64.b64decode(image)))
                im.save(directory + '/unknown.jpeg')  # + user key

                find_face = faces.recognize_faces()
                print('find_face: ', find_face)

                if find_face:
                    resp = find_face
                elif find_face == 'unknown':
                    # im.save(known_directory + '/unknown' + str(data['key']) + '.jpeg')
                    resp = 'unknown'
            except:
                pass

    return resp


if __name__ == '__main__':
    app.run()
