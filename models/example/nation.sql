With nation AS (
   SELECT
      N_NATIONKEY,N_NAME,
      N_REGIONKEY
   FROM tpch.nation
)

Select * from nation