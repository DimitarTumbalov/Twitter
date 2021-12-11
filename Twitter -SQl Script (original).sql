create database Twitter;

go

use Twitter;

create table Genders(
	id int not null identity(1, 1) primary key,
	[name] varchar(10) not null
);

create table Countries(
	id int not null identity(1, 1) primary key,
	[name] varchar(20) not null
);

create table Users (
	id int not null identity(1, 1) primary key,
	username varchar(15) not null unique,
	display_name varchar(50) not null,
	[password] varchar(50) not null,
	date_of_birth date not null,
	email varchar(100) null,
	phone int null,
	gender_id int null foreign key references Genders(id) on delete set null,
	country_id int null foreign key references Countries(id) on delete set null,
	is_protected bit not null,
	bio varchar(160) null,
	website varchar(100) null,
	sign_up date not null,
	last_sign_in date not null
);

create unique index unique_email
  on Users(email)
  where email is not null;

create unique index unique_phone
on Users(phone)
where phone is not null;

create table UsersFollowers(
	follower_id int not null foreign key references Users(id),
	followee_id int not null foreign key references Users(id) on delete cascade,
	[timestamp] datetime not null
);

create unique index uq_UsersFollowers
  on dbo.UsersFollowers(follower_id, followee_id);

create table Sources(
	id int not null identity(1, 1) primary key,
	name varchar(50) unique not null
);

create table Topics(
	id int not null identity(1, 1) primary key,
	[name] varchar(30) unique not null
);

create table TopicsFollowers(	
	topic_id int not null foreign key references Topics(id) on delete cascade,
	[user_id] int not null foreign key references Users(id) on delete cascade
);

create unique index uq_TopicsFollowers
  on dbo.TopicsFollowers(topic_id, user_id);

create table Spaces(
	id int not null identity(1, 1) primary key,
	[name] varchar(50) not null,
	[host_id] int not null foreign key references Users(id) on delete cascade,
	start_time datetime not null
);

create table SpacesRoles(
	id int not null identity(1, 1) primary key,
	[name] varchar(10) not null,
)

create table SpacesUsers(
	space_id int not null foreign key references Spaces(id) on delete cascade,
	[user_id] int not null foreign key references Users(id),
	[role_id] int not null foreign key references SpacesRoles(id)
);

create table Communities(
	id int not null identity(1, 1) primary key,
	[name] varchar(50) not null,
	[description] varchar(160) null,
	admin_id int not null foreign key references Users(id) on delete cascade,
	created_on date not null
);

create table BasicRoles(
	id int not null identity(1, 1) primary key,
	[name] varchar(10) not null,
)

create table CommunitiesUsers(
	community_id int not null foreign key references Communities(id) on delete cascade,
	[user_id] int not null foreign key references Users(id),
	[role_id] int not null foreign key references BasicRoles(id)
);

create table Statuses(
	id int not null identity(1, 1) primary key,
	author_id int not null foreign key references Users(id) on delete cascade,
	[message] varchar(280) not null,
	source_id int null foreign key references Sources(id) on delete set null,
	topic_id int null foreign key references Topics(id) on delete set null,
	created_at datetime not null,
	community_id int null foreign key references Communities(id),
	quoted_status_id int null foreign key references Statuses(id),
	replied_status_id int null foreign key references Statuses(id),
);

create table Likes(
	[user_id] int not null foreign key references Users(id),
	status_id int not null foreign key references Statuses(id) on delete cascade,
	[timestamp] datetime not null
);

create unique index uq_Likes
  on dbo.Likes(user_id, status_id);

create table Retweets(	
	[user_id] int not null foreign key references Users(id),
	status_id int not null foreign key references Statuses(id) on delete cascade,
	[timestamp] datetime not null
);

create unique index uq_Retweets
  on dbo.Retweets(user_id, status_id);

create table Bookmarks(	
	[user_id] int not null foreign key references Users(id),
	status_id int not null foreign key references Statuses(id) on delete cascade,
	added_at datetime not null
);

create unique index uq_Bookmarks
  on dbo.Bookmarks(user_id, status_id);

create table Lists(
	id int not null identity(1, 1) primary key,
	owner_id int not null foreign key references Users(id),
	[name] varchar(25) not null,
	[description] varchar(160) null,
	is_private bit not null
);

