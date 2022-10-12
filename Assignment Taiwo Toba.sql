select acct_name, sum(total_profit) as total_profit_usd
from 
   (select *,
    case when day_of_week in (0) then 'Sunday'
       when day_of_week in (1) then 'Monday'
       when day_of_week in (2) then 'Tuesday'
	   when day_of_week in (3) then 'Wednesday'
	   when day_of_week in (4) then 'Thursday'
	   when day_of_week in (5) then 'Friday'
    else 'Saturday' end as dow_word
    from(
     select acct_name, total_profit, extract(dow from date) as day_of_week
     from
       (select a.name "acct_name", o.total_amt_usd "total_profit", o.occurred_at "date"
        from orders o 
        join accounts a 
        on o.account_id = a.id
       ) as table_k
    )as table_x
  )as table_y
where dow_word in ('Saturday')
group by acct_name
order by total_profit_usd desc;

select id, 
        account_id,
	   occurred_at,
	   coalesce(standard_qty, 0) as standard_qty,
	   coalesce(gloss_qty, 0) as gloss_qty,
	   coalesce(poster_qty, 0) as poster_qty,
	   coalesce(total, 0) as total,
	   standard_amt_usd,
	   gloss_amt_usd,
	   poster_amt_usd,
	   total_amt_usd
from orders