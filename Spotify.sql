-- CREATING A TABLE

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify_data (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

SELECT *
FROM spotify_data;


-- EXPLORATORY DATA ANALYSIS


-- Total Records Imported
SELECT COUNT(*)
FROM spotify_data;


-- Total Number of Artists
SELECT COUNT(DISTINCT Artist)
FROM spotify_data;


-- TOTAL NUMBER OF ALBUMS
SELECT COUNT(DISTINCT Album)
FROM spotify_data;


-- ALBUM TYPES
SELECT DISTINCT(Album_type)
FROM spotify_data;


-- TRACK DURATIONS
SELECT MAX(Duration_min)
FROM spotify_data;

SELECT MIN(Duration_min)
FROM spotify_data;


-- CHECKING FOR SONGS WITH 0 DURATION
SELECT *
FROM spotify_data
WHERE Duration_min = 0;


-- REMOVING SONGS WITH 0 DURATION
DELETE FROM spotify_data
WHERE Duration_min = 0;


-- MOST PLAYED-ON CHANNEL
SELECT DISTINCT most_played_on
FROM spotify_data;


-- -----------------------------------
-- BUSINESS QUESTIONS
-- ------------------------------------


-- Retrieve the names of all tracks that have more than 1 billion streams.
 SELECT *
 FROM spotify_data
 WHERE stream > 1000000000;


 -- List all albums along with thier respective artists.
 SELECT
 	album, artist
 FROM spotify_data
 ORDER BY 1;


 -- Total number of comments for tracks where licensed = TRUE.
 SELECT SUM(comments) AS total_comments
 FROM spotify_data
 WHERE licensed = 'true';

SELECT DISTINCT licensed
FROM spotify_data;


 -- Tracks where the album_type is single
 SELECT *
 FROM spotify_data
 WHERE album_type ILIKE 'single';


-- Total number of tracks by each artists
SELECT
	artist,
	COUNT(track) AS total_no_of_songs
FROM spotify_data
GROUP BY artist;


-- Average danceability of tracks in each album
SELECT 
	album, 
	AVG(danceability) AS Average
FROM spotify_data
GROUP BY 1
ORDER BY 2 DESC;


-- Top 5 tracks with the highest energy values.
SELECT 
	track,
	energy
FROM spotify_data
ORDER BY 2 DESC
LIMIT 5;


-- All tracks along with their views and likes where official_video = TRUE
SELECT 
	track,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes
FROM spotify_data
WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- For each album, calculate the total views of all associated tracks.
SELECT 
	album,
	track,
	SUM(views) AS total_views
FROM spotify_data
GROUP BY 1, 2
ORDER BY 3 DESC;


-- Retrieve the track names that have been streamed on spotify more than Youtube.
SELECT track
FROM
(SELECT 
	track,
	-- most_played_on, 
	COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify
FROM spotify_data
GROUP BY 1)
WHERE
	streamed_on_spotify > streamed_on_youtube
	AND
	streamed_on_youtube <> 0;

 
 -- Find the top 3 most viewed tracks for each artist 
WITH ranking_artist AS
(SELECT
 	artist,
	 track,
	 SUM(views) AS total_views,
	 DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
FROM spotify_data
GROUP BY 1, 2
ORDER BY 1, 3 DESC
)
SELECT *
FROM ranking_artist
WHERE rank <= 3


-- Tracks where the liveness score is above the average
SELECT 
	track,
	artist,
	liveness
FROM spotify_data
WHERE liveness > (SELECT AVG(liveness) FROM spotify_data)


-- Calculate the differece between  the highest and lowest energy values for tracks in each album
WITH cte
AS
(SELECT
	album,
	MAX(energy) AS highest_energy,
	MIN(energy) AS lowest_energy
FROM spotify_data
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energy AS energy_diff
FROM cte
ORDER BY 2 DESC


-- How does speechiness affect views, likes or comments?
SELECT
    CORR(speechiness, views) AS corr_speech_views,
    CORR(speechiness, likes) AS corr_speech_likes,
    CORR(speechiness, comments) AS corr_speech_comments
FROM spotify_data;


-- How does views differ for singles and albums
SELECT
    album_type,
    AVG(views) AS avg_views
FROM spotify_data
GROUP BY
    album_type;


-- Tracks that have above-average danceability but below-average views
WITH Averages AS (
    SELECT
        AVG(danceability) AS avg_danceability,
        AVG(views) AS avg_views
    FROM
        spotify_data
)
SELECT
    title,
    danceability,
    views
FROM spotify_data, Averages
WHERE
    danceability > avg_danceability
    AND views < avg_views
ORDER BY 2 DESC;


-- Average engagement per minute of track duration
SELECT
    title,
    (likes / duration_min) AS likes_per_minute,
    (comments / duration_min) AS comments_per_minute
FROM spotify_data
ORDER BY 2, 3 DESC
LIMIT 5;


--  Tracks with unusual liveness compared to its energy
SELECT
    title,
    energy,
    liveness,
    (liveness - energy) AS liveness_energy_gap
FROM spotify_data
ORDER BY 4 DESC
LIMIT 5;

