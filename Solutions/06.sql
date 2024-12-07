select c.name
from gifts g
left join children c on c.child_id = g.child_id 
where price > (
	select avg(price) from gifts
)
order by price
limit 1