select city
from children
group by city, country
order by avg(naughty_nice_score) desc
limit 5