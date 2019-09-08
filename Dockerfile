
# start from anaconda base image
FROM continuumio/anaconda3

# set environment path for conda
ENV PATH /opt/conda/bin:$PATH
RUN conda --version


# update debian from anaconda image
RUN apt-get update

# install apache webserver
RUN yes | apt-get install apache2 apache2-bin apache2-dev

RUN yes| conda install -c anaconda pip 

# install django and other packages
RUN yes | pip install django django-analytical django-sendfile django-allauth mod_wsgi \
  flake8 nose mock coverage pygments lxml cssselect docutils \
  hovercraft rst2pdf pillow

# RUN mod_wsgi-express install-module

CMD [ "/bin/bash" ]




