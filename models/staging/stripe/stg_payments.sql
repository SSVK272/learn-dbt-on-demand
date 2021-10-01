with payment as (
    select 
        orderid,
        amount
    from raw.stripe.payment
)
select * from payment