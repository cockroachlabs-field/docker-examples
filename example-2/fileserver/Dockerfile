FROM nginx:alpine

LABEL maintainer="tjveil@gmail.com"

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /mnt/cockroach-backups/bank-backup
RUN chmod -R 777 /mnt/cockroach-backups

EXPOSE 20150

CMD ["nginx", "-g", "daemon off;"]