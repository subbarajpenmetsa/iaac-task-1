#! /bin/bash
sudo yum update -y
sudo sudo amazon-linux-extras install nginx1 -y
sudo systemctl start nginx  
echo "<h1>Welcome to AWS DevOps World!</h1>" | sudo tee /usr/share/nginx/html/index.html