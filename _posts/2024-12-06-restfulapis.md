---
toc: true
layout: post
title: RESTUL APIs
description: This is for the assignment and notes
permalink: /posts/api
comments: True

---

[**link to python flask notebook**](/nolan_2025/2024/12/02/python-flask_in_jupyter_IPYNB_2_.html)

## step 2 (nolan.py)

this my my personal /api file that routes to /api/nolan and returns information about me.

### backend code
```python
from flask import Blueprint, request, jsonify, g
from flask_restful import Api, Resource

nolan_api = Blueprint('nolan_api', __name__, url_prefix='/api')
api = Api(nolan_api)

class NolanAPI:
    class _N_Person(Resource):
        def get(self):
            return jsonify({
                "name": "Nolan Hightower",
                "age": 15,
                "classes": ["Int 3A", "AP CSP", "AP Sem", "Spanish 5", "AP World"],
                "favorite": {
                    "color": "red",
                    "number": 32
                }
            })

api.add_resource(NolanAPI._N_Person, "/nolan")
```

### postman
<image src="/nolan_2025/images/nolan_api.png" alt="postman of nolan's api"/>

## step 3 (custom RESTFUL API)

i created the ability to store images and assign them to a post

### backend code

```python
@app.route('/api/image', methods=['POST'])
def add_img_to_post():
    print("Adding image to post")
    data = request.get_json()

    postId = data.get("postId", "")
    img = data.get("img", "")

    #print(img)
    if not img:
        return jsonify({"error": "No image provided."}), 400

    post = Post.query.get(postId)
    if not post:
        return jsonify({"error": "Post not found."}), 404
    else:
        randomId = str(post.id)
        upload_dir = "nolanuploads"
        if not os.path.exists(upload_dir):
            os.makedirs(upload_dir)
        img_path = os.path.join(upload_dir, f"{randomId}.png")
        with open(img_path, "wb") as img_file:
            img_file.write(base64.b64decode(img.split(",")[1]))

        post._content = {**post._content, "img": f"/nolanuploads/{randomId}.png"}
        post.update()
    return jsonify({"response": "Image added to post"}), 200


@app.route('/nolanuploads/<path:filename>')
def static_uploaded_file(filename):
    return send_from_directory('nolanuploads', filename)
```

**it contains two routes:**

1. POST - /api/image
   takes in id for the post to append the image to and then the image itself in data base64 format
   example data:

```json
{
  "postId": 2,
  "img": "data:..."
}
```

2. GET - /nolanuploads/\*.png
   statically hosts all the images, formatted like `{postid}.png`

### video

<video height="360" width="640" controls>
    <source src="/nolan_2025/videos/images.webm" type="video/webm">
    dumb browser no video support
</video>

### postman photo

<img src="/nolan_2025/images/image_post.png" alt="postman of images api" />
