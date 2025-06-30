/*
===============================================================================
Quality Checks
===============================================================================
Objetivo do script:
 Esse script executa várias verificações de qualidade para consistência, precisão, 
 e padronização de dados na camada “prata”. Ele inclui verificações de:
    - Chaves primárias nulas ou duplicadas.
    - Espaços indesejados em campos de string.
    - Padronização e consistência de dados.
    - Intervalos de datas e pedidos inválidos.
    - Consistência de dados entre campos relacionados.

Notas de uso:
    - Execute essas verificações após o carregamento de dados do Silver Layer.
    - Investigue e resolva quaisquer discrepâncias encontradas durante as verificações.
===============================================================================
*/

-- ====================================================================
-- Verificação 'silver.crm_cust_info'
-- ====================================================================
-- Verificação de NULLs ou duplicatas na chave primária
-- Expectativa: Nenhum resultado
SELECT 
    cst_id,
    COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    cst_key 
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT 
    cst_marital_status 
FROM silver.crm_cust_info;

-- ====================================================================
-- Verificação 'silver.crm_prd_info'
-- ====================================================================
-- Verificar se há NULLs ou duplicatas na chave primária
-- Expectativa: Nenhum resultado
SELECT 
    prd_id,
    COUNT(*) 
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Verificação de espaços indesejados
-- Expectativa: Nenhum resultado
SELECT 
    prd_nm 
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Verificação de NULLs ou valores negativos no custo
-- Expectativa: Nenhum resultado
SELECT 
    prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Padronização e consistência de dados
SELECT DISTINCT 
    prd_line 
FROM silver.crm_prd_info;

-- Verificaçar se Date Orders (Start Date > End Date) estão inválidas
-- Expectativa: Nenhum resultado
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ====================================================================
-- Verificação 'silver.crm_sales_details'
-- ====================================================================
-- Verificação de datas inválidas
-- Expectativa: Nenhuma data inválida
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Verificar se Date Orders (Order Date > Shipping/Due Dates) está invalido
-- Expectativa: Sem resultados
SELECT 
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Verificar a consistência dos dados: Sales = Quantity * Price
-- Expectativa: Sem resultados
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ====================================================================
-- Verificação 'silver.erp_cust_az12'
-- ====================================================================
-- Identificação de datas fora do intervalo
-- Expectativa: Datas de nascimento entre 1924-01-01 e hoje
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Padronização e consistência de dados
SELECT DISTINCT 
    gen 
FROM silver.erp_cust_az12;

-- ====================================================================
-- Verificação 'silver.erp_loc_a101'
-- ====================================================================
-- Padronização e consistência de dados
SELECT DISTINCT 
    cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ====================================================================
-- Verificação 'silver.erp_px_cat_g1v2'
-- ====================================================================
-- Verificação de espaços indesejados
-- Expectativa: Nenhum resultado
SELECT 
    * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Padronização e consistência de dados
SELECT DISTINCT 
    maintenance 
FROM silver.erp_px_cat_g1v2;
