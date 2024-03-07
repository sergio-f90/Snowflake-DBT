{{ config(materialized = 'table') }}

WITH part_psup_sup AS (
    select 
        ps.part_supplier_key, 
        p.part_key,
        p.P_NAME,
        p.P_BRAND,
        p.P_NAME as part_name,
        p.P_SIZE,
        p.P_CONTAINER,
        p.p_retailprice,
        ps.PS_AVAILQTY,
        ps.PS_SUPPLYCOST,
        s.supplier_key,
        s.S_NAME,
        s.S_ADDRESS,
        s.S_ACCTBAL,
        n.n_nationkey,
        n.N_NAME as supplier_nation_name,
        r.r_regionkey as supplier_region_key,
        r.R_NAME as supplier_region_name
       
    from
        part p
        join
        partsupp ps
            on p.part_key = ps.part_key
        join
        supplier s
            on ps.supplier_key = s.supplier_key
        join
        nation n
            on s.S_NATIONKEY = n.n_nationkey
        join
        region r
            on n.N_REGIONKEY = r.r_regionkey
)
select 
    *
from
    part_psup_sup
order by
    part_key