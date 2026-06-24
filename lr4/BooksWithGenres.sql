select b.id as "ІД Книги",
b.title as "Назва книги",
string_agg(g.genre::text, ', ') as "Жанри"
from Books b
join Genres g on b.id = g.book_id
group by b.id, b.title
order by b.id;