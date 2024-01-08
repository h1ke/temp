with transactions as(
   select
       cast(transaction_time as Date) As Date,
       SUM(transaction_amount) as total_transaction_amount 
   from transactions
   Group by cast(transaction_time as date) 
   order by cast(transaction_time as date)
)
select *,
 avg(total_transaction_amount) OVER(ORDER BY date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
    as moving_average
from transactions_by_day
WHERE
   EXTRACT(DAY FROM date) = 31
   AND EXTRACT(MONTH FROM date) = 1;