create table ListsStatuses(
	list_id int not null foreign key references Lists(id) on delete cascade,
	status_id int not null foreign key references Statuses(id) on delete cascade,
	added_at datetime not null
);

create table ListsUsers(
	id int not null identity(1, 1) primary key,
	[user_id] int not null foreign key references Users(id),
	list_id int not null foreign key references Lists(id) on delete cascade,
	[role_id] int not null foreign key references BasicRoles(id)
);

create table DirectMessages(
	sender_id int not null foreign key references Users(id) on delete cascade,
	receiver_id int not null foreign key references Users(id),
	message varchar(8000) not null,
	timestamp datetime not null
);

/* Data Warehouse Statuses */
create table DimAuthor(
	id int not null identity(1, 1) primary key,
	alt_id int not null foreign key references Users(id),
	username varchar(15) not null,
	display_name varchar(50) not null,
	date_of_birth datetime not null,
	gender varchar(10) null,
	country varchar(20) null,
);

create table DimMessage(
	id int not null identity(1, 1) primary key,
	[message] varchar(280) not null,
	[language] varchar(20) not null
);

create table DimTopic(
	id int not null identity(1, 1) primary key,
	alt_id int null foreign key references Topics(id),
	[name] varchar(30) null,
	references_count int null
);

create table DimSource(
	id int not null identity(1, 1) primary key,
	alt_id int null foreign key references Sources(id),
	[name] varchar(50) null,
	references_count int null
);

create table DimTime(
	id int not null identity(1, 1) primary key,
	calendar_year int not null,
	calendar_quarter int not null,
	month_of_year int not null,
	month_name nvarchar(10) not null,
	day_of_month int not null,
	day_of_week int not null,
	day_name nvarchar(15) not null
);

create table FactStatuses(
	id int not null identity(1, 1) primary key,
	author_id int not null foreign key references DimAuthor(id),
	message_id int not null foreign key references DimMessage(id),
	topic_id int null foreign key references DimTopic(id),
	source_id int null foreign key references DimSource(id),
	time_id int null foreign key references DimTime(id),
	impressions_count int not null,
	likes_count int not null,
	retweets_count int not null,
	quote_tweets_count int not null,
	replies_count int not null,
	lists_count int not null,
	updated_at datetime not null,
	operation char(3) not null
);

 /* Data Warehouse Users */
create table DimCountry(
	id int not null identity(1, 1) primary key,
	alt_id int not null foreign key references Countries(id),
	[name] varchar(20) not null
);

create table DimGender(
	id int not null identity(1, 1) primary key,
	alt_id int not null foreign key references Genders(id),
	[name] varchar(20) not null
);

create table DimSignUp(
	id int not null identity(1, 1) primary key,
	calendar_year int not null,
	calendar_quarter int not null,
	month_of_year int not null,
	month_name nvarchar(10) not null,
	day_of_month int not null,
	day_of_week int not null,
	day_name nvarchar(15) not null
);

create table DimLastSignIn(
	id int not null identity(1, 1) primary key,
	calendar_year int not null,
	calendar_quarter int not null,
	month_of_year int not null,
	month_name nvarchar(10) not null,
	day_of_month int not null,
	day_of_week int not null,
	day_name nvarchar(15) not null
);

create table DimBirthDate(
	id int not null identity(1, 1) primary key,
	calendar_year int not null,
	calendar_quarter int not null,
	month_of_year int not null,
	month_name nvarchar(10) not null,
	day_of_month int not null,
	day_of_week int not null,
	day_name nvarchar(15) not null,
	age int not null
);

create table FactUsers(
	id int not null identity(1, 1) primary key,
	alt_id int not null foreign key references Users(id),
	country_id int not null foreign key references DimCountry(id),
	gender_id int null foreign key references DimGender(id),
	sign_up_id int null foreign key references DimSignUp(id),
	last_sign_in_id int null foreign key references DimLastSignIn(id),
	birth_date_id int null foreign key references DimBirthDate(id),
	followers_count int not null,
	following_count int not null,
	bookmarks_count int not null,
	lists_count int not null,
);

go

