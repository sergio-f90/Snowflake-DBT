WITH orders_line_agg AS (
    SELECT 
        ol.O_ORDERKEY,
        ol.item_discounted_price as discounted_price_item,
        AVG(ol.item_discounted_price) AS avg_discounted_price,
        SUM(ol.item_discounted_price) AS item_discounted_amount,
        SUM(ol.item_tax_amount) AS item_tax_amount
    FROM 
        mid_orders_line ol
    GROUP BY
        ol.O_ORDERKEY,discounted_price_item
)
SELECT 
    o.O_ORDERKEY, 
    o.O_ORDERDATE,
    o.O_CUSTKEY,
    o.O_ORDERSTATUS,
    o.o_clerk,
    o.o_orderpriority,
    o.o_shippriority,
    1 AS order_count, 
    ol.discounted_price_item,
    ol.item_discounted_amount,
    ol.item_tax_amount,
    ol.avg_discounted_price
FROM
    tpch.orders o
INNER JOIN 
    orders_line_agg ol ON o.O_ORDERKEY = ol.O_ORDERKEY
ORDER BY
    o.o_orderdate
