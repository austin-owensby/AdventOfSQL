with recursive managers AS (
 -- Start with top of hierarchy
 select
 	staff_id,
 	1 as levels
 from staff
 where manager_id is null
 
 union all
 
 -- Get all employees for the current manager
 select
 	staff.staff_id,
 	(managers.levels + 1) as levels
 from staff
 join managers on managers.staff_id = manager_id
)
-- Get the max managed level
select max(levels) from managers;