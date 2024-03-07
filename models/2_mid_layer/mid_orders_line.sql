{{
    config(
        materialized='table',
        cluster_by=['o_orderdate']
    )
}}

with mid_orders_line AS (
    SELECT
        li.L_ORDERKEY,
        o.O_ORDERKEY,
        o.O_CUSTKEY,
        o.O_ORDERDATE,
        li.L_LINESTATUS AS order_status_code,
        li.L_PARTKEY,
        li.L_SUPPKEY,
        li.L_RETURNFLAG,
        li.L_LINENUMBER,
        li.L_SHIPDATE,
        li.L_COMMITDATE,
        li.L_RECEIPTDATE,
        li.L_SHIPMODE,
        li.L_EXTENDEDPRICE / NULLIF(li.L_QUANTITY, 0) AS item_price, --precio base por artículo en una línea de pedido
        li.L_DISCOUNT,
        (li.L_EXTENDEDPRICE * (1 - li.L_DISCOUNT)) AS item_discounted_price, -- precio descontado por artículo en una línea de pedido
        li.L_EXTENDEDPRICE,-- precio total articulo sin descuentos
        li.L_TAX,--tasa impuestos artículo
        ((li.L_EXTENDEDPRICE + (-1 * li.L_EXTENDEDPRICE * li.L_DISCOUNT)) * li.L_TAX) AS item_tax_amount -- cantidad total del impuesto calculado sobre el precio del artículo después de aplicar cualquier descuento
    FROM
        tpch.lineitem li
    JOIN
        tpch.orders o ON o.O_ORDERKEY = li.L_ORDERKEY
    ORDER BY
        o.O_ORDERDATE
)
SELECT * FROM mid_orders_line
