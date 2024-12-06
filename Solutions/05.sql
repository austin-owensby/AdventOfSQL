select production_date
from (
	select
		current.production_date,
		current.toys_produced,
		previous.toys_produced as previous_day_production,
		current.toys_produced - previous.toys_produced as production_change,
		round(100 * (current.toys_produced - previous.toys_produced) / previous.toys_produced::decimal, 2) as production_change_percentage
	from toy_production previous
	left join toy_production current on previous.production_date = current.production_date - INTERVAL '1 DAY'
)
where production_change_percentage is not NULL
order by production_change_percentage desc
limit 1