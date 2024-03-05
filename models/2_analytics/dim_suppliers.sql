{{ config(materialized = 'table') }}

WITH part_psup_sup AS (
    select 
        ps.PS_SUPPKEY, 
        p.P_PARTKEY,
        p.P_NAME,
        p.P_BRAND,
        p.P_NAME as part_name,
        p.P_SIZE,
        p.P_CONTAINER,
        p.p_retailprice,
        ps.PS_AVAILQTY,
        ps.PS_SUPPLYCOST,
        s.S_SUPPKEY,
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
            on p.P_PARTKEY = ps.PS_PARTKEY
        join
        supplier s
            on ps.PS_SUPPKEY = s.S_SUPPKEY
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
    S_SUPPKEY