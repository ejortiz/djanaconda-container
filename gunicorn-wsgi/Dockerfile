# start from anaconda base image
FROM continuumio/anaconda3

ARG django_app_dir=django-apps
ARG project_name=mainsite
ARG environment_name=env
ARG project_path=/opt/www/
# set environment path for conda
ENV PATH /opt/conda/bin:$PATH
RUN conda --version
# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1



# update debian from anaconda image
RUN apt-get update

RUN yes| conda install -c anaconda pip 

# install django and other packages
RUN yes | pip install django django-analytical django-sendfile django-allauth \
  flake8 nose mock coverage pygments lxml cssselect docutils \
  hovercraft rst2pdf pillow djangorestframework psycopg2-binary
#
## create django project path
RUN mkdir ${project_path}
WORKDIR ${project_path}
RUN mkdir ${django_app_dir}
WORKDIR ${django_app_dir}

COPY ./mainsite /opt/www/${django_app_dir}
#RUN django-admin startproject ${project_name}

COPY wsgi.py /opt/www/${django_app_dir}/${project_name}/wsgi.py
#COPY settings.py /opt/www/${django_app_dir}/${project_name}/${project_name}/settings.py

#WORKDIR ${project_name}
#RUN mkdir static
RUN python ./manage.py collectstatic --noinput
WORKDIR /opt/www/${django_app_dir}
RUN chown -R :www-data ./
#COPY mainsite/entrypoint.sh /opt/www/${django_app_dir}/entrypoint.sh
RUN chmod +x /opt/www/${django_app_dir}/entrypoint.sh
#ENTRYPOINT ["/opt/www/mainsite/entrypoint.sh"]
#EXPOSE 8000
CMD ["/bin/bash", "entrypoint.sh"]

