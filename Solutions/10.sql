select date
from (
	select drink_name, date, sum(quantity) as quantity
	from drinks
	group by drink_name, date
)
where
(
	drink_name = 'Hot Cocoa' and quantity = 38
	or
	drink_name = 'Eggnog' and quantity = 198
	or
	drink_name = 'Peppermint Schnapps' and quantity = 298
)
group by date
having count(*) = 3
