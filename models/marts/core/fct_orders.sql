with orders as (
    select * from {{ ref('stg_orders') }}
),
payment as (
    select * from {{ ref('stg_payments') }}
),
fct_orders as (
    select
        orders.order_id,
        orders.customer_id,
        payment.amount
    from orders join payment on orders.order_id=payment.orderid

)

select * from fct_orders
