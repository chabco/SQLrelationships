create table artist (
id SERIAL not null primary key,
name varchar
);

create table album (
id SERIAL not null primary key,
name varchar,
release_year int not null,
artist_id int references artist (id)
);

create table track (
id SERIAL not null primary key,
duration int not null,
album_id int references album (id)
);

create table song (
id SERIAL not null primary key,
name varchar,
track_id int references track (id),
song_writer_id int references song_writer (id)
);

create table song_writer (
id SERIAL not null primary key,
name varchar
);

insert into artist values
(default, 'ludachris'),
(default, 'ti'),
(default, 'eminem'),
(default, 'ice-cube'),
(default, 'lil yachty');

select * from artist;

------------------------------------------------------------------------------------------------
insert into album values
--ludachris 1
(default, 'boom1', 1960, 1),
(default, 'boom2', 1963, 1),

--ti 2
(default, 'sleep1', 1965, 2),
(default, 'sleep2', 1995, 2),
(default, 'sleep3', 2001, 2),

--eminem 3
(default, 'hello1', 1968, 3),
(default, 'hello2', 1989, 3),

--ice-cube 4
(default, 'great1', 1964, 4),
(default, 'great2', 1976, 4),
(default, 'great3', 1978, 4),
(default, 'great4', 1983, 4),

--lil yachty 5
(default, 'lol1', 1959, 5),
(default, 'lol2', 1999, 5);

select * from album;

------------------------------------------------------------------------------------------------
insert into track values

--boom1
(default, 250,  1),
(default, 200,  1),

--boom2
(default, 180,  2),
(default, 190,  2),

--sleep1
(default, 220,  3),
(default, 210,  3),
--sleep2
(default, 230,  4),
(default, 210,  4),
--sleep3
(default, 220,  5),
(default, 190,  5),

--hello1
(default, 300,  6),
(default, 120,  6),
--hello2
(default, 190,  7),
(default, 230,  7),

--great1
(default, 250,  8),
(default, 270,  8),
(default, 250,  8),
(default, 270,  8),
--great2
(default, 210,  9),
(default, 190,  9),
--great3
(default, 410,  10),
(default, 100,  10),
(default, 210,  10),
(default, 100,  10),
--great4
(default, 190,  11),
(default, 320,  11),

--lol1
(default, 400,  12),
(default, 100,  12),
--lol2
(default, 90,  13),
(default, 80,  13),
(default, 190,  13);

select * from track;

------------------------------------------------------------------------------------------------
insert into song values
--boom 1
(default, 'love', 1, 1),
(default, 'heart', 2, 2),


--boom2
(default, 'yea', 3, 1),
(default, 'yes', 4, 3),


--sleep1
(default, 'hard', 5, 1),
(default, 'tough', 6, 4),


--sleep2
(default, 'meow', 7, 1),
(default, 'prrr', 8, 5),


--sleep3
(default, 'woof', 9, 2),
(default, 'bark', 10, 3),

--hello1
(default, 'boo', 11, 2),
(default, 'goo', 12, 2),
--hello2
(default, 'slow', 13, 3),
(default, 'grow', 14, 3),

--great1
(default, 'oop', 15, 3),
(default, 'boop', 16, 4),
(default, 'toop', 17, 5),
(default, 'doop', 18, 5),
--great2
(default, 'ma', 19, 1),
(default, 'ca', 20, 2),
--great3
(default, 'wee', 21, 1),
(default, 'tee', 22, 1),
(default, 'yee', 23, 1),
(default, 'bee', 24, 4),
--great4
(default, 'yot', 25, 2),
(default, 'got', 26, 3),

--lol1
(default, 'sad', 27, 3),
(default, 'bad', 28, 5),
--lol2
(default, 'was', 29, 4),
(default, 'does', 30, 5),
(default, 'cuz', 31, 4);


select * from song;

------------------------------------------------------------------------------------------------
insert into song_writer values
(default, 'jojo'),
(default, 'drake'),
(default, 'monty'),
(default, 'cat'),
(default, 'dog');

select * from artist;
select * from song_writer;
select * from album;
select * from song;
select * from track;


------------------------------------------------------------------------------------------------

--	1.	What are tracks for a given album?
select song.name
from track, song, album
where song.track_id = track.id
	and track.album_id = album.id
	and album.name = 'sleep2';
	
--	2.	What are the albums produced by a given artist?
select album.name
from album, artist
where album.artist_id = artist.id
	and artist.name = 'ti';
	
--	3.	What is the track with the longest duration?
select song.name, track.id, track.duration
from song, track
order by track.duration desc
limit 1;

--	4.	What are the albums released in the 60s? 70s? 80s? 90s?
select album.name, album.release_year
from album
where album.release_year between 1960 and 1969;

select album.name, album.release_year
from album
where album.release_year between 1970 and 1979;

select album.name, album.release_year
from album
where album.release_year between 1980 and 1989;

select album.name, album.release_year
from album
where album.release_year between 1990 and 1999;

--	5.	How many albums did a given artist produce in the 90s?
select count(album.id)
from album
where album.release_year between 1990 and 1999;

--	6.	What is each artist's latest album?
select artist.name, max(album.release_year)
from artist, album
where album.artist_id = artist.id
group by artist.id;

--	7.	List all albums along with its total duration based on summing the duration of its tracks.
select album.name, sum(track.duration)
from album, track
where album_id = album.id
group by album.id;

--	8.	What is the album with the longest duration?
select album.name, sum(track.duration)
from album, track
where album_id = album.id
group by album.id
order by sum(track.duration) desc
limit 1;

--	9.	Who are the 3 most prolific artists based on the number of albums they have recorded?
select artist.name, count(album.id)
from artist, album
where artist_id = artist.id
group by artist.id
order by count(album.id) desc
limit 3;

--	10.	What are all the tracks a given artist has recorded?
select track.id
from track, album, artist
where artist_id = artist.id
	and album_id = album.id
	and artist.name = 'lil yachty';
	
--	11.	What are the top 5 most often recorded songs?
select song.name, count(track.id)
from track, song
where track_id = track.id
group by song.name
order by count(track.id) desc
limit 5;

--	12.	Who are the top 5 song writers whose songs have been most often recorded?
select song_writer.name, count(song.id)
from song_writer, song
where song_writer_id = song_writer.id
group by song_writer.name
order by count(song.id) desc
limit 3;

--	13.	Who is the most prolific song writer based on the number of songs he has written?
select song_writer.name, count(song.id)
from song_writer, song
where song_writer_id = song_writer.id
group by song_writer.name
order by count(song.id) desc
limit 1;

--	14.	What songs has a given artist recorded?
select song.name, artist.name
from song, track, artist, album
where track_id = track.id
	and artist_id = artist.id
	and album_id = album.id
	and artist.name = 'ice-cube';
	
--	15.	Who are the song writers whose songs a given artist has recorded? --
select song_writer.name, count(song.id)
from song_writer, song, track, album, artist
where song_writer_id = song_writer.id
	and song.track_id = track.id
	and album.artist_id = artist.id
	and artist.name = 'lucachris'
group by song_writer.name;

--	16.	Who are the artists who have recorded a given song writer's songs?
select artist.name, count(song.id)
from song_writer, song, album, artist, track
where song_writer.id = song.song_writer_id
	and track_id = track.id
	and album_id = album.id
	and artist.id = album.artist_id
	and song_writer.name = 'drake'
group by artist.id;



