select
r.id as "ІД Читача",
r.name as "Ім'я читача",
r.surname as "Прізвище читача",
count(l.id) as "Кількість позик"
from Readers r
join Loans l on r.id = l.reader_id
group by
r.id,
r.name,
r.surname
having count(l.id) > 1;