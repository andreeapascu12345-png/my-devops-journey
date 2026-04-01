FROM nginx:alpine
COPY index.html /www/data/index.html
RUN echo 'server { listen 8080; location / { root /www/data; index index.html; } }' > /etc/nginx/conf.d/default.conf
RUN touch /tmp/nginx.pid && \
    chown -R 10005:10005 /www/data /var/cache/nginx /tmp/nginx.pid
USER 10005
EXPOSE 8080
CMD ["nginx", "-g", "daemon off; pid /tmp/nginx.pid;"]
