-- видалення записів о читачах без позик
delete from Readers cascade
where id not in (
	select reader_id
	from Loans
);

-- вивід записів читачів з позиками та без них. id позик склеюються та сортуються, щоб було більш читабельно
select r.id as "ІД",
r.name as "Ім'я",
r.surname as "Призвіще",
string_agg(l.id::text, ', ' order by l.id) as "ІД позики"
from Readers r
left join Loans l on r.id = l.reader_id
group by
r.id,
r.name,
r.surname
order by r.id asc;