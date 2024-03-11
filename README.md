# Loan Risk Analysis Pipeline on Azure 🏦🔍

This repository is dedicated to a cutting-edge loan risk analysis project, utilizing Azure's robust cloud services to predict loan defaults. The pipeline orchestrates the flow of loan data from ingestion to insightful visualizations, employing Python and SQL for data cleaning and transformation.


## Project Overview 📚

This loan risk analysis pipeline embarks on its journey by connecting with an on-premises SQL Server to ingest raw loan data. Utilizing Azure Data Factory, the raw data is securely transferred into Azure Data Lake Storage, earmarked for processing. Within Azure Databricks, Python scripts meticulously clean and transform the data, ensuring quality and relevance. The refined dataset is then subjected to further SQL-based transformations in Azure Synapse Analytics, setting the stage for advanced analytics. Finally, Power BI brings the data to life, offering deep insights into loan default risks through dynamic visualizations.

## Architecture 🏗️

![Architecture Diagram](https://media.licdn.com/dms/image/D4D22AQEMZF_R1bXZVQ/feedshare-shrink_800/0/1696683585675?e=2147483647&v=beta&t=90cNdVLMGR-W6ZFe5ZDbVYxcmqcFMDMdn5w-QnVqFh4 "Architecture Diagram")


## Key Technologies Used🛠️

- **Sql Server Management Studio**: Houses the raw data and used as On-prem resource here.
- **Azure Data Factory**: Automates data ingestion from on-premises to cloud. (Exhibit A - Please refer below)
- **Azure Data Lake Storage Gen2**: Hosts raw and processed data in a highly scalable data lake.
- **Azure Databricks**: Utilizes Python for robust data cleaning and transformation. (Exhibit B)
- **Azure Synapse Analytics**: Employs SQL for data modeling and further transformations. (Exhibit C)
- **Power BI**: Visualizes the processed data to uncover insights into loan default risks. (Exhibit D)

## Deployment Quickstart 🚀

1. **Provision Azure Resources through IaC - Extraction**: Resources are provisioned using Terraform for quick and automated setup. Deploy main.tf, variables.tf, provider.tf & terraform.tfvars for provisioning azure resources
2. **Linked Service Configurations**: Do the configurations between resources to integrate the services seamlessly.
3. **Data Cleaning and modeling - Transformation**: Execute Python script of Data Cleaning (Data_Cleaning_Databricks.ipynb) and ML Model (ML_Model_Databricks.ipynb) for cleaning and analysing the data.
4. **Storage**: Use Datalake to store both raw and cleaned data which are to be used for futher querries in synapse.
5. **Data Querrying - Transformation**: Further transformations or SQL querries (SQLQuery_Synapse.sql) can be written for analysing and creating views.
6. **Visualize in Power BI**: Connect Power BI to Azure Synapse Analytics to explore and share insights on loan default risks.

## Exhibits

1. Exhibit A

![](https://drive.google.com/file/d/1rb11tNqgvF_HZSFHplptqIBmMc5RtyRc)

---

Empower your loan risk assessment with data-driven insights today. 🚀
