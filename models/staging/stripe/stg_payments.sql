with payment as (
    select 
        id,
        orderid,
        paymentmethod,
        status,
        {{ cents_to_dollars('amount') }} as amount
    from {{ source('stripe','payment') }}
)
select * from payment