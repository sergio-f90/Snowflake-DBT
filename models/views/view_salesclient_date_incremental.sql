{{ config(materialized = 'incremental') }}

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
    ps.PS_SUPPLYCOST,
    -- calcular el total de ventas por cliente
    SUM(fo.ORDER_COUNT * (p.P_RETAILPRICE - fo.ITEM_DISCOUNTED_AMOUNT)) OVER (PARTITION BY c.C_CUSTKEY) AS total_sales_per_customer,
    -- Calcular el promedio del monto del impuesto por orden
    AVG(fo.ITEM_TAX_AMOUNT) OVER () AS avg_tax_amount_per_order,
    -- Clasificar las órdenes por fecha
    RANK() OVER (ORDER BY fo.O_ORDERDATE) AS order_date_rank
FROM
    FACT_ORDERS_LINE fo
JOIN
    CUSTOMER c ON fo.O_CUSTKEY = c.C_CUSTKEY
JOIN
    LINEITEM li ON fo.O_ORDERKEY = li.L_ORDERKEY
JOIN
    PART p ON li.L_PARTKEY = p.part_key
JOIN
    PARTSUPP ps ON p.part_key = ps.part_key
WHERE
    fo.O_ORDERSTATUS = 'F'  -- Filtrar solo las órdenes Finalizadas
    AND fo.O_ORDERDATE >= DATEADD(DAY, -1, CURRENT_DATE())  -- Filtrar solo órdenes de la última fecha
ORDER BY
    fo.O_ORDERDATE
