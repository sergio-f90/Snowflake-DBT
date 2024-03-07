{{ config(materialized = 'view') }}

SELECT
    fo.O_ORDERKEY,
    fo.O_ORDERDATE,
    fo.O_CUSTKEY,
    c.CUSTOMER_NAME,
    c.CUSTOMER_ADDRESS,
    c.C_MKTSEGMENT,
    fo.O_ORDERSTATUS,
    fo.O_CLERK,
    fo.O_ORDERPRIORITY,
    fo.O_SHIPPRIORITY,
    fo.ORDER_COUNT,
    fo.ITEM_DISCOUNTED_AMOUNT,
    fo.ITEM_TAX_AMOUNT,
    p.P_NAME AS PART_NAME,
    p.P_TYPE AS PART_TYPE,
    p.P_SIZE AS PART_SIZE,
    p.P_CONTAINER AS PART_CONTAINER,
    ps.PS_SUPPLYCOST
FROM
    FACT_ORDERS_LINE fo
JOIN
    CUSTOMER c ON fo.O_CUSTKEY = c.C_CUSTKEY
JOIN
    PART p ON fo.O_CUSTKEY  = p.part_key
JOIN
    PARTSUPP ps ON p.part_key = ps.part_key
ORDER BY
    fo.O_ORDERDATE
