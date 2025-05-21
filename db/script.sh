#!/bin/bash
# This script downloads the IMDB dataset and restores it to a PostgreSQL database
# create a database called imdb 
# create a directory called imdbarchive 
# download the dataset to it
# unpack each zip file
# restore the tsv file
# remove the tsv and gz files

WORKDIR="/imdbarchive"
FILES=(
    "title.akas.tsv.gz"
    "title.basics.tsv.gz"
    "title.crew.tsv.gz"
    "title.episode.tsv.gz"
    "title.principals.tsv.gz"
    "title.ratings.tsv.gz"
    "name.basics.tsv.gz"
)

# check if folder exists
if [ -d $WORKDIR ]; then
    echo "directory $WORKDIR already exists - clean/remove the data volume in order to do the download again"
    exit 1
else
    echo "creating directory $WORKDIR"
    mkdir $WORKDIR
fi

# sleep and wait for postgres to start
echo "waiting for PostgreSQL to start"
while ! pg_isready -q -h localhost -p 5432 -U postgres; do
    sleep 5
done
echo "PostgreSQL is up and running"

cd $WORKDIR

echo "create database structure"
psql -U postgres -c 'CREATE DATABASE imdb;'
psql -U postgres -d imdb -a -f ../create.sql

# for each file name create the url
for file in "${FILES[@]}"; do
    # create the url
    url="https://datasets.imdbws.com/$file"
    # download the file
    echo "downloading $url"
    echo curl -O "$url"
	curl -O "$url"
    # check if the file was downloaded
    if [ $? -ne 0 ]; then
        echo "Error downloading $url"
#        exit 1
    fi
    # check if the file is a gzip file
    if [[ $file == *.gz ]]; then
        # unpack the file
        echo "unpacking $file"
        echo gunzip "$file"
		    gunzip "$file"
        # check if the file was unpacked
        if [ $? -ne 0 ]; then
            echo "Error unpacking $file"
#            exit 1
        fi
    fi

    # remove the .gz extension (title.akas.tsv.gz)
    tsvfile="${file%.gz}"
    # remove the .tsv extension (title.akas.tsv)
    file="${tsvfile%.tsv}"

    # convert filename to table name (title.akas to title_akas)
    table_name="${file//./_}"

    # restore the able data
    echo "restoring $tsvfile into $table_name"
    echo psql -d imdb -U postgres -c "COPY ${table_name} FROM '$(pwd)/${tsvfile}' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"
	  psql -d imdb -U postgres -c "COPY ${table_name} FROM '$(pwd)/${tsvfile}' DELIMITER E'\t' QUOTE E'\b' NULL '\N' CSV HEADER"

    # remove the file
    echo "removing $tsvfile"
    echo rm -fr "$WORKDIR/$tsvfile"
	  rm -fr "$WORKDIR/$tsvfile"

done
