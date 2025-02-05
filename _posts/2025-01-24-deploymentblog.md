---
toc: true
layout: post
title: Deployment blog
description: Written by Kanhay Patil.
permalink: /posts/deploymentkanhay
comments: True
---

# Deploying Neptune: Reaching for the Stars

Neptune is your gateway to a world where students collaborate, connect, and aim for the stars. With features like an AI chatbot, class lists, chatrooms, a friends list, and customizable themes, Neptune fosters a thriving student community.

Follow these steps to deploy Neptune and ensure everything runs smoothly!

---


Use this checklist to track your progress while deploying Neptune:

- [ ] **Install Docker and Docker Compose**
- [ ] **Clone the Repository**
- [ ] **Set Up Environment Variables**
- [ ] **Build Docker Images**
- [ ] **Run the Containers**
- [ ] **Access the Application**
- [ ] **Verify Features**
- [ ] **Implement Security Best Practices**

---

## Step-by-Step Deployment Instructions

### 1. Prerequisites

Ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

If deploying to a remote server, ensure:
- SSH access is available.
- Required ports (e.g., `8204`) are open.

---

### 2. Clone the Repository

Clone the Neptune repository and navigate into the directory:

```bash
git clone https://github.com/your-org/neptune.git
cd neptune
```

---

### 3. Set Up Environment Variables

Create a `.env` file in the root directory and configure the necessary environment variables. You can manually create this file or use an example (`.env.example`).

```env
PORT=8204
DATABASE_URL=<your-database-url>  # Connection string for the database
SECRET_KEY=<your-secret-key>      # Secret key for authentication and security
```

Replace placeholders with the appropriate values for your setup. **Do not share your `.env` file publicly** to protect sensitive information.

---

### 4. Build Docker Images

Run the following command to build the Docker images:

```bash
docker-compose build
```

This pulls necessary images and sets up all services defined in `docker-compose.yml`.

---

### 5. Run the Containers

Start all required services in detached mode:

```bash
docker-compose up -d
```

If issues arise, check logs with:

```bash
docker-compose logs
```

---

### 6. Access Neptune

Once the containers are running, open a web browser and navigate to:

```bash
http://<your-server-ip>:8204
```

Replace `<your-server-ip>` with your actual server's IP address or domain.

For a cloud provider, configure DNS settings for a subdomain (e.g., `neptune.yourdomain.com`).

