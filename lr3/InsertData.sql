insert into Readers (name, surname, phone, address) values
	('Pavlo', 'Dorotenko', '380558963347', 'Kyiv, Bankova str. 12'),
	('Pavlo', 'Doroshenko', '380558963337', 'Kyiv, Bankova str. 13'),
	('Anastasia', 'Pavlenko', '0553963347', 'Kyiv, Bankova str. 14'),
	('Anastasia', 'Nechaeva', '0553978347', 'Kyiv, Bankova str. 15');
	
insert into Books (title, year, quantity) values
	('Tales from boot', 2018, 1),
	('Once upon a time... Remake', 2019, 5),
	('Jerry Smith presents Jerry Smiths book', 2020, 10),
	('The Last Bug Report', 2017, 4),
	('Adventures in Binary Forest', 2016, 7),
	('Coffee, Code and Chaos', 2021, 12),
	('The Forgotten Function', 2015, 2),
	('Debugging the Universe', 2022, 6),
	('Chronicles of Null Pointer', 2019, 8),
	('Beyond the Compiler', 2020, 5),
	('A Tale of Two Databases', 2018, 9),
	('Mystery of the Missing Semicolon', 2023, 3),
	('Legends of the Infinite Loop', 2021, 11);
	
insert into Authors (fullname, country) values
	('Herman Shepherd', 'Germany'),
	('Olexandr Muzichnko', 'Ukraine'),
	('Pablo Escobar', 'Cuba');
	
insert into Publishers (name, address, phone, email) values
	('The Penguin Publishing', 'Kyiv, Anna Ahmatova str. 21', '446658257', 'penguinpub@penguin.com'),
	('Polar Bear Choice', 'Kyiv, Anna Ahmatova str. 11', '0557853214', 'polar@urk.net'),
	('Beloved Books', 'Kyiv, Anna Ahmatova str. 1', '685624249', 'beloveed@bb.com');
	
insert into Genres (book_id, genre) values
	(1, 'Sci-Fi'),
	(1, 'Horror'),
	(1, 'Comedy'),
	(1, 'Drama'),
	(1, 'Detective'),
	(2, 'Romantical'),
	(3, 'Parody'),
	(3, 'Philosophical');

insert into BookAuthorPublishers (book_id, author_id, publisher_id) values
	(1,1,1),
	(2,2,2),
	(3,3,3);

insert into Loans (reader_id, due_date) values
	(1, current_date+10),
	(1, current_date+10),
	(2, current_date+15),
	(3, current_date+20);
	
insert into BookLoans (loan_id, book_id) values
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	(2, 11),
	(2, 12),
	(3, 12);
	
-- далі команди для виводу поєднаних таблиць
select r.id as "ІД", r.name as "Ім'я", r.surname as "Призвіще", r.email as "Ел. пошта",l.id as "ІД позики", l.loan_date as "Дата позики", l.due_date as "Повернути до", l.return_date as "Було повернено"
from Readers r
left join Loans l on r.id = l.reader_id
order by r.id, l.id asc;
