drop table if exists new_tags;
drop table if exists previous_tags;

create temp table previous_tags as
select toy_id, unnest(previous_tags) as tag
from toy_production;

create temp table new_tags as
select toy_id, unnest(new_tags) as tag
from toy_production;

select
	added_tags.toy_id,
	coalesce(added_tags.added_tags, 0),
	coalesce(unchanged_tags.unchanged_tags, 0),
	coalesce(removed_tags.removed_tags, 0)
from
(
	select toy_id, count(*) as added_tags
	from
	(
		select * from new_tags
		except
		select * from previous_tags
	)
	group by toy_id
) as added_tags
left join
(
	select toy_id, count(*) as removed_tags
	from
	(
		select * from previous_tags
		except
		select * from new_tags
	)
	group by toy_id
) as removed_tags
on removed_tags.toy_id = added_tags.toy_id
left join
(
	select toy_id, count(*) as unchanged_tags
	from
	(
		select new_tags.* from new_tags
		inner join previous_tags on new_tags.toy_id = previous_tags.toy_id and new_tags.tag = previous_tags.tag
	)
	group by toy_id
) as unchanged_tags
on unchanged_tags.toy_id = added_tags.toy_id
order by added_tags.added_tags desc
limit 1