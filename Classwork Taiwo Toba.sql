-----No. 1-----
select acct_name 
from(
  select acct_name, sum(profit_usd) as total_profit
  from
    (select a.name "acct_name", o.total_amt_usd "profit_usd", o.occurred_at "date"
     from accounts a
     join orders o  
     on a.id = o.account_id
     where o.occurred_at between ('2015-01-01') and ('2016-12-31')) as table_k
  group by acct_name
  order by total_profit desc) as table_x
limit 3;

-----No. 2-----
select count(channel) as "direct_count"
from web_events
where channel in ('direct') and occurred_at between ('2015-01-01') and ('2016-12-31');

-----No. 3-----
select channel, sum(total_usd) as grand_total
from
  (select w.channel "channel", o.total_amt_usd "total_usd"
   from web_events w 
   join accounts a 
   on w.account_id = a.id
   join orders o 
   on a.id = o.account_id
   where o.occurred_at between ('2015-01-01') and ('2016-12-31')) as table_k
group by channel
order by grand_total desc;