/* triggers */
create trigger trg_delete_user_references
on Users
instead of delete 
as
begin
	declare @deleted_user_id int
	set @deleted_user_id  = (select id from Deleted)
	delete from ListsUsers where user_id  = @deleted_user_id
	delete from Bookmarks where user_id  = @deleted_user_id
	delete from Retweets where user_id  = @deleted_user_id
	delete from Likes where user_id  = @deleted_user_id
	delete from UsersFollowers where follower_id  = @deleted_user_id
    delete from CommunitiesUsers where user_id  = @deleted_user_id
    delete from SpacesUsers where user_id  = @deleted_user_id
	delete from Users where id  = @deleted_user_id
end;

go

/* procedures */
create procedure getUsersFollowingAndFollowers
as
begin
	set nocount on
	select u.display_name as [User], u.username as Hashtag,
		(
          select count(*)
          from UsersFollowers f
          where f.follower_id = u.id
		) as [Following],
		(
          select count(*)
          from UsersFollowers f
          where f.followee_id = u.id
		) as Followers
	from Users u
end

go

create procedure getTop5MostLikedTweets
as
begin
	set nocount on
	select top 5 s.message as Tweet, count(l.status_id) as Likes, u.display_name as Author, s.created_at as 'Tweeted at'
	from Statuses s join Users u on s.author_id = u.id
	join Likes l on l.status_id = s.id
	group by s.message, u.display_name, s.created_at
	order by Likes desc
end;

go

create procedure getTop5MostRetweetedTweets
as
begin
	set nocount on
	select top 5 s.message as Tweet, count(r.status_id) as Retweets, s.created_at as 'Tweeted at'
	from Retweets r join Statuses s on s.id = r.status_id
	group by s.message, s.created_at
	order by Retweets desc
end;

go

create procedure getUsersGendersRatio
as
begin
	set nocount on
	select g.name as Gender, count(u.gender_id) as Users
	from Users u join Genders g on g.id = u.gender_id
	group by g.name
	order by Users desc
end;

go

create procedure getUsersCountriesRatio
as
begin
	set nocount on
	select c.name as Country, count(u.country_id) as Users
	from Users u join Countries c on c.id = u.country_id
	group by c.name
	order by Users desc
end;

go

create procedure getTop5UsersWithMostTweets
as
begin
	set nocount on
	select top(5) u.display_name as 'User', u.username as Hashtag, count(s.id) as 'Number of Tweets'
	from Statuses s join Users u on s.author_id = u.id
	group by u.display_name, u.username
	order by 'Number of Tweets' desc
end;

go

create procedure getCommunitiesByUsers
as
begin
	set nocount on
	select c.name as 'Community', count(cu.user_id) + 1  as 'Number of Members'
	from CommunitiesUsers cu join Communities c on c.id = cu.community_id
	group by c.name
	order by 'Number of Members' desc
end;

go

create procedure getListsByEntries
as
begin
	set nocount on
	set nocount on
	select l.name as 'List', count(ls.status_id) + 1  as 'Number of Entries'
	from ListsStatuses ls join Lists l on l.id = ls.list_id
	group by l.name
	order by 'Number of Entries' desc
end;

go

/* inserting countries */
insert into Countries(name)
values('Bulgaria'),
('United States'),
('Germany'),
('Japan'),
('United Kingdom'),
('Spain'),
('Brazil'),
('France'),
('China'),
('Italy');

/* inserting genders */
insert into Genders(name)
values('Male'),
('Female'),
('Custom');

/* inserting users */
declare @birth_start date = dateadd(year, -70, getdate())
		,@birth_end date = dateadd(year, -13, getdate())
		,@sign_up_start date = dateadd(year, -12, getdate())
		,@sign_up_end date = dateadd(year, -1, getdate())
		,@last_sign_in_start date = dateadd(day, -9, getdate())
		,@last_sign_in_end date = getdate()