To secure the connection, set up **SSL certificates** with [Certbot](https://certbot.eff.org/).

---

### 7. Verify Features

Ensure all features are working properly:

- **AI Chatbot** - Responds accurately to student queries.
- **Class List** - Allows students to select and view classes.
- **Chatroom** - Enables real-time communication.
- **Friends List** - Supports adding and managing friends.
- **Theme Customization** - Allows personalized themes.

---

## Notes for Developers

### Port Configuration

Neptune runs on **port 8204** (chosen by us). Ensure this port is open in your server's firewall.

### Error Handling

To diagnose errors, check container logs:

```bash
docker-compose logs
```

### Scaling

For higher traffic, consider scaling using **Docker Swarm** or **Kubernetes** for load balancing and high availability. 

To scale services manually:

```bash
docker-compose up --scale web=3 -d
```

---

## Troubleshooting

### Common Issues & Fixes

#### Containers Fail to Start
Run:
```bash
docker ps -a
```
Check logs for errors:
```bash
docker-compose logs
```

#### Database Connection Issues
- Verify `DATABASE_URL` is correctly set.
- Ensure the database container is running:
  ```bash
  docker-compose ps
  ```

#### Port Conflicts
- Run `netstat -tulnp | grep 8204` to check if another service is using the port.
- Modify the `PORT` variable in `.env` and update `docker-compose.yml` accordingly.

---

## System Architecture

Below is an overview of Neptune's architecture:

![System Architecture](/nolan_2025/images/image.png)

Here is an image of the chatroom in depth, since it uses WebSocket.
![Chatroom](/nolan_2025/images/chatroom.png)

---

## Changing Code in VSCode

To keep deployment working, good practices in your coding process with verifications prior to pushing code to GitHub will save a lot of troubleshooting.

**1. Pull Changes:**

   - **Before making changes:** 
      - **`git pull`** in the VSCode terminal. 
      - This ensures you have the latest code from your team and prevents merge conflicts.

**2. Local Testing:**

   - **Open terminal in VSCode:** `cd` into your repository.
   - **Run:** `python3 main.py` 
   - This starts your Flask application locally.
   - **Open the local address in your browser:** View your changes live.
   - **Make changes:** Refer to your running site frequently to see changes in real-time.

**3. Commit Changes:**

   - **Commit your changes locally:** Use meaningful commit messages.
   - **Do not sync or push yet:** Committing allows you to pull team changes for further verification.

**4. Docker Desktop Testing:**

   - **Start Docker Desktop.**
   - **Run:** `docker-compose up` or `sudo docker-compose up` in the VSCode terminal.
   - **Access the application:** 
      - Open `http://localhost:8204` in your browser 
      - Replace `<port>` with your port number.
   - **Test thoroughly:** Review your changes and team members' changes.
   - **Debug errors:** If any errors occur, they will appear in the browser or VSCode terminal.
   - **Note:** Docker Desktop can consume resources. Close it after testing if you're unplugged.

**5. Push to GitHub:**

   - **If all tests pass:** 
      - **Sync changes** from the VSCode UI or **`git push`** from the terminal.
   - **If you encounter issues:** 
      - **`git status`** to review open files.
      - **Resolve conflicts:** Use `git restore` or `git commit`.
      - **`git pull`** again and repeat steps 2-4.

**6. Deploying to AWS EC2:**

   - **In your AWS EC2 terminal:**
      - **Navigate:** `cd ~/neptune_frontend`
      - **Stop the current deployment:** `docker-compose down`
      - **Verify downtime:** The server should be down (502 Bad Gateway).
      - **Pull changes:** `git pull`
      - **Rebuild:** `docker-compose up -d --build` 
      - **Test again:** The server should be updated and running.

**7. Optional Troubleshooting Checks (AWS EC2):**

   - **Check server status:** `curl localhost:8204`
   - **Verify container status:**
      - `docker-compose ps` 
      - `docker ps` 

      ### Test Server

Ensure that we have a working frontend-to-backend test server. If it does not work locally, there is no need to try it on deployment.

### Subdomain

Setup DNS endpoint through AWS Route 53.

```yml
Server: https://neptune_backend.nighthawkcodingsociety.com/
Domain: nighthawkcodingsociety.com
Subdomain: neptune_backend
```

### Port (Backend)

Select a unique port for the application. Update all locations:

- **main.py**: Prepare the localhost test server port to run on the same port for consistency.
Changed port to 8204
  ```python
  if __name__ == "__main__":
      app.run(debug=True, host="0.0.0.0", port="8204")
  ```

- **Dockerfile**: Prepare this file to run a server as a virtual machine on the deployment host.
  ```dockerfile
  FROM docker.io/python:3.11
  WORKDIR /
  RUN apt-get update && apt-get upgrade -y && \
      apt-get install -y python3 python3-pip git
  COPY . /
  RUN pip install --no-cache-dir -r requirements.txt
  RUN pip install gunicorn
  ENV GUNICORN_CMD_ARGS="--workers=1 --bind=0.0.0.0:8204"
  EXPOSE 8204
  ENV FLASK_ENV=production
  CMD [ "gunicorn", "main:app" ]
  ```

- **docker-compose.yml**: Prepare this file to serve as the “make” for Docker.
  ```yaml
  version: '3'
  services:
      web:
          image: flask2025
          build: .
          env_file:
              - .env
          ports:
              - "8204:8204"
          volumes:
              - ./instance:/instance
          restart: unless-stopped
  ```

- **nginx_file**: Prepare this file for reverse proxy (the way this works is that the information is sent from the internet to the application and back to the requester.)
  ```nginx
  server {
      listen 80;
      listen [::]:80;
      server_name neptune_backend.nighthawkcodingsociety.com;
      location / {
          proxy_pass http://localhost:8204; (MINE)
          if ($request_method = OPTIONS) {
              add_header "Access-Control-Allow-Credentials" "true" always;
              add_header "Access-Control-Allow-Origin"  "https://nighthawkcoders.github.io" always;
              add_header "Access-Control-Allow-Methods" "GET, POST, PUT, DELETE, OPTIONS, HEAD" always;
              add_header "Access-Control-Allow-MaxAge" 600 always;
              add_header "Access-Control-Allow-Headers" "Authorization, Origin, X-Origin, X-Requested-With, Content-Type, Accept" always;
              return 204;
          }
      }
  }
  ```

### Port (Frontend)

Prepare the frontend to access our domain and ports to match our localhost, port 8204 (OURS OURS OURS OURS OURS), and domain settings.

- **assets/api/config.js**:
Changed port to 8204

  ```javascript
  export var pythonURI;
  if (location.hostname === "localhost" || location.hostname === "127.0.0.1") {
      pythonURI = "http://127.0.0.1:8204"; 
  } else {
      pythonURI = "https://neptune.stu.nighthawkcodingsociety.com";
  }
  ```

## Accessing AWS EC2

Login to AWS Console using our account. (Yash321, ask him for password [we know it just don't wanna put in blog])
Access EC2 Dashboard and launch an instance.
Select CSP




## Application Setup

1. **Finding a Port**: Run `docker ps` to make sure port 8204 is open
2. **On localhost setup Docker files using VSCode**: Make sure the Dockerfile and docker-compose.yml match port 8204 on AWS EC2.
- Use docker-compose up in the repo folder
- Access the server after it's done building in browser on localhost:8204

## Server Setup

1. **Clone backend repo**: `git clone https://github.com/DNHS-Neptune/neptune_backend.git`
2. **Navigate to repo**: `cd neptune_backend`
3. **Build site**: `docker-compose up -d --build`
4. **Test site**: `curl localhost:8204`

### Route 53 DNS

Go to AWS Route 53 and setup DNS subdomain for backend server.

### Nginx setup

1. **Navigate to nginx**: `cd /etc/nginx/sites-available`
2. **Create an nginx config file**: `sudo nano neptune_backend`
3. **Activate configuration**: `cd /etc/nginx/sites-enabled`, then `sudo ln -s /etc/nginx/sites-available/neptune_backend /etc/nginx/sites-enabled`
4. **Validate**: `sudo nginx -t`
5. **Restart nginx**: `sudo systemctl restart nginx`

### Certbot Config

Run command below and follow prompts:
```bash
sudo certbot --nginx
```

### Changing Code will require Deployment Updates

1. **Run git pull before making changes**
2. **Open terminal in VSCode and run python main.py**
3. **Make changes that are needed**
4. **Commit the changes locally**
5. **Test docker-compose up or sudo docker-compose up in VSCode terminal**
6. **Sync change from UI/git push from terminal**

### Pulling Changes into AWS EC2 deployment

1. **Navigate to repo**: `cd ~/neptune_backend`
2. **docker-compose down**
3. **git pull**
4. **Rebuild docker container**: `docker-compose up -d --build`

### Troubleshooting checks on AWS EC2

1. **Try to curl**: `curl localhost:8204`
2. **Run docker-compose ps**
3. **Run docker ps**

<h2>First time Install</h2>

<h3>1. In your project directory, create a .env file with passwords of the users</h3>

<h3>2. Run ./scripts/db_init.py</h3>

- This will initialize the database and reset all the data tables.

<h3>3. In your repo run Docker commands</h3>

- Run: ```docker-compose build```
- Run: ```docker-compose up -d```

<h3>Test your server</h3>

- Curl provides text response of your requested page

- Look for your application and port: ```docker ps```
- Verify your application is working: ```curl localhost:8204```

<h3>Note</h3>

- Do not put user passwords in your blogs or in your code since it's a security risk
- Do not commit them to GitHub
- Use the ```.env``` files to store passwords. Add ```.env``` to your ```.gitignore``` file.


---

## **NGINX & Certbot Setup**

### **Route 53 DNS**

Go to AWS Route 53 and set up a DNS subdomain for the backend server.

### **NGINX Setup**

1.  **Go to nginx directory and create an Nginx config file**:
    
    ```bash
    cd /etc/nginx/sites-available
    sudo nano neptune_backend
    
    ```
    
2.  **Add the following config:**
    
    ```nginx
    server {
        listen 80;
        listen [::]:80;
        server_name neptune_backend.nighthawkcodingsociety.com;
        location / {
            proxy_pass http://localhost:8204;
            if ($request_method = OPTIONS) {
                add_header "Access-Control-Allow-Credentials" "true" always;
                add_header "Access-Control-Allow-Origin"  "https://nighthawkcoders.github.io" always;
                add_header "Access-Control-Allow-Methods" "GET, POST, PUT, DELETE, OPTIONS, HEAD" always;
                add_header "Access-Control-Allow-MaxAge" 600 always;
                add_header "Access-Control-Allow-Headers" "Authorization, Origin, X-Origin, X-Requested-With, Content-Type, Accept" always;
                return 204;
            }
        }
    }
    
    ```
    
3.  **Save the file** (`Ctrl + X`, then `Y`, then `Enter`).
    
4.  **Activate configuration**:
    
    ```bash
    cd /etc/nginx/sites-enabled
    sudo ln -s /etc/nginx/sites-available/neptune_backend /etc/nginx/sites-enabled
    
    ```
    
5.  **Check for all proper configs and restart Nginx**:
    
    ```bash
    sudo nginx -t
    sudo systemctl restart nginx
    
    ```
    
6.  **Test if Nginx is serving requests**:  
    Open **[http://neptune_backend.nighthawkcodingsociety.com](http://neptune_backend.nighthawkcodingsociety.com/)** in our browser.
    

----------

### **Certbot Configuration for HTTPS**

Here are all the steps we will follow to install Certbot to deploy our site

1.  **Install Certbot**:
    
    ```bash
    sudo apt-get install certbot python3-certbot-nginx
    ```
    
2.  **Run Certbot to get SSL certificate**:
    
    ```bash
    sudo certbot --nginx
    ```
    
3.  **Follow the prompts**:
    -   Select `neptune_backend.nighthawkcodingsociety.com` from the list.
    -   Choose option `2` because it will redirect us from HTTP to HTTPS, which is more secure.
4.  **Restart Nginx**:
    
    ```bash
    sudo systemctl restart nginx
    ```
    
5.  **Test HTTPS access**:  
    Open **[https://neptune_backend.nighthawkcodingsociety.com](https://neptune_backend.nighthawkcodingsociety.com/)** in our browser.

----------

## **Updating Deployment**

### **Changing Code in VSCode**

Steps:
1.  **Run `git pull` before making changes**.
2.  **Open terminal in VSCode and run `python main.py`**.
3.  **Make changes that are needed**.
4.  **Commit the changes locally**.
5.  **Test `docker-compose up` or `sudo docker-compose up` in VSCode terminal**.
6.  **Push changes to GitHub**.

### **Pulling Changes into AWS EC2 Deployment**

1.  **Navigate to repo**:
    
    ```bash
    cd ~/neptune_backend
    ```
    
2.  **Stop running containers**:
    
    ```bash
    docker-compose down
    ```
    
3.  **Pull the latest code**:
    
    ```bash
    git pull
    ```
    
4.  **Rebuild the docker container**:
    
    ```bash
    docker-compose up -d --build
    ```
    

----------

## **Debugging NGINX**

  - If something fails, we will **check Nginx logs**:
    
    ```bash
    sudo tail -f /var/log/nginx/error.log
    ```

Deployment Tech talk:
Username: Ubuntu
Username: Ubuntu14*&*41 
Three musketterss
  