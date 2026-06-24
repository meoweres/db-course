select names as "Ім'я",
surname as "Прізвище",
email as "Ел.пошта"
from Readers
where email is not null 
order by id;