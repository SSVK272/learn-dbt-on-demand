with payment as (
    select 
        orderid,
        amount
    from {{ source('stripe','payment') }}
)
select * from payment