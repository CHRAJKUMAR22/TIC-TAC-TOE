# -------------------------------
# EKS CLUSTER
# -------------------------------
resource "aws_eks_cluster" "eks_cluster" {
  name     = "EKS_CLOUD"
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = "1.30"

  vpc_config {
    subnet_ids              = data.aws_subnets.filtered.ids
    endpoint_private_access = false
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# -------------------------------
# NODE GROUP
# -------------------------------
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node-cloud"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = data.aws_subnets.filtered.ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  ami_type = "AL2_x86_64"

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy
  ]
}
