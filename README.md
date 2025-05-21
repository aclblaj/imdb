# imdb
clone imdb database into docker container
# description
creates a container based on the postgres latest (Dockerfile) using docker compose

into the container runs scripts that, 

  creates a database and its structure called imdb 
  
  if not exists creates a directory called imdbarchive 
  
  downloads the dataset to it
  
  unpacks each zip file
  
  restores the tsv file
  
  removes the tsv and gz files
# run with 
docker compose up
