
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

RUN mod_wsgi-express install-module


# Move the `mod_wsgi` library to the apache modules folder:
RUN mod_wsgi-express install-module

# SKIPPING THIS STEP FOR NOW
# # ...which should give the following output:
# RUN LoadModule wsgi_module /usr/lib/apache2/modules/mod_wsgi-py34.cpython-34m.so
# RUN WSGIPythonHome /home/username/anaconda3

# copy over wsgi config and enable wsgi
COPY wsgi.conf /etc/apache2/mods-available/
COPY wsgi.load /etc/apache2/mods-available
RUN a2enmod wsgi
RUN service apache2 restart

CMD [ "/bin/bash" ]




