---
layout: post
title: RESTUL APIs
description: This is for the assignment and notes
permalink: /posts/api
comments: True
---

## My FYU Page Feature (uses already existing api)

- fetches all the posts from the channel
- iterates through each posts and then creates and appends an element based on the data

### video

here is a video of this feature

<video height="360" width="640" controls>
    <source src="/nolan_2025/videos/posts.webm" type="video/webm">
    dumb browser no video support
</video>

### code

here is the frontend code if you want a closer look:

```js
let _posts = await fetch(`${pythonURI}/api/posts/filter`, {
  ...fetchOptions,
  method: "POST",
  body: JSON.stringify({ channel_id: channelId }),
});
let posts = await _posts.json();
console.log(1, posts[0]);

let postsContainer = document.getElementById("posts");
posts.reverse().forEach((post) => {
  let postElement = document.createElement("div");
  postElement.className = "post";
  postElement.innerHTML = `
        <h3>${post.title}</h3>
        <p><strong>Author:</strong> ${post.user_name}</p>
        <p>${post.comment}</p>

        <br />
        <p><strong>Likes:</strong> ${post.content.likes}</p>
        <button onclick="likePost(${post.id}, '${post.title}', ${channelId}, ${post.content.likes})">Like</button>

        <img src="${pythonURI}/nolanuploads/${post.id}.png" style="width: 100%; margin-top: 10px" />
      `;

  postElement.style.backgroundColor = "rgba(0, 0, 0, 0.25)";
  postElement.style.borderRadius = "10px";
  postElement.style.border = "2px solid white";
  postElement.style.padding = "15px";
  postsContainer.appendChild(postElement);
});
```

## dynamic data (custom RESTFUL API)

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

<img src="/nolan_2025/images/image_post.png" />
