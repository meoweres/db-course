select r.id as "ІД",
r.name as "Ім'я",
r.surname as "Призвіще",
string_agg(distinct l.id::text, ', ') as "ІД позики",
string_agg(distinct b.title::text, ', ') as "Всі позичені книги"
from Readers r
left join Loans l on r.id = l.reader_id
left join BookLoans bl on l.id = bl.loan_id
left join Books b on bl.book_id = b.id
group by
r.id,
r.name,
r.surname
order by r.id asc;