provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "mosquitto" {
  name       = "mosquitto"

  repository = "https://k8s-at-home.com/charts/"
  chart      = "mosquitto"

  # values = [
  #   file("${path.module}/values.yaml")
  # ]

  set {
    name  = "env.TZ"
    value = "UTC"
  }
}
