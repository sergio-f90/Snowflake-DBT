SELECT
    li.order_item_key,
    o.order_key,
    o.customer_key,
    o.order_date,
    li.status_code AS order_status_code,
    li.part_key,
    li.supplier_key,
    li.return_flag,
    li.line_number,
    li.ship_date,
    li.commit_date,
    li.receipt_date,
    li.ship_mode,
    li.extended_price / NULLIF(li.quantity, 0) AS item_price, --precio base por artículo en una línea de pedido
    li.discount_percentage,
    (li.extended_price * (1 - li.discount_percentage)) AS item_discounted_price, -- precio descontado por artículo en una línea de pedido
    li.extended_price,-- precio total articulo sin descuentos
    li.tax_rate,--tasa impuestos artículo
    ((li.extended_price + (-1 * li.extended_price * li.discount_percentage)) * li.tax_rate) AS item_tax_amount, -- cantidad total del impuesto calculado sobre el precio del artículo después de aplicar cualquier descuento
FROM
    tpch.orders o
JOIN
    tpch.lineitem li ON o.order_key = li.order_key
ORDER BY
    o.order_date;
