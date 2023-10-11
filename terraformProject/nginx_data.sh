#!/bin/bash
sudo yum update
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo '<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
            margin: 0;
            padding: 100px;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Congratulations for Successful installation of NGINX on Amazon EC2 instance upon $(hostname -f)</h1>
</body>
</html>' | sudo tee /usr/share/nginx/html/index.html
