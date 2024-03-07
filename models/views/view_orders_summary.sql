{{ config(materialized = 'view') }}
--Esta vista proporciona un análisis detallado de las órdenes de compra(beneficio,margen,etc.) de productos para clientes del segmento de mercado "HOUSEHOLD" (familiar)
-- entre los años 1992 y 1993
SELECT
    fo.O_ORDERKEY,
    fo.O_ORDERDATE,
    fo.O_CUSTKEY,
    c.C_MKTSEGMENT,
    fo.discounted_price_item,
    fo.ITEM_TAX_AMOUNT,
    p.P_NAME AS PART_NAME,
    ps.PS_SUPPLYCOST,
    -- Calcular el total de ventas por artículo
    SUM(fo.ORDER_COUNT * ( fo.discounted_price_item -p.P_RETAILPRICE)) OVER (PARTITION BY p.PART_KEY) AS total_sales_per_part,
    -- Calcular el beneficio total por pedido(dpi-> valor item con descuento(entra),p_retail-> precio de venta al público de un artículo,ps_supply-> precio que la empresa paga al proveedor por cada unidad )
    SUM((fo.discounted_price_item - p.P_RETAILPRICE - ps.PS_SUPPLYCOST) * fo.ORDER_COUNT) OVER (PARTITION BY fo.O_ORDERKEY) AS total_profit_per_order,
    -- Calcular el margen de beneficio
    ROUND((SUM(( fo.discounted_price_item -p.P_RETAILPRICE - ps.PS_SUPPLYCOST) * fo.ORDER_COUNT) OVER (PARTITION BY fo.O_ORDERKEY) / SUM(p.P_RETAILPRICE * fo.ORDER_COUNT) OVER (PARTITION BY fo.O_ORDERKEY)) * 100, 2) AS profit_margin_per_order
FROM
    FACT_ORDERS_LINE fo
JOIN
    CUSTOMER c ON fo.O_CUSTKEY = c.C_CUSTKEY
JOIN
    PART p ON fo.O_CUSTKEY = p.part_key
JOIN
    PARTSUPP ps ON p.part_key = ps.part_key
WHERE
    fo.O_ORDERDATE BETWEEN '1992-01-01' AND '1993-12-31'  -- Filtrar órdenes entre 1992 y 1993
    AND c.C_MKTSEGMENT = 'HOUSEHOLD'  -- Filtrar clientes del segmento de mercado  HOUSEHOLD(familiar)
ORDER BY
    fo.O_ORDERDATE

