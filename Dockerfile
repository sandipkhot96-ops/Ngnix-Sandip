FROM nginx:stable

# Optional tools
# RUN apt-get update
# RUN apt-get install vim -y

# Copy your custom HTML
COPY index.html /usr/share/nginx/html/index.html
# RUN chown nginx:nginx /usr/share/nginx/html/index.html







