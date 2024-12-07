select
	(
		select elf_id
		from workshop_elves we
		where extremes.primary_skill = we.primary_skill
		order by years_experience desc, elf_id
		limit 1
	) as max_years_experience_elf_id,
	(
		select elf_id from workshop_elves we
		where extremes.primary_skill = we.primary_skill
		order by years_experience, elf_id
		limit 1
	) as min_years_experience_elf_id,
	extremes.primary_skill as shared_skill
from 
(
	SELECT primary_skill, min(years_experience), max(years_experience)
	FROM workshop_elves
	group by primary_skill
) extremes
order by extremes.primary_skill