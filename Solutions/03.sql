select
	unnest(xpath('//food_item_id/text()', menu_data))::text::int
from christmas_menus
where
	COALESCE(
		(xpath('//total_present/text()', menu_data))[1],
		(xpath('//total_guests/text()', menu_data))[1],
		(xpath('//total_count/text()', menu_data))[1]
	)::text::int > 78
group by unnest(xpath('//food_item_id/text()', menu_data))::text::int
order by count(*) desc
limit 1