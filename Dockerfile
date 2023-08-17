# Use a lightweight web server as the base image
FROM nginx:latest

# Set the working directory in the image
WORKDIR /usr/share/nginx/html

# Copy the application files into the image
COPY index.html .
COPY style.css .
COPY script.js .

# Expose the port the application will listen on
EXPOSE 80

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]

