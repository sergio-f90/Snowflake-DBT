{{ config(materialized = 'table') }}

WITH cust_reg_nat AS (
    SELECT
        c.c_custkey,
        c.c_name,
        c.c_address,
        c.c_acctbal,
        c.C_MKTSEGMENT,
        n.n_nationkey,
        n.N_NAME,
        r.r_regionkey,
        r.R_NAME
        
    FROM 
        tpch.customer c
    INNER JOIN tpch.nation n
        on c.c_nationkey=n.n_nationkey
    INNER JOIN tpch.region r 
        on n.N_REGIONKEY=r.r_regionkey
)
select 
    *
from
    cust_reg_nat
order by
    c_custkey