insert into Users
(username, display_name, password, date_of_birth, gender_id, country_id, is_protected, bio, sign_up, last_sign_in)
values
('mitko', 'mitko123', 'mitko123', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 6, 0, 'My name is Mitko', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('elena', 'elena321', 'elena321', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 2, 3, 0, 'My name is Elena', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('ali', 'aliraza', 'ali0', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 3, 5, 0, 'I like action movies!', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('elon_musk', 'Elon Musk', 'tesla420', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 10, 0, 'Now is the best time to invest in Doge coin!', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('joe_biden', 'Joe Biden', 'usa', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 9, 0, 'President of The United States of America', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('bob', 'bob101', 'bob bobobov', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 6, 1, 'Bob', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('Jack_op', 'adssad8989', 'adadasd999', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 2, 3, 0, 'Yo, my name is Jack and I love fishing.', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('Mia', 'Mia - Japan', 'tokyo100', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 2, 4, 0, 'Greetings from Japan!', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('Sali', 'Barbie girl', 'elena321', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 2, 3, 0, 'hello hello hello', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('Maria', 'Maria Natasha', 'opaoda00', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 2, 1, 1, 'My name is Elena', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('nikiathome', 'Just some guy', '323sdasda', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 5, 0, 'Just some guy', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('Austin', 'Asutin', 'aust456', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 6, 0, 'I make videos where I play games', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('Hasan01', 'Hasan', 'opaoda00', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 7, 1, 'My name is Hasan', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('steve', 'Steve Jobs', 'apple134', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 8, 1, 'My name is Steve', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start)),
('jake_0', 'Jake', '00jake', DateAdd(Day, Rand() * DateDiff(Day, @birth_start, @birth_end), @birth_start), 1, 2, 0, 'My name is Jake', DateAdd(Day, Rand() * DateDiff(Day, @sign_up_start, @sign_up_end), @sign_up_start), DateAdd(Day, Rand() * DateDiff(Day, @last_sign_in_start, @last_sign_in_end), @last_sign_in_start));

/* inserting users followers */
insert into UsersFollowers
(follower_id, followee_id, timestamp)
values
(1, 2, GETDATE()),
(1, 3, GETDATE()),
(1, 7, GETDATE()),
(1, 9, GETDATE()),
(2, 1, GETDATE()),
(2, 3, GETDATE()),
(2, 5, GETDATE()),
(2, 9, GETDATE()),
(3, 2, GETDATE()),
(3, 5, GETDATE()),
(4, 1, GETDATE()),
(4, 4, GETDATE()),
(4, 5, GETDATE()),
(4, 6, GETDATE()),
(4, 7, GETDATE()),
(5, 1, GETDATE()),
(5, 2, GETDATE()),
(6, 8, GETDATE()),
(6, 10, GETDATE()),
(7, 1, GETDATE()),
(7, 10, GETDATE()),
(8, 4, GETDATE()),
(8, 5, GETDATE()),
(9, 7, GETDATE()),
(9, 8, GETDATE()),
(10, 1, GETDATE()),
(10, 2, GETDATE()),
(10, 4, GETDATE()),
(11, 5, GETDATE()),
(11, 6, GETDATE()),
(11, 7, GETDATE()),
(11, 8, GETDATE()),
(11, 9, GETDATE()),
(12, 10, GETDATE()),
(12, 9, GETDATE()),
(13, 11, GETDATE()),
(13, 12, GETDATE()),
(13, 14, GETDATE()),
(14, 1, GETDATE()),
(14, 2, GETDATE()),
(14, 3, GETDATE()),
(14, 4, GETDATE()),
(14, 5, GETDATE()),
(14, 8, GETDATE()),
(14, 10, GETDATE()),
(14, 13, GETDATE()),
(15, 14, GETDATE());

insert into DirectMessages
(sender_id, receiver_id, [message], [timestamp])
values
(1, 2, 'There is no substitute for hard work.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 1)), GETDATE()), convert(datetime, (select sign_up from Users where id = 1)))),
(1, 7, 'What consumes your mind controls your life', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 1)), GETDATE()), convert(datetime, (select sign_up from Users where id = 1)))),
(1, 7, 'Strive for greatness.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 1)), GETDATE()), convert(datetime, (select sign_up from Users where id = 1)))),
(2, 5, 'Wanting to be someone else is a waste of who you are.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 2)), GETDATE()), convert(datetime, (select sign_up from Users where id = 2)))),
(2, 9, 'And still, I rise.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 2)), GETDATE()), convert(datetime, (select sign_up from Users where id = 2)))),
(4, 5, 'The time is always right to do what is right.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 4)), GETDATE()), convert(datetime, (select sign_up from Users where id = 4)))),
(4, 5, 'Let the beauty of what you love be what you do.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 4)), GETDATE()), convert(datetime, (select sign_up from Users where id = 4)))),
(8, 4, 'May your choices reflect your hopes, not your fears.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 8)), GETDATE()), convert(datetime, (select sign_up from Users where id = 8)))),
(8, 5, 'A happy soul is the best shield for a cruel world.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 8)), GETDATE()), convert(datetime, (select sign_up from Users where id = 8)))),
(9, 8, 'White is not always light and black is not always dark.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 9)), GETDATE()), convert(datetime, (select sign_up from Users where id = 9)))),
(13, 11, 'Life becomes easier when you learn to accept the apology you never got.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 13)), GETDATE()), convert(datetime, (select sign_up from Users where id = 13)))),
(13, 12, 'Happiness depends upon ourselves.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 13)), GETDATE()), convert(datetime, (select sign_up from Users where id = 13)))),
(13, 14, 'Turn your wounds into wisdom.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 13)), GETDATE()), convert(datetime, (select sign_up from Users where id = 13)))),
(14, 4, 'Change the game, don’t let the game change you.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14)))),
(14, 4, 'It hurt because it mattered.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14)))),
(14, 10, 'If the world was blind how many people would you impress?', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14)))),
(14, 13, 'I will remember and recover, not forgive and forget.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14)))),
(14, 13, 'The meaning of life is to give life meaning.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14)))),
(14, 13, 'The true meaning of life is to plant trees, under whose shade you do not expect to sit.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14)))),
(15, 14, 'When words fail, music speaks.', DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 15)), GETDATE()), convert(datetime, (select sign_up from Users where id = 15))));

insert into Sources
(name)
values
('Twitter Web App'),
('Twitter for Android'),
('Twitter for iPhone');

insert into Topics
(name)
values
('photography'),
('minecraft'),
('Football'),
('justin bieber'),
('corona'),
('nature'),
('Anime'),
('Spotify'),
('Animals'),
('Freddie Mercury'),
('food');

/* Tweets */
insert into Statuses
(author_id, [message], source_id, topic_id, created_at)
values
(1, 'This is my first tweet!', 1, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 1)), GETDATE()), convert(datetime, (select sign_up from Users where id = 1)))),
(1, 'What do you prefer - cats or dogs?', 1, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 1)), GETDATE()), convert(datetime, (select sign_up from Users where id = 1)))),
(4, 'Any mutuals wanna hang out?', 2, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 4)), GETDATE()), convert(datetime, (select sign_up from Users where id = 4)))),
(4, 'This might be an unpopular opinion, but I like eating pineapple pizza', 2, 11, DateAdd(SECOND, Rand() * DateDiff(Day, convert(datetime, (select sign_up from Users where id = 4)), GETDATE()), convert(datetime, (select sign_up from Users where id = 4)))),
(4, 'Have an exam in 30 mins, wish me luck!!!', 3, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 4)), GETDATE()), convert(datetime, (select sign_up from Users where id = 4)))),
(6, 'When nothing goes right, go left.', 2, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 6)), GETDATE()), convert(datetime, (select sign_up from Users where id = 6)))),
(6, 'Take the risk or lose the chance.', 1, 5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 6)), GETDATE()), convert(datetime, (select sign_up from Users where id = 6)))),
(8, 'The past does not equal the future.', 2, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 8)), GETDATE()), convert(datetime, (select sign_up from Users where id = 8)))),
(10, 'Dream without fear. Love without limits.', 3, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 10)), GETDATE()), convert(datetime, (select sign_up from Users where id = 10)))),
(14, 'If you’re going through hell, keep going.', 2, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 14)), GETDATE()), convert(datetime, (select sign_up from Users where id = 14))));

