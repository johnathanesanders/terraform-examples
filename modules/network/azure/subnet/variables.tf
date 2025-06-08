variable "address_prefixes" {
    default = ["10.0.0.0/24"]
    description = "Address prefixes for the subnet"
    type = list(string)
}

variable "default_outbound_access_enabled" {
    default = true
    description = "(Optional) Enable default outbound access to the internet for the subnet. Defaults to true."
    type = bool
}

variable "delegation" {
    default = null
    description = "(Optional) Delegation to services for the subnet."
    nullable = true
    type = object({
        name = string
        service_delegation = object({
            name  = string
            actions = list(string)
        })
    })
    validation {
        condition = anytrue([
           try(var.delegation == null,
            contains([
                "GitHub.Network/networkSettingsGitHub.Network/networkSettings", "Informatica.DataManagement/organizations", "Microsoft.ApiManagement/service", "Microsoft.Apollo/npu", "Microsoft.App/environments", "Microsoft.App/testClients", "Microsoft.AVS/PrivateClouds", "Microsoft.AzureCosmosDB/clusters", "Microsoft.BareMetal/AzureHostedService", "Microsoft.BareMetal/AzureHPC", "Microsoft.BareMetal/AzurePaymentHSM", "Microsoft.BareMetal/AzureVMware", "Microsoft.BareMetal/CrayServers", "Microsoft.BareMetal/MonitoringServers", "Microsoft.Batch/batchAccounts", "Microsoft.CloudTest/hostedpools", "Microsoft.CloudTest/images", "Microsoft.CloudTest/pools", "Microsoft.Codespaces/plans", "Microsoft.ContainerInstance/containerGroups", "Microsoft.ContainerService/managedClusters", "Microsoft.ContainerService/TestClients", "Microsoft.Databricks/workspaces", "Microsoft.DBforMySQL/flexibleServers", "Microsoft.DBforMySQL/servers", "Microsoft.DBforMySQL/serversv2", "Microsoft.DBforPostgreSQL/flexibleServers", "Microsoft.DBforPostgreSQL/serversv2", "Microsoft.DBforPostgreSQL/singleServers", "Microsoft.DelegatedNetwork/controller", "Microsoft.DevCenter/networkConnection", "Microsoft.DevOpsInfrastructure/pools", "Microsoft.DocumentDB/cassandraClusters", "Microsoft.Fidalgo/networkSettings", "Microsoft.HardwareSecurityModules/dedicatedHSMs", "Microsoft.Kusto/clusters", "Microsoft.LabServices/labplans", "Microsoft.Logic/integrationServiceEnvironments", "Microsoft.MachineLearningServices/workspaces", "Microsoft.Netapp/volumes", "Microsoft.Network/dnsResolvers", "Microsoft.Network/managedResolvers", "Microsoft.Network/fpgaNetworkInterfaces", "Microsoft.Network/networkWatchers.", "Microsoft.Network/virtualNetworkGateways", "Microsoft.Orbital/orbitalGateways", "Microsoft.PowerPlatform/enterprisePolicies", "Microsoft.PowerPlatform/vnetaccesslinks", "Microsoft.ServiceFabricMesh/networks", "Microsoft.ServiceNetworking/trafficControllers", "Microsoft.Singularity/accounts/networks", "Microsoft.Singularity/accounts/npu", "Microsoft.Sql/managedInstances", "Microsoft.Sql/managedInstancesOnebox", "Microsoft.Sql/managedInstancesStage", "Microsoft.Sql/managedInstancesTest", "Microsoft.Sql/servers", "Microsoft.StoragePool/diskPools", "Microsoft.StreamAnalytics/streamingJobs", "Microsoft.Synapse/workspaces", "Microsoft.Web/hostingEnvironments", "Microsoft.Web/serverFarms", "NGINX.NGINXPLUS/nginxDeployments", "PaloAltoNetworks.Cloudngfw/firewalls", "Qumulo.Storage/fileSystems", "and Oracle.Database/networkAttachments Informatica.DataManagement/organizations", "Microsoft.ApiManagement/service", "Microsoft.Apollo/npu", "Microsoft.App/environments", "Microsoft.App/testClients", "Microsoft.AVS/PrivateClouds", "Microsoft.AzureCosmosDB/clusters", "Microsoft.BareMetal/AzureHostedService", "Microsoft.BareMetal/AzureHPC", "Microsoft.BareMetal/AzurePaymentHSM", "Microsoft.BareMetal/AzureVMware", "Microsoft.BareMetal/CrayServers", "Microsoft.BareMetal/MonitoringServers", "Microsoft.Batch/batchAccounts", "Microsoft.CloudTest/hostedpools", "Microsoft.CloudTest/images", "Microsoft.CloudTest/pools", "Microsoft.Codespaces/plans", "Microsoft.ContainerInstance/containerGroups", "Microsoft.ContainerService/managedClusters", "Microsoft.ContainerService/TestClients", "Microsoft.Databricks/workspaces", "Microsoft.DBforMySQL/flexibleServers", "Microsoft.DBforMySQL/servers", "Microsoft.DBforMySQL/serversv2", "Microsoft.DBforPostgreSQL/flexibleServers", "Microsoft.DBforPostgreSQL/serversv2", "Microsoft.DBforPostgreSQL/singleServers", "Microsoft.DelegatedNetwork/controller", "Microsoft.DevCenter/networkConnection", "Microsoft.DevOpsInfrastructure/pools", "Microsoft.DocumentDB/cassandraClusters", "Microsoft.Fidalgo/networkSettings", "Microsoft.HardwareSecurityModules/dedicatedHSMs", "Microsoft.Kusto/clusters", "Microsoft.LabServices/labplans", "Microsoft.Logic/integrationServiceEnvironments", "Microsoft.MachineLearningServices/workspaces", "Microsoft.Netapp/volumes", "Microsoft.Network/dnsResolvers", "Microsoft.Network/managedResolvers", "Microsoft.Network/fpgaNetworkInterfaces", "Microsoft.Network/networkWatchers.", "Microsoft.Network/virtualNetworkGateways", "Microsoft.Orbital/orbitalGateways", "Microsoft.PowerPlatform/enterprisePolicies", "Microsoft.PowerPlatform/vnetaccesslinks", "Microsoft.ServiceFabricMesh/networks", "Microsoft.ServiceNetworking/trafficControllers", "Microsoft.Singularity/accounts/networks", "Microsoft.Singularity/accounts/npu", "Microsoft.Sql/managedInstances", "Microsoft.Sql/managedInstancesOnebox", "Microsoft.Sql/managedInstancesStage", "Microsoft.Sql/managedInstancesTest", "Microsoft.Sql/servers", "Microsoft.StoragePool/diskPools", "Microsoft.StreamAnalytics/streamingJobs", "Microsoft.Synapse/workspaces", "Microsoft.Web/hostingEnvironments", "Microsoft.Web/serverFarms", "NGINX.NGINXPLUS/nginxDeployments", "PaloAltoNetworks.Cloudngfw/firewalls", "Qumulo.Storage/fileSystems", "Oracle.Database/networkAttachments"
            ], var.delegation.service_delegation.name))
        ])
        error_message = "Delegation must match valid service delegation supported by the module."
    }
    validation {
        condition = anytrue([
            try(var.delegation == null,
            var.delegation.service_delegation == null,
            alltrue([
                for o in var.delegation.service_delegation.actions : contains([
                    "Microsoft.Network/networkinterfaces/*", "Microsoft.Network/publicIPAddresses/join/action", "Microsoft.Network/publicIPAddresses/read", "Microsoft.Network/virtualNetworks/read", "Microsoft.Network/virtualNetworks/subnets/action", "Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
                ], o)
            ]))
        ])
        error_message = "Values must be one of Microsoft.Network/networkinterfaces/*, Microsoft.Network/publicIPAddresses/join/action, Microsoft.Network/publicIPAddresses/read, Microsoft.Network/virtualNetworks/read, Microsoft.Network/virtualNetworks/subnets/action, Microsoft.Network/virtualNetworks/subnets/join/action, Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action, or Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action."
    }
}

variable "name" {
    default = "default"
    description = "Name of the subnet"
    type = string
}

variable "private_endpoint_network_policies" {
    default = "Disabled"
    description = "(Optional) Enable or Disable network policies for the private endpoint on the subnet."
    nullable = true
    type = string
    validation {
        condition = contains([
            "Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
        error_message = "Private Network Endpoint Policy must be one of Disabled, Enabled, NetworkSecurityGroupEnabled, or RouteTableEnabled."
    }
}

variable "private_link_service_network_policies_enabled" {
    default = true
    description = "(Optional) Enable private link service network policies. Defaults to true."
    nullable = true
    type = bool
}

variable "resource_group" {
    type = object({
        location = string
        name = string
    })
}

variable "service_endpoints" {
    default = []
    description = "Service endpoints for the subnet"
    nullable = true
    type = list(string)
    validation {
        condition = alltrue([
            for o in var.service_endpoints : contains([
                "Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Storage.Global", "Microsoft.Web"
            ], o)
        ])
        error_message = "Service Endpoints must match valid service endpoints supported by the module."
    }
}

variable "service_endpoint_policy_ids" {
    default = []
    description = "(Optional) Service endpoint policy IDs for the subnet"
    nullable = true
    type = list(string)
}

variable "virtual_network_name" {
    description = "Name of the virtual network"
    type = string
}