select b.title as "Назва книги",
a.fullname as "Автор",
p.name as "Видавництво"
from Books b
full join BookAuthorPublishers bap on b.id = bap.book_id
full join Authors a on bap.author_id = a.id
full join Publishers p on bap.publisher_id = p.id
order by a.id;