/* Replies */
insert into Statuses
(author_id, [message], source_id, replied_status_id, created_at)
values
(1, 'Tough times never last but tough people do.', 1, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(2, 'Problems are not stop signs, they are guidelines.', 3, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(2, 'One day the people that don’t even believe in you will tell everyone how they met you. – Johnny Depp', 2, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 3)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 3)))),
(3, 'If I’m gonna tell a real story, I’m gonna start with my name.', 2, 4, DateAdd(SECOND, Rand() * DateDiff(Day, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(3, 'If you tell the truth you don’t have to remember anything.', 2, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(5, 'Have enough courage to start and enough heart to finish.', 2, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(6, 'Hate comes from intimidation, love comes from appreciation.', 2, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(7, 'I could agree with you but then we’d both be wrong.', 3, 10, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 10)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 10)))),
(11, 'Oh, the things you can find, if you don’t stay behind.', 2, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(12, 'Determine your priorities and focus on them.', 1, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2))));


/* Quote Tweets */
insert into Statuses
(author_id, [message], source_id, quoted_status_id, created_at)
values
(3, 'Change the world by being yourself.', 3, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 3)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 3)))),
(4, 'Every moment is a fresh beginning.', 1, 12, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 12)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 12)))),
(7, 'Never regret anything that made you smile.', 2, 15, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 15)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 15)))),
(7, 'Die with memories, not dreams.', 2, 14, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 14)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 14)))),
(8, 'Aspire to inspire before we expire.', 2, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(8, 'Everything you can imagine is real.', 3, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(10, 'Simplicity is the ultimate sophistication.', 2, 13, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 13)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 13)))),
(10, 'Whatever you do, do it well.', 2, 11, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 11)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 11)))),
(13, 'What we think, we become.', 2, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(15, 'All limitations are self-imposed.', 3, 16, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 16)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 16))));

