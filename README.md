# **🎧Spotify Music Data Analysis with SQL**

This project focuses on analyzing a dataset combining Spotify and YouTube music data using SQL. The goal was to extract valuable insights on track popularity, artist performance, and user engagement across platforms.

Using SQL, I cleaned the data and performed various analyses to explore streaming patterns, compare views and likes across official and unofficial videos, and examine how musical attributes like energy, danceability, and speechiness relate to audience engagement. I also investigated platform preferences (Spotify vs YouTube) and ranked top-performing tracks by artist.

## **🔧 Setup Instructions**

1. Clone this repository or download the SQL script file.

2. Set up a PostgreSQL or compatible SQL environment.

3. Import your dataset or use a sample dataset with columns matching the script.

4. Run the SQL script in sequence to create the table, clean the data, and execute the analysis queries.

**Note: Ensure your database supports functions like CORR(), DENSE_RANK(), and CTEs.**

# **Overview**

```sql
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
```

# **Query Highlights**

- Removed invalid data entries (e.g., tracks with 0 duration).

- Compared track streams on Spotify vs YouTube.

- Identified tracks with over 1 billion streams.

- Ranked top 3 most viewed tracks for each artist using window functions.

- Explored the relationship between track attributes (e.g., energy, speechiness) and engagement metrics.

- Analyzed average views for singles vs albums.
