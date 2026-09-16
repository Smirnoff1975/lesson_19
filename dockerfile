FROM nginx:stable-alpine
LABEL lbl="Lesson nginx:stable-alpine"
COPY index.html /usr/share/nginx/html