insert into Likes
(user_id, status_id, timestamp)
values
(1,2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(1,4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(1,6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(1,7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(2,1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(2,2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(2,9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(2,10, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 10)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 10)))),
(3,5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 5)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 5)))),
(3,6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(3,7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(4,8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(4,9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(5, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(5, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(5, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(5, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(5, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(5, 10, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 10)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 10)))),
(6, 5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 5)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 5)))),
(7, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(7, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(7, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(8, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(8, 5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 5)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 5)))),
(9, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(10, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(10, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(10, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(10, 13, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 13)))),
(11, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(11, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(12, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(12, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(12, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(12, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(13, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(13, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(14, 15, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 15)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 15)))),
(14, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(15, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(15, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(15, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(15, 10, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 10)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 10))));

insert into Retweets
(user_id, status_id, [timestamp])
values
(1,2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(1,7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(2,1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(2,2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(2,9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(4,9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(5, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(5, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(5, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(5, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(5, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(5, 10, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 10)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 10)))),
(6, 5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 5)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 5)))),
(7, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(7, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(7, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(9, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(10, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 1)))),
(10, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(10, 12, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 12)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 12)))),
(10, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 3)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 3)))),
(11, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(11, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(12, 11, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 1)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 11)))),
(12, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(12, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 15)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 15)))),
(12, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(13, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(15, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(15, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9))));

insert into Bookmarks
(user_id, status_id, added_at)
values
(3, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(3, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(4, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(4, 13, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 13)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 13)))),
(5, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(5, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(5, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(7, 11, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 11)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 11)))),
(7, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(7, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(8, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(8, 5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 5)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 5)))),
(9, 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 6)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 6)))),
(12, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(12, 14, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 14)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 14)))),
(13, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 2)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 2)))),
(13, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(14, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 4)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 4)))),
(14, 13, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 13)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 13)))),
(15, 7, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 7)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 7)))),
(15, 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 8)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 8)))),
(15, 9, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 9)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 9)))),
(15, 15, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_at from Statuses where id = 15)), GETDATE()), convert(datetime, (select created_at from Statuses where id = 15))));

insert into BasicRoles
([name])
values
('Member'),
('Moderator');

insert into Lists
(owner_id, [name], [description], is_private)
values
(1, 'My List', 'My favourite tweets', 1),
(4, 'Best Tweets', 'All the best tweets', 0),
(5, 'Funny', 'Only funny tweets', 0),
(9, 'Cool', 'Cool or nah', 0),
(14, 'Yes', 'Yes', 0);

insert into ListsUsers
([user_id], list_id, role_id)
values
(2, 1, 1),
(4, 1, 2),
(3, 2, 1),
(9, 2, 1),
(11, 2, 1),
(14, 3, 1),
(6, 4, 1),
(10, 4, 2),
(6, 5, 1),
(9, 5, 1),
(12, 5, 2);

