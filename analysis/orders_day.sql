with orders as(
    select * from {{ ref('stg_orders') }}
),
daily as(
    select
        order_date,
        count(*) as no_of_orders
    from orders
    group by 1
),

analys as(
    select
        *,
        lag(no_of_orders) over (order by order_date) as previous_days
    from daily
)

select * from analys