With region AS (
   SELECT R_REGIONKEY,R_NAME
   FROM tpch.region
)
Select * from region