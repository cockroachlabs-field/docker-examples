FROM nginx:alpine

LABEL maintainer="tjveil@gmail.com"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 5432
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]