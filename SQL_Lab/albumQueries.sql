# Computer Science II
# Lab 8.0 - Structured Query Language II
# Queries
#
# Name(s): Kayla Bartlett
#
#
#
# Part 3.2

-- New tables

drop table if exists Venue;
drop table if exists Concert;
drop table if exists ConcertSong;

create table Venue (
  venueId int not null primary key auto_increment,
  name varchar(100),
  location varchar(50),
  capacity int not null
);

create table Concert (
  concertId int not null primary key auto_increment,
  venueId int not null,
  bandId int not null,
  concertDate varchar(50),
  foreign key(bandId) references Band(bandId),
  foreign key(venueId) references Venue(venueId)
);

create table ConcertSong (
	concertSongId int not null primary key auto_increment,
	concertId int not null,
	songId int not null,
	foreign key(concertId) references Concert(concertId),
	foreign key(songId) references Song(songId)
);

# 1. Choose your favorite album and insert it into the database by doing the
#   following.
#   1.  Write a query to insert the band of the album 

insert into Band(name) 
values ('Fall out Boy');

#   2.  Write a query to insert the album 

insert into Album(title, year, number, bandID) 
values ('So Much (For) Stardust', 2023, 8, (select bandID from Band where name = 'Fall out Boy'));

#   3.  Write two queries to insert the first two songs of the album

insert into Song(title) 
values ('So Much (For) Stardust');

insert into Song(title) 
values ('Love From The Other Side');

#   4.  Write two queries to associate the two songs with the inserted album

insert into AlbumSong (albumId, songId, tracknumber, tracklength)
select albumId, songId, 1, 291
from Album, Song
where Album.title = 'So Much (For) Stardust' 
and Song.title = 'So Much (For) Stardust';

insert into AlbumSong (albumId, songId, tracknumber, tracklength)
select albumId, songId, 2, 279
from Album, Song
where Album.title = 'So Much (For) Stardust' 
and Song.title = 'Love From The Other Side';

# 2. Update the musician record for "P. Best", his first name should be "Pete".

update Musician
set firstName ='Pete'
where lastName = 'Best' and firstName = 'P.';

# 3. Pete Best was the Beatles original drummer, but was fired in 1962. 
#    Write a query that removes Pete Best from the Beatles.

Delete from BandMember
where musicianId = (select musicianId from Musician 
where lastName = 'Best' and firstName = 'Pete')
and bandId = (select bandId from Band 
where name = 'The Beatles');

# 4. Attempt to delete the song "Big in Japan" (by Tom Waits on the album
#    *Mule Variations*).  Observe that the query will fail due to referencing
#    records. Write a series of queries that will allow you to delete the 
#    album *Mule Variations*.

set foreign_key_checks = 0;

delete from AlbumSong
where albumId = (select albumId from Album 
where title = 'Mule Variations');

delete from Song
where title = 'Big in Japan';

delete from Album
where title = 'Mule Variations';

set foreign_key_checks = 1;

# Part 3.2.2
# Write quries to create your new tables for concerts, venues, etc. here:

-- those are at the top

# Part 3.3.3
# 
# Insert some test data to your new tables
#
-- Venue
insert into Venue (name, location, capacity)
values ('CHI Health Center', 'Omaha, Ne', 17560);

insert into Venue (name, location, capacity)
values ('Target Center', 'Minneapolis, MN', 20000);

-- Concerts

insert into Concert (bandId, venueID, concertDate)
select bandId, venueId, '2024-05-04'
from Band, Venue
where Band.name = 'Fall Out Boy' 
and Venue.name = 'CHI Health Center';

insert into Concert (bandId, venueID, concertDate)
select bandId, venueId, '2024-06-04'
from Band, Venue
where Band.name = 'Fall Out Boy' 
and Venue.name = 'Target Center';


# 1.  Write queries to insert at least two `Concert` records.



# 2.  Write queries to associate at least 2 songs with each of the two concerts

insert into ConcertSong (concertId, songId)
select Concert.concertId, Song.songId
from Concert, Song
where Concert.concertId = (select concertId from Concert where venueId = (select venueId from Venue where name = 'CHI Health Center'))
and Song.title = 'So Much (For) Stardust';

insert into ConcertSong (concertId, songId)
select Concert.concertId, Song.songId
from Concert, Song
where Concert.concertId = (select concertId from Concert where venueId = (select venueId from Venue where name = 'CHI Health Center'))
and Song.title = 'Love From The Other Side';

insert into ConcertSong (concertId, songId)
select Concert.concertId, Song.songId
from Concert, Song
where Concert.concertId = (select concertId from Concert where venueId = (select venueId from Venue where name = 'Target Center'))
and Song.title = 'So Much (For) Stardust';

insert into ConcertSong (concertId, songId)
select Concert.concertId, Song.songId
from Concert, Song
where Concert.concertId = (select concertId from Concert where venueId = (select venueId from Venue where name = 'Target Center'))
and Song.title = 'Love From The Other Side';

SELECT * FROM Concert;
SELECT * FROM Venue;
SELECT * FROM Band;
SELECT * FROM ConcertSong;
SELECT * FROM Song;

# 3.  Write a select-join query to retrieve these new results and produce
#     a playlist for each concert

select c.concertId, v.name as venue, c.concertDate, b.name as band, s.title as song
from Concert c
join Venue v on c.venueId = v.venueId
join Band b on c.bandId = b.bandId
join ConcertSong cs on c.concertId = cs.concertId
join Song s on cs.songId = s.songId
order by c.concertId, s.title;