insert into ListsStatuses
(list_id, status_id, added_at)
values
(1, 1, GETDATE()),
(1, 3, GETDATE()),
(1, 4, GETDATE()),
(1, 7, GETDATE()),
(1, 8, GETDATE()),
(2, 1, GETDATE()),
(2, 2, GETDATE()),
(2, 3, GETDATE()),
(2, 4, GETDATE()),
(2, 7, GETDATE()),
(2, 9, GETDATE()),
(2, 10, GETDATE()),
(3, 2, GETDATE()),
(3, 4, GETDATE()),
(3, 7, GETDATE()),
(3, 8, GETDATE()),
(3, 9, GETDATE()),
(3, 10, GETDATE()),
(4, 1, GETDATE()),
(4, 4, GETDATE()),
(4, 5, GETDATE()),
(4, 6, GETDATE()),
(4, 7, GETDATE()),
(4, 10, GETDATE()),
(5, 2, GETDATE()),
(5, 3, GETDATE()),
(5, 5, GETDATE()),
(5, 6, GETDATE()),
(5, 8, GETDATE()),
(5, 9, GETDATE());

insert into SpacesRoles
([name])
values
('Listener'),
('Speaker'),
('Co-Host');

insert into Spaces
([name], [host_id], start_time)
values
('Let''s talk about Music', 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 1)), GETDATE()), convert(datetime, (select sign_up from Users where id = 1)))),
('Come and chill', 5, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 5)), GETDATE()), convert(datetime, (select sign_up from Users where id = 5)))),
('Favourite movies of 2021', 10, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 10)), GETDATE()), convert(datetime, (select sign_up from Users where id = 10)))),
('Superbowl', 15, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 15)), GETDATE()), convert(datetime, (select sign_up from Users where id = 15))));

insert into SpacesUsers
(space_id, [user_id],  [role_id])
values
(1, 2, 3),
(1, 3, 1),
(1, 4, 1),
(2, 6, 2),
(2, 7, 2),
(3, 8, 1),
(3, 9, 1),
(3, 11, 3),
(4, 12, 2),
(4, 13, 1),
(4, 14, 2);

insert into Communities
([name], [description], admin_id, created_on)
values
('Netflix and chill', 'Discusing Netflix series and movies', 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 2)), GETDATE()), convert(datetime, (select sign_up from Users where id = 2)))),
('Football', 'The place for football fans', 6, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 6)), GETDATE()), convert(datetime, (select sign_up from Users where id = 6)))),
('Pokemon', 'Pokemon enthusiasts', 8, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 8)), GETDATE()), convert(datetime, (select sign_up from Users where id = 8)))),
('Chefs', 'Chefs only', 12, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select sign_up from Users where id = 12)), GETDATE()), convert(datetime, (select sign_up from Users where id = 12))));

insert into CommunitiesUsers
(community_id, [user_id], [role_id])
values
(1, 1, 2),
(1, 3, 1),
(1, 4, 1),
(2, 2, 1),
(2, 7, 2),
(2, 8, 1),
(2, 13, 1),
(3, 12, 1),
(3, 15, 1),
(4, 5, 2),
(4, 13, 1),
(4, 14, 1);

/* Community Tweets */
insert into Statuses
(author_id, message, source_id, community_id, created_at)
values
(2, 'Be so good they can’t ignore you.', 2, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 1)), GETDATE()), convert(datetime, (select created_on from Communities where id = 1)))),
(3, 'Dream as if you’ll live forever, live as if you’ll die today.', 1, 1, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 1)), GETDATE()), convert(datetime, (select created_on from Communities where id = 1)))),
(6, 'Yesterday you said tomorrow. Just do it.', 2, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 2)), GETDATE()), convert(datetime, (select created_on from Communities where id = 2)))),
(2, 'I don’t need it to be easy, I need it to be worth it.', 1, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 2)), GETDATE()), convert(datetime, (select created_on from Communities where id = 2)))),
(13, 'Never let your emotions overpower your intelligence.', 3, 2, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 2)), GETDATE()), convert(datetime, (select created_on from Communities where id = 2)))),
(12, 'Nothing lasts forever but at least we got these memories.', 3, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 3)), GETDATE()), convert(datetime, (select created_on from Communities where id = 3)))),
(15, 'Don’t you know your imperfections is a blessing?', 3, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 3)), GETDATE()), convert(datetime, (select created_on from Communities where id = 3)))),
(8, 'Reality is wrong, dreams are for real.', 1, 3, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 3)), GETDATE()), convert(datetime, (select created_on from Communities where id = 3)))),
(13, 'To live will be an awfully big adventure.', 2, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 4)), GETDATE()), convert(datetime, (select created_on from Communities where id = 4)))),
(14, 'Try to be a rainbow in someone’s cloud.', 1, 4, DateAdd(SECOND, Rand() * DateDiff(SECOND, convert(datetime, (select created_on from Communities where id = 4)), GETDATE()), convert(datetime, (select created_on from Communities where id = 4))));

