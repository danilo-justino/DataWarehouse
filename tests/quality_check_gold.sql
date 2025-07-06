/*
===============================================================================
Quality Checks
===============================================================================
Objetivo do script:
 Esse script executa verificações de qualidade para validar a integridade, a consistência, 
 e a precisão da Gold Layer. Essas verificações garantem:
    - A exclusividade das chaves substitutas nas tabelas de dimensão.
    - Integridade referencial entre tabelas de fatos e de dimensões.
    - Validação de relacionamentos no modelo de dados para fins analíticos.

Notas de uso:
    - Investigar e resolver qualquer discrepânciaancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Verificação 'gold.dim_customers'
-- ====================================================================
-- Verificar a exclusividade da chave do cliente em gold.dim_customers
-- Expectativa: Nenhum resultado
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Verificação 'gold.product_key'
-- ====================================================================
-- Verificar a exclusividade da chave do produto em gold.dim_products
-- Expectativa: Nenhum resultado 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Verificação 'gold.fact_sales'
-- ====================================================================
-- Verificar a conectividade do modelo de dados entre fatos e dimensões
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  
