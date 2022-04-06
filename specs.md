## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 2.99.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.7.1 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alertmanager"></a> [alertmanager](#module\_alertmanager) | ./modules/alertmanager | n/a |
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./modules/controller | n/a |
| <a name="module_grafana"></a> [grafana](#module\_grafana) | ./modules/grafana | n/a |
| <a name="module_kube-state-metrics"></a> [kube-state-metrics](#module\_kube-state-metrics) | ./modules/kube-state-metrics | n/a |
| <a name="module_letsencrypt_issuer"></a> [letsencrypt\_issuer](#module\_letsencrypt\_issuer) | ./modules/letsencrypt | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |
| <a name="module_prometheus-node-exporter"></a> [prometheus-node-exporter](#module\_prometheus-node-exporter) | ./modules/prometheus-node-exporter | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/container_registry) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.aks-rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.role_acrpull](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/role_assignment) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/2.7.1/docs/resources/namespace) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | ACR name | `string` | n/a | yes |
| <a name="input_alertmanager_replica"></a> [alertmanager\_replica](#input\_alertmanager\_replica) | number of alertmanager replicas | `number` | `1` | no |
| <a name="input_alertmanager_service_type"></a> [alertmanager\_service\_type](#input\_alertmanager\_service\_type) | type of kubernetes service for alertmanager | `string` | `"ClusterIP"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AKS name in Azure | `string` | n/a | yes |
| <a name="input_dev_shared_subscription_id"></a> [dev\_shared\_subscription\_id](#input\_dev\_shared\_subscription\_id) | subscription\_id | `string` | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | n/a | `string` | `"dserbenyukgood@gmail.com"` | no |
| <a name="input_grafana_replica"></a> [grafana\_replica](#input\_grafana\_replica) | number of grafana replicas | `number` | `"1"` | no |
| <a name="input_grafana_service_type"></a> [grafana\_service\_type](#input\_grafana\_service\_type) | type of kubernetes service for grafana | `string` | `"ClusterIP"` | no |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | n/a | `string` | `"nginx"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version | `string` | n/a | yes |
| <a name="input_kubestate_name_space"></a> [kubestate\_name\_space](#input\_kubestate\_name\_space) | defualt namespaace for metrics collector | `string` | `"kube-system"` | no |
| <a name="input_kubestate_replica"></a> [kubestate\_replica](#input\_kubestate\_replica) | number of kube-state-metrics replicas | `number` | `1` | no |
| <a name="input_location"></a> [location](#input\_location) | Resources location in Azure | `string` | n/a | yes |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Enable prometheus metrics | `bool` | `false` | no |
| <a name="input_monitoring_name_space"></a> [monitoring\_name\_space](#input\_monitoring\_name\_space) | defualt namespaace for monitoring management tooles | `string` | `"monitoring"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"letsencrypt-prod"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | defualt namespaace for monitoring management tooles | `string` | `"cert-manager"` | no |
| <a name="input_prometheus_node_port"></a> [prometheus\_node\_port](#input\_prometheus\_node\_port) | port to expose prometheus service | `string` | `"30000"` | no |
| <a name="input_prometheus_replica"></a> [prometheus\_replica](#input\_prometheus\_replica) | number of prometheus replicas | `string` | `"1"` | no |
| <a name="input_prometheus_service_type"></a> [prometheus\_service\_type](#input\_prometheus\_service\_type) | type of kubernetes service for prometheus | `string` | `"ClusterIP"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | RG name in Azure | `string` | n/a | yes |
| <a name="input_server"></a> [server](#input\_server) | n/a | `string` | `"https://acme-v02.api.letsencrypt.org/directory"` | no |
| <a name="input_system_node_count"></a> [system\_node\_count](#input\_system\_node\_count) | Number of AKS worker nodes | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | n/a |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | n/a |
| <a name="output_aks_fqdn"></a> [aks\_fqdn](#output\_aks\_fqdn) | n/a |
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | n/a |
| <a name="output_aks_node_rg"></a> [aks\_node\_rg](#output\_aks\_node\_rg) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Enable prometheus metrics |