/* Procedures 
execute getUsersFollowingAndFollowers;
execute getTop5MostLikedTweets;
execute getTop5MostRetweetedTweets;
execute getUsersGendersRatio;
execute getUsersCountriesRatio;
execute getTop5UsersWithMostTweets;
execute getCommunitiesByUsers;
execute getListsByEntries;
*/

/* For deleting the database
use master;
drop database Twitter;
*/

/* Testing
select * from Followers;
select * from Users;
select * from Statuses;
select * from Spaces;
select * from SpacesUsers;
select * from Communities;
select * from CommunitiesUsers;
*/

/* Unfinished triggers
create trigger trg_fact_statuses
on Statuses 
after insert, delete
as
begin
	set nocount on
	insert into DimAuthor(
		alt_id,
		username,
		display_name,
		date_of_birth,
		gender,
		country
	)
	select i.author_id, u.username, u.display_name, u.date_of_birth, g.name, c.name
	from inserted i
	join Users u on i.author_id = u.id
	join Genders g on u.gender_id = g.id
	join Countries c on u.country_id = c.id

	insert into DimTopic(
		alt_id,
		name,
		references_count
	)
	select i.topic_id, t.name, count(s.id)
	from inserted i join Topics t on i.topic_id = t.id
	join Statuses s on i.topic_id = s.topic_id
	group by i.id, i.topic_id, t.name

	insert into DimSource(
		alt_id,
		name,
		references_count
	)
	select i.source_id, s.name, count(s.id)
	from inserted i join Sources s on i.source_id = s.id
	group by i.id, i.source_id, s.name

	insert into DimStatusTime(
		calendar_year,
		calendar_quarter,
		month_of_year,
		month_name,
		day_of_month,
		day_of_week,
		day_name
	)
	select
		year(i.created_at),
		datepart(quarter, i.created_at),
		month(i.created_at),
		format(i.created_at, 'MMMM'),
		day(i.created_at),
		datepart(WEEKDAY, i.created_at),
		datename(dw, i.created_at)
	from inserted i

	insert into FactStatuses(
		author_id,
		topic_id,
		source_id,
		time_id,
		likes_count,
		retweets_count,
		quote_tweets_count,
		replies_count,
		lists_count,
		updated_at,
		operation
	)
	select
		(select top(1) da.id from DimAuthor da where da.id not in (select author_id from FactStatuses) order by id asc),
		(select top(1) ds.id from DimSource ds where ds.id not in (select source_id from FactStatuses) order by id asc),
		(select top(1) dt.id from DimTopic dt where dt.id not in (select topic_id from FactStatuses) order by id asc),
		(select top(1) dt.id from DimStatusTime dt where dt.id not in (select time_id from FactStatuses) order by id asc),
		0,
		0,
		0,
		0,
		0,
		GETDATE(),
		'INS'
	from inserted i
	union all
	select
		(select top(1) da.id from DimAuthor da where da.id not in (select author_id from FactStatuses) order by id asc),
		(select top(1) ds.id from DimSource ds where ds.id not in (select source_id from FactStatuses) order by id asc),
		(select top(1) dt.id from DimTopic dt where dt.id not in (select topic_id from FactStatuses) order by id asc),
		(select top(1) dt.id from DimStatusTime dt where dt.id not in (select time_id from FactStatuses) order by id asc),
		0,
		0,
		0,
		0,
		0,
		GETDATE(),
		'DEL'
	from deleted d
end;

go
*/
