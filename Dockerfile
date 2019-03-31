FROM rocker/tidyverse

# setup nginx
RUN apt-get update && \
	apt-get install -y nginx apache2-utils && \
	htpasswd -bc /etc/nginx/.htpasswd test test 

ADD ./nginx.conf /etc/nginx/nginx.conf

# install R packages
RUN install2.r \
   plumber RPostgreSQL #future

EXPOSE 80

ADD . /app
WORKDIR /app

CMD service nginx start && R -e "source('start_api.R')"


# sudo docker build -t ppapi .
#  sudo docker run --rm -p 80:80 -- ppapi
# sudo docker run --rm -p 80:80 --net=host ppapi
# https://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach
