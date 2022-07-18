import face_recognition
import numpy as np
import os


class FaceRec:
    def __init__(self):
        self.unknown_images_path_file = 'stranger'
        self.known_names = []
        self.known_encodings = []
        dirname = 'known-people'
        files = os.listdir(dirname)
        for filename in files:
            name, ext = os.path.splitext(filename)
            if ext == '.jpg':
                self.known_names.append(name)
                pathname = os.path.join(dirname, filename)
                img = face_recognition.load_image_file(pathname)
                face_encoding = face_recognition.face_encodings(img)[0]
                self.known_encodings.append(face_encoding)
        self.face_locations = []  #
        self.face_encodings = []  #
        self.face_names = []
        self.process_this_frame = True

    def recognize_faces(self):
        for file in os.listdir(self.unknown_images_path_file):
            if file[0] != '.':
                known_face_encodings = self.known_encodings
                known_face_names = self.known_names

                unknown_image = face_recognition.load_image_file(self.unknown_images_path_file + '/' + file)

                face_locations = face_recognition.face_locations(unknown_image)
                face_encodings = face_recognition.face_encodings(unknown_image, face_locations)

                name = 'unknown'
                for face_encoding in face_encodings:
                    matches = face_recognition.compare_faces(known_face_encodings, face_encoding)

                    face_distances = face_recognition.face_distance(known_face_encodings, face_encoding)
                    best_match_index = np.argmin(face_distances)

                    if matches[best_match_index]:
                        name = known_face_names[best_match_index]
                        return name
                print('name: ', name)
                return name

    def register_faces(self):
        register_names = []
        register_encodings = []
        reg_dirname = 'unknown'
        reg_files = os.listdir(reg_dirname)
        for reg_filename in reg_files:
            name, ext = os.path.splitext(reg_filename)
            if ext == '.jpg':
                register_names.append(name)
                pathname = os.path.join(reg_dirname, reg_filename)
                img = face_recognition.load_image_file(pathname)
                face_encoding = face_recognition.face_encodings(img)[0]
                register_encodings.append(face_encoding)
        for file in os.listdir(self.unknown_images_path_file):
            if file[0] != '.':
                reg_face_encodings = register_encodings
                reg_face_names = register_names

                unknown_image = face_recognition.load_image_file(self.unknown_images_path_file + '/' + file)

                face_locations = face_recognition.face_locations(unknown_image)
                face_encodings = face_recognition.face_encodings(unknown_image, face_locations)

                for face_encoding in face_encodings:
                    matches = face_recognition.compare_faces(reg_face_encodings, face_encoding)
                    name = 'unknown'

                    face_distances = face_recognition.face_distance(reg_face_encodings, face_encoding)
                    best_match_index = np.argmin(face_distances)

                    if matches[best_match_index]:
                        name = reg_face_names[best_match_index]

                    print('name: ', name)
                    if name == 'unknown':
                        return 'fail'
                    else:
                        return 'success'
                return 'fail'


faces = FaceRec()
