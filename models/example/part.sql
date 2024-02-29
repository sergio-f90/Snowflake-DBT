With part AS (
   SELECT P_PARTKEY, P_NAME, P_MFGR, P_BRAND, P_TYPE, 
      P_SIZE, P_CONTAINER, P_RETAILPRICE
   FROM tpch.part
)
Select * from part

