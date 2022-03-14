#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "ant-project-node" {
  name = "terraform-eks-ant-project-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ant-project-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.ant-project-node.name
}

resource "aws_iam_role_policy_attachment" "ant-project-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.ant-project-node.name
}

resource "aws_iam_role_policy_attachment" "ant-project-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.ant-project-node.name
}

resource "aws_eks_node_group" "ant-project" {
  cluster_name    = aws_eks_cluster.ant-project.name
  node_group_name = "ant-project"
  node_role_arn   = aws_iam_role.ant-project-node.arn
  subnet_ids      = aws_subnet.public_subnets[*].id
  instance_types  = ["t2.small"]
  tags = {
    Name = "ant-project-nodegroup"
    Owner = "devops"
    Environment = "dev"
  }

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  depends_on = [
    aws_iam_role_policy_attachment.ant-project-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.ant-project-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.ant-project-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
