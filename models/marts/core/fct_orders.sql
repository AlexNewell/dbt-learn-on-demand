with orders as (
    select * from {{ref('stg_orders')}}
    ),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount end) as amount

    from {{ref('stg_payments')}}
    group by order_id
    )

select orders.order_id
    , orders.customer_id
    , orders.order_date
    , coalesce(sum(order_payments.amount), 0) as order_amount 
from orders
left join order_payments as order_payments
    using (order_id)
group by orders.order_id
    , orders.customer_id
    , orders.order_date