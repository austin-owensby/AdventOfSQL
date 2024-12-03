select string_agg(CHR(value), '')
from 
(
	select * from letters_a
	union
	select * from letters_b
	order by id
)
where
	value >= 97 and value <= 122 -- a-z
	or value >= 65 and value <= 90 -- A-Z
	or value in (
		32, -- Space
		33, -- !
		34, -- "
		39, -- '
		40, -- (
		41, -- )
		44, -- `
		45, -- -
		46, -- .
		58, -- :
		59, -- ;
		63  -- ?
	)