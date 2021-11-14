select orderid as order_id        
, paymentmethod
, status
-- amount is stored in cents, convert it to dollars
, amount / 100 as amount
, created 
from dbt-tutorial.stripe.payment
