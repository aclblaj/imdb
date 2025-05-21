CREATE TABLE IF NOT EXISTS title_ratings (tconst VARCHAR(10),average_rating NUMERIC,num_votes integer);
CREATE TABLE IF NOT EXISTS name_basics (nconst varchar(10), primaryName text, birthYear smallint, deathYear smallint, primaryProfession text, knownForTitles text );
CREATE TABLE IF NOT EXISTS title_akas (titleId TEXT, ordering INTEGER, title TEXT, region TEXT, language TEXT, types TEXT, attributes TEXT, isOriginalTitle BOOLEAN);
CREATE TABLE IF NOT EXISTS title_basics (tconst TEXT, titleType TEXT, primaryTitle TEXT, originalTitle TEXT, isAdult BOOLEAN, startYear SMALLINT, endYear SMALLINT, runtimeMinutes INTEGER, genres TEXT);
CREATE TABLE IF NOT EXISTS title_crew (tconst TEXT, directors TEXT, writers TEXT);
CREATE TABLE IF NOT EXISTS title_episode (const TEXT, parentTconst TEXT, seasonNumber TEXT, episodeNumber TEXT);
CREATE TABLE IF NOT EXISTS title_principals (tconst TEXT, ordering INTEGER, nconst TEXT, category TEXT, job TEXT, characters TEXT);