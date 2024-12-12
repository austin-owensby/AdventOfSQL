select
	round(
		case 
			when season = 'Spring' then trees_harvested
			when season = 'Summer' then (select avg(trees_harvested) from treeharvests where field_name = t.field_name and season in ('Spring', 'Summer'))
			when season = 'Fall' then (select avg(trees_harvested) from treeharvests where field_name = t.field_name and season in ('Spring', 'Summer', 'Fall'))
			when season = 'Winter' then (select avg(trees_harvested) from treeharvests where field_name = t.field_name and season in ('Summer', 'Fall', 'Winter'))
		end
		,2
	) as three_season_moving_avg
from treeharvests t
order by three_season_moving_avg desc
limit 1