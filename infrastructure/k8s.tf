resource "digitalocean_kubernetes_cluster" "k8s-cluster-1" {
  name    = "k8s-cluster-1"
  region  = "nyc1"
  version = "1.21.9-do.0"
  tags    = [
    "k8s:ha"
  ]

  node_pool {
    name       = "autoscale-worker-pool"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 5
  }
}
