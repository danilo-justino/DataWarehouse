# DataWarehouse
Data Warehouse SQL Server


# 🏗️ Arquitetura de Dados
A arquitetura de dados para este projeto segue as camadas Bronze, Silver e Gold da Arquitetura Medallion:

 ![image](https://github.com/user-attachments/assets/c567e307-76a2-4df0-bb69-aa2f8f9c2d23)

1. **Camada Bronze:** Armazena dados brutos no estado em que se encontram nos sistemas de origem. Os dados são ingeridos de arquivos CSV para o banco de dados do SQL Server.
2. **Camada Silver:** Essa camada inclui processos de limpeza, padronização e normalização de dados para preparar os dados para análise.
3. **Camada Gold:** Abriga dados prontos para os negócios, modelados em um esquema em estrela necessário para relatórios e análises.

# 🚀 Requisitos do Projeto
 **Construindo o Data Warehouse (Engenharia de dados)**
 
**Objetivo**
Desenvolver um data warehouse moderno usando o SQL Server para consolidar os dados de vendas, permitindo a geração de relatórios analíticos e a tomada de decisões informadas.

 **Especificações**
* Fontes de dados: Importar dados de dois sistemas de origem (ERP e CRM) fornecidos como arquivos CSV.
* Qualidade dos dados: Limpar e resolver problemas de qualidade de dados antes da análise.
* Integração: Combinar as duas fontes em um modelo de dados único e fácil de usar, projetado para consultas analíticas.
* Escopo: Concentre-se apenas no conjunto de dados mais recente; a historização dos dados não é necessária.
* Documentação: Forneçer uma documentação clara do modelo de dados para dar suporte às partes interessadas do negócio e as equipes de análise.
