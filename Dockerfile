# Use an Nginx Alpine image as the base
FROM nginx:alpine

# Copy the local index.html file to the Nginx default public directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80