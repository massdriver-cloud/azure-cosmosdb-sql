[![Massdriver][logo]][website]

# azure-cosmosdb-sql

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]


Azure Cosmos DB SQL is a fully managed NoSQL database for modern app development using Azure CosmosDB's SQL API.


---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle


<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark | Description |
|--------|---------------|
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS AZURE](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=CIS+AZURE+V1.1) | Center for Internet Security, AZURE Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/azure-cosmosdb-sql/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fazure-cosmosdb-sql&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`backups`** *(object)*: Enable and configure backups for your database (cannot be changed after deployment).
  - **`backup_type`** *(string)*: The backup type to use for the Cosmos DB account (cannot be changed after deployment). Must be one of: `['None', 'Continuous', 'Periodic']`. Default: `None`.
- **`database`** *(object)*
  - **`consistency_level`** *(string)*: The consistency level to use for this CosmosDB Account. Default: `Session`.
    - **One of**
      - Strong (highest consistency, highest latency, lower throughput)
      - Bounded Staleness (consistency, latency, and throughput varies)
      - Session (strong consistency for client session)
      - Consistent Prefix (similar to eventual, but guarantees order)
      - Eventual (lowest consistency, lowest latency, high throughput)
  - **`serverless`** *(boolean)*: Default: `False`.
  - **`total_throughput_limit`** *(integer)*: The total throughput limit imposed on this Cosmos DB account in RU/s (-1 means no limit). Minimum: `-1`. Maximum: `10000000000000000`.
- **`geo_redundancy`** *(object)*
  - **`additional_regions`** *(array)*: Default: `[]`.
    - **Items** *(object)*: Configuration of a failover region region.
      - **`failover_priority`** *(integer)*: The failover priority of the region. The lower the value, the higher the priority is. Minimum value is 2, maximum value is 100. Minimum: `2`. Maximum: `100`.
      - **`location`** *(string)*: The Azure region to host replicated data.
        - **One of**
          - North Central US
          - South Central US
          - East US
          - East US 2
          - West US
          - West US 3
  - **`automatic_failover`** *(boolean)*: Default: `False`.
  - **`multi_region_writes`** *(boolean)*: Default: `False`.
- **`monitoring`** *(object)*
  - **`mode`** *(string)*: Enable and customize Function App metric alarms. Default: `AUTOMATED`.
    - **One of**
      - Automated
      - Custom
      - Disabled
- **`network`** *(object)*
  - **`auto`** *(boolean)*: Enabling this will automatically select an available CIDR range for your database. Unchecking will require you to specify the CIDR. Default: `True`.
## Examples

  ```json
  {
      "__name": "Development",
      "backups": {
          "backup_type": "None"
      },
      "database": {
          "serverless": true,
          "total_throughput_limit": 100000
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "backups": {
          "backup_type": "Continuous"
      },
      "database": {
          "serverless": false,
          "total_throughput_limit": -1
      },
      "geo_redundancy": {
          "automatic_failover": true
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`azure_service_principal`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`client_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

    - **`client_secret`** *(string)*
    - **`subscription_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

    - **`tenant_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

  - **`specs`** *(object)*
- **`azure_virtual_network`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`default_subnet_id`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

      - **`id`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

  - **`specs`** *(object)*
    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
        - **One of**
          - East US
          - North Central US
          - South Central US
          - West US
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`cosmosdb_sql_authentication`** *(object)*: Cosmos DB SQL authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`**: CosmosDB SQL connection string. Cannot contain additional properties.
      - **`hostname`** *(string)*: An HTTPS endpoint URL.

        Examples:
        ```json
        "https://example.com/some/path"
        ```

        ```json
        "https://massdriver.cloud"
        ```

      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cosmos DB SQL infrastructure configuration. Cannot contain additional properties.
      - **`ari`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

  - **`specs`** *(object)*
    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
        - **One of**
          - East US
          - North Central US
          - South Central US
          - West US
<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/azure-cosmosdb-sql/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/azure-cosmosdb-sql.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/azure-cosmosdb-sql/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/azure-cosmosdb-sql.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/azure-cosmosdb-sql/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/azure-cosmosdb-sql.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/azure-cosmosdb-sql/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/azure-cosmosdb-sql.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/azure-cosmosdb-sql/issues
[release_url]: https://github.com/massdriver-cloud/azure-cosmosdb-sql/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/azure-cosmosdb-sql.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/azure-cosmosdb-sql.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/azure-cosmosdb-sql/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=azure-cosmosdb-sql&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
