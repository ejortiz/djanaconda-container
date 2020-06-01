FROM nginx

#RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
COPY certs/site.crt /etc/nginx/certs/site.crt
COPY certs/site.key /etc/nginx/certs/site.key