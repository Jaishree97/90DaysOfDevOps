FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY index.html .

RUN echo "Website Ready"

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
