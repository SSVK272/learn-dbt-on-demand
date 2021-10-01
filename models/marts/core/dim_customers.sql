{{ config(materialized="table") }}

with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
customers_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by customer_id
),
fct_orders as (
    select * from {{ ref('fct_orders') }}
),
final as(
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers_orders.first_order_date,
        customers_orders.most_recent_order_date,
        coalesce(customers_orders.number_of_orders,0) as number_of_orders,
        sum(fct_orders.amount)
    from fct_orders right join customers on fct_orders.customer_id=customers.customer_id
    left join customers_orders on customers.customer_id=customers_orders.customer_id
    group by 1,2,3,4,5,6
    order by 1
)
select * from final