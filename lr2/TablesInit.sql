-- Таблиця Читачі
CREATE TABLE IF NOT EXISTS Readers(
	id serial primary key,
	name varchar(30) not null,
	surname varchar(30) not null,
	phone varchar(13) unique not null,
	email varchar(100) unique, -- електронна пошта необов'язкова, але має бути унікальною
	address text not null
);

-- Таблиця Книги
CREATE TABLE IF NOT EXISTS Books(
	id serial primary key,
	title text not null, -- робити назву унікальною не має сенсу, оскільки існуе ймовірність повного співпадіння назв книг різних авторів. також, збірники можуть називатися як одне з оповіданнь
	year int2 check (year >= 0) not null, -- рік не може бути від'ємним
	quantity int check (quantity >=0) not null -- кількість не може бути нижче нуля
);

-- Таблиця Автори
CREATE TABLE IF NOT EXISTS Authors(
	id serial primary key,
	fullname text not null, -- можна записувати таким чином, а далі за необходністю витягувати ім'я або прізвище, беручи пропуск як роздільник
	country varchar(60) not null
);

-- Таблиця Видавництва
CREATE TABLE IF NOT EXISTS Publishers(
	id serial primary key,
	name text not null unique,
	address text not null,
	phone varchar(13) unique not null,
	email varchar(100) unique not null
);

-- Таблиця Жанри
CREATE TABLE IF NOT EXISTS Genres(
	book_id int not null,
	genre varchar(50) not null,
	primary key (book_id, genre),
	foreign key (book_id) references Books(id) on delete cascade
);

-- Таблиця зв'язків між книгами, авторами та видавництвами
CREATE TABLE IF NOT EXISTS BookAuthorPublishers(
	book_id int not null,
	author_id int not null,
	publisher_id int not null,
	primary key (book_id, author_id, publisher_id),
	foreign key (book_id) references Books(id) on delete cascade,
	foreign key (author_id) references Authors(id),
	foreign key (publisher_id) references Publishers(id)
);

-- Таблиця Позик
CREATE TABLE IF NOT EXISTS Loans(
	id serial primary key,
	reader_id int not null,
	loan_date date default current_date, -- автоматично ставить дату з пристрою
	due_date date not null,
	return_date date,
	check (due_date > loan_date), -- перевірка, щоб дата видачі була раніше, аніж строк здачі
	foreign key (reader_id) references Readers(id)
);

-- Таблиця позицій позик. Завдяки необхідності існування унікального primary key, навіть не потрібна перевірка для того, щоб брався лише один примірник книги на замовлення.
CREATE TABLE IF NOT EXISTS BookLoans(
	loan_id int not null,
	book_id int not null,
	primary key (loan_id, book_id),
	foreign key (loan_id) references Loans(id),
	foreign key (book_id) references Books(id)
);


-- Нижче реалізація обмежень

-- Обмеження на кількість книг у одній позикі (до 10 шт)
-- Перевіряємо, щоб книг у позикі було максимум 10
CREATE OR REPLACE FUNCTION loan_books_limit()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM BookLoans
        WHERE loan_id = NEW.loan_id
    ) >= 10 THEN
        RAISE EXCEPTION 'Не можна брати більше 10 книг в одній позиці!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Тригер
CREATE TRIGGER trg_loan_books_limit
BEFORE INSERT ON BookLoans
FOR EACH ROW
EXECUTE FUNCTION loan_books_limit();
-- Кінець перевірки

-- Обмеження на кількість жарнрів у книги (до 5 шт)
CREATE OR REPLACE FUNCTION genre_books_limit()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM Genres
        WHERE book_id = NEW.book_id
    ) >= 5 THEN
        RAISE EXCEPTION 'Максимум жанрів для книги - 5!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Тригер
CREATE TRIGGER trg_genre_books_limit
BEFORE INSERT ON Genres
FOR EACH ROW
EXECUTE FUNCTION genre_books_limit();


-- Додавання тестових даних

insert into Readers (name, surname, phone, email, address) values
	('Pavlo', 'Dorotenko', '380558963347', null, 'Kyiv, Bankova str. 12'),
	('Pavlo', 'Doroshenko', '380558963337', 'yasobakatisobakaya@ti.com', 'Kyiv, Bankova str. 13'),
	('Anastasia', 'Pavlenko', '0553963347', 'ferretsilver@ukr.net', 'Kyiv, Bankova str. 14'),
	('Anastasia', 'Nechaeva', '0553978347', 'ferretgold@ukr.net', 'Kyiv, Bankova str. 15');
	
insert into Books (title, year, quantity) values
	('Tales from boot', 2018, 3),
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
	(2, 12);
