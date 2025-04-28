# **Spotify Music Engagement Project**

Music engagement isn't just about plays — it's about energy, mood, and true fan interaction. In this project, I explored Gorillaz' Spotify dataset, analyzing energy, emotions, and cross-platform performance to uncover deep insights that raw views alone can't show.

Skills and Tools:

PostgreSQL (Window Functions, CTEs, Correlation Analysis)

Data Cleaning and Transformation

Business Insight Generation

## Overview

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

