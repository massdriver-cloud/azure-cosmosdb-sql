## Azure Cosmos DB SQL

Azure Cosmos DB SQL is a globally distributed, multi-model database service designed for managing data at a large scale with low latency and high availability. It offers fast performance, scalability, and seamless integration with other Azure services.

### Design Decisions

- **Consistency Levels**: Supports `Strong`, `BoundedStaleness`, `Session`, `ConsistentPrefix`, and `Eventual`, configurable based on the client's requirements.
- **Geo-Redundancy**: Options for automatic failover and multi-region writes to enhance resilience.
- **Network Security**: Virtual network filters are enabled, with public network access disabled by default.
- **Backup**: Configurable for either `Continuous` or `Periodic` backups catering to different data recovery needs.
- **Serverless**: Supports serverless configurations offering dynamic scaling for unpredictable workloads.

### Runbook

#### Unable to Connect to Azure Cosmos DB SQL

This problem might occur due to network security configurations or incorrect authentication details.

Check the connection string and authentication info:

```sh
az cosmosdb keys list --name <cosmosdb_account_name> --resource-group <resource_group> --type keys
```

You should expect to see the primary and secondary keys.

#### High RU Usage Alerts

If you're receiving alerts about high RU (Request Unit) usage, investigate which operations are consuming the most RU/s.

Use the Azure portal metrics:

```sh
az monitor metrics list --resource <cosmosdb_account_resource_id> --metric "NormalizedRUConsumption"
```

Look into the recent metrics and evaluate if your throughput settings are adequate.

#### High Server Latency

High server latency might indicate the need for throughput scaling or that the database is under heavy load.

Check the current server latency metrics:

```sh
az monitor metrics list --resource <cosmosdb_account_resource_id> --metric "ServerSideLatency"
```

#### Data Consistency Issues

If you experience data consistency issues, ensure the consistency level is appropriately set as per your application's requirements.

Check the current consistency level:

```sh
az cosmosdb show --name <cosmosdb_account_name> --resource-group <resource_group> --query "consistencyPolicy"
```

For consistency level changes, plan during low-traffic periods and verify with business requirements.

#### Backup Configuration Issues

If backups are not functioning as expected, verify the backup settings.

```sh
az cosmosdb show --name <cosmosdb_account_name> --resource-group <resource_group> --query "backupPolicy"
```

Check for settings that might be incorrectly configured, like backup interval and retention.

#### Checking Data Throughput Limit

Examine the total throughput settings to ensure they match your workload.

```sh
az cosmosdb sql container throughput show --resource-group <resource_group> --account-name <cosmosdb_account_name> --database-name <database_name> --name <container_name>
```

This ensures that your container has the appropriate throughput setting to handle the load.

Ensure to respond to any anomalies or updates reflected by these commands to maintain optimal performance and reliability of your Azure Cosmos DB SQL service.

