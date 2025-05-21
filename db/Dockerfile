FROM postgres:latest 
RUN apt-get update -yq && apt-get install -yqq curl
COPY script.sh .
RUN chmod +x script.sh
COPY create.sql .
