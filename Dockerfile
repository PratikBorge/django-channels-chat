FROM ubuntu:22.04
LABEL devops="prat"

USER root
WORKDIR /opt/
RUN  apt update 
RUN  apt install git  python3 -y
RUN  apt install python3-pip -y
RUN  git clone https://github.com/PratikBorge/django-channels-chat.git
WORKDIR /opt/django-channels-chat/
RUN pip install pipenv
RUN pipenv --python 3 shell
RUN  pipenv install
RUN mysql -u root -proot -e "CREATE DATABASE chat CHARACTER SET utf8;"
RUN redis-server
RUN ./manage.py migrate
RUN ./manage.py test
RUN ./manage.py createsuperuser
RUN ./manage.py runserver

EXPOSE  8000  