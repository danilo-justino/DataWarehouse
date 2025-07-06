# Data Catalog para a camada Gold 

## Overview
A camada Gold é a representação de dados em nível empresarial, estruturada para dar suporte a casos de uso analíticos e de relatórios. Ela consiste em **tabelas dimensões** e **tabela fato** para métricas comerciais específicas.

---

### 1. **gold.dim_customers**
- **Finalidade:** Armazena detalhes do cliente enriquecidos com dados demográficos e geográficos.
- **Colunas:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_key     | INT           | Surrogate key identificando exclusivamente cada registro de cliente na tabela de dimensão.    |
| customer_id      | INT           | Identificador numérico exclusivo atribuído a cada cliente.                                    |
| customer_number  | NVARCHAR(50)  | Identificador alfanumérico que representa o cliente, usado para rastreamento e referência.    |
| first_name       | NVARCHAR(50)  | O primeiro nome do cliente, conforme registrado no sistema.                                   |
| last_name        | NVARCHAR(50)  | O sobrenome ou o nome de família do cliente.                                                  |
| country          | NVARCHAR(50)  | O país de residência do cliente (e.g., 'Australia').                                          |
| marital_status   | NVARCHAR(50)  | O estado civil do cliente(e.g., 'Married', 'Single').                                         |
| gender           | NVARCHAR(50)  | O gênero do cliente (e.g., 'Male', 'Female', 'n/a').                                          |
| birthdate        | DATE          | A data de nascimento do cliente, formatada como YYYY-MM-DD (e.g., 1971-10-06).                |
| create_date      | DATE          | A data e a hora em que o registro do cliente foi criado no sistema                            |

---

### 2. **gold.dim_products**
- **Finalidade:** Fornece informações sobre os produtos e seus atributos.
- **Colunas:**

| Column Name         | Data Type     | Description                                                                                                     |
|---------------------|---------------|-----------------------------------------------------------------------------------------------------------------|
| product_key         | INT           | Surrogate key identificando de forma exclusiva cada registro de produto na tabela de dimensão do produto.       |
| product_id          | INT           | Um identificador exclusivo atribuído ao produto para rastreamento e referência internos.                        |
| product_number      | NVARCHAR(50)  | Um código alfanumérico estruturado que representa o produto, geralmente usado para categorização ou inventário. |
| product_name        | NVARCHAR(50)  | Nome descritivo do produto, incluindo detalhes importantes, como tipo, cor e tamanho.                           |
| category_id         | NVARCHAR(50)  | Um identificador exclusivo para a categoria do produto, vinculado à sua classificação de alto nível.            |
| category            | NVARCHAR(50)  | A classificação mais ampla do produto (e.g., Bikes, Components) para agrupar itens relacionados.                |
| subcategory         | NVARCHAR(50)  | Uma classificação mais detalhada do produto dentro da categoria, como o tipo de produto.                        |
| maintenance_required| NVARCHAR(50)  | Indica se o produto precisa de manutenção (e.g., 'Yes', 'No').                                                  |
| cost                | INT           | O custo ou preço base do produto, medido em unidades monetárias.                                                |
| product_line        | NVARCHAR(50)  | A linha ou série de produtos específica à qual o produto pertence (e.g., Road, Mountain).                       |
| start_date          | DATE          | A data em que o produto ficou disponível para venda ou uso, armazenado em                                       |

---

### 3. **gold.fact_sales**
- **Finalidade:** Armazena dados de vendas transacionais para fins analíticos.
- **Colunas:**

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_number    | NVARCHAR(50)  | Um identificador alfanumérico exclusivo para cada pedido de vendas (e.g., 'SO54496').         |
| product_key     | INT           | Surrogate key vinculando o pedido à tabela de dimensão do produto.                            |
| customer_key    | INT           | Surrogate key vinculando o pedido à tabela de dimensão do cliente.                            |
| order_date      | DATE          | A data em que o pedido foi feito.                                                             |
| shipping_date   | DATE          | A data em que o pedido foi enviado ao cliente.                                                |
| due_date        | DATE          | A data de vencimento do pagamento do pedido.                                                  |
| sales_amount    | INT           | O valor $ total da venda para o item de linha, em unidades monetárias inteiras (e.g., 25).    |
| quantity        | INT           | O número de unidades do produto pedido para o item de linha (e.g., 1).                        |
| price           | INT           | O preço por unidade do produto para o item de linha, em unidades $ inteiras (e.g., 25).       |
