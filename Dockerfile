
# start from anaconda base image
FROM continuumio/anaconda3

ARG django_app_dir=django-apps
ARG project_name=mainsite
ARG environment_name=env
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
  hovercraft rst2pdf pillow pyscopg2

RUN mod_wsgi-express install-module


# Move the `mod_wsgi` library to the apache modules folder:
RUN mod_wsgi-express install-module

# NOTE: SAMPLE FOR ENVIRONMENT CREATION
# RUN conda create --name ${environment_name} python=3
# RUN echo ${environment_name}
# RUN activate ${environment_name}

# copy over wsgi config and enable wsgi
# NOTE: edit the wsgi.conf and wsgi.load if anaconda python versions are upgraded or renamed
COPY wsgi.conf /etc/apache2/mods-available/
COPY wsgi.load /etc/apache2/mods-available/
COPY django-site.conf /etc/apache2/sites-available
RUN a2enmod wsgi
RUN a2ensite django-site

# create django project
WORKDIR /var/www/
RUN mkdir ${django_app_dir}
WORKDIR ${django_app_dir}

RUN django-admin startproject ${project_name}

RUN cp /var/www/${django_app_dir}/${project_name}/${project_name}/wsgi.py /var/www/${django_app_dir}/${project_name}/wsgi.py
COPY wsgi.py /var/www/${django_app_dir}/${project_name}/wsgi.py
COPY settings.py /var/www/${django_app_dir}/${project_name}/${project_name}/settings.py

WORKDIR ${project_name}
RUN mkdir static
RUN python ./manage.py collectstatic --noinput
WORKDIR /var/www/${django_app_dir}
RUN chown -R :www-data ./

# disable default site
RUN a2dissite 000-default.conf

# Run apache in the foreground, else apache2 will be detached from the shell
CMD apachectl -D FOREGROUND





