-- зміна даних в Readers
update Readers set email = 'setemail1@gmail.com'
where id = 1;
update Readers set surname = 'Krutiy'
where id = 2;
update Readers set name = 'Anna'
where id = 3;

-- зміна даних в Loans
update Loans set return_date = current_date+3
where id = 1;

-- вивод змінених даних
select r.id as "ІД", r.name as "Ім'я", r.surname as "Призвіще", r.email as "Ел. пошта",l.id as "ІД позики", l.loan_date as "Дата позики", l.due_date as "Повернути до", l.return_date as "Було повернено"
from Readers r
left join Loans l on r.id = l.reader_id
order by r.id, l.id asc;