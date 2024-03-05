{{ config(materialized = 'view') }}
-- Promedio del costo de suministro del proveedor para las partes de tipo AUTOMOBILE
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
    -- Calcular el total de ventas por artículo
    SUM(fo.ORDER_COUNT * (p.P_RETAILPRICE - fo.ITEM_DISCOUNTED_AMOUNT)) OVER (PARTITION BY p.P_PARTKEY) AS total_sales_per_part,
    -- Calcular el promedio del costo de suministro por proveedor
    AVG(ps.PS_SUPPLYCOST) OVER (PARTITION BY s.S_SUPPKEY) AS avg_supply_cost_per_supplier
FROM
    FACT_ORDERS_LINE fo
JOIN
    CUSTOMER c ON fo.O_CUSTKEY = c.C_CUSTKEY
JOIN
    LINEITEM li ON fo.O_ORDERKEY = li.L_ORDERKEY
JOIN
    PART p ON li.L_PARTKEY = p.P_PARTKEY
JOIN
    PARTSUPP ps ON p.P_PARTKEY = ps.PS_PARTKEY
JOIN
    SUPPLIER s ON ps.PS_SUPPKEY = s.S_SUPPKEY
WHERE
    fo.O_ORDERSTATUS = 'F'  -- Filtrar solo las órdenes enviadas
    AND fo.O_ORDERDATE >= DATEADD(DAY, -7, CURRENT_DATE())  -- Filtrar órdenes de la última semana
    AND c.C_MKTSEGMENT = 'AUTOMOBILE'  -- Filtrar clientes del segmento de mercado de automóviles
ORDER BY
    fo.O_ORDERDATE
