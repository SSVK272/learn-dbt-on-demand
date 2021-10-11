with orders as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from {{ source('js','orders') }}
)

select * from orders
{{ limit_data_in_dev('order_date',dev_days=1000) }}
