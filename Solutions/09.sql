select reindeer_name, round(highest_average_score, 2) as highest_average_score
from
reindeers
join
(
	select reindeer_id, max(average_score) as highest_average_score
	from
	(
		select reindeer_id, avg(speed_record) as average_score
		from training_sessions
		group by reindeer_id, exercise_name
	)
	group by reindeer_id
) averages
on averages.reindeer_id = reindeers.reindeer_id
where reindeer_name != 'Rudolph'
order by highest_average_score desc
limit 3