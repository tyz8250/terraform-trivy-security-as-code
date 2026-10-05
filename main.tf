variable "vpc_id" {
  type = string
}

resource "aws_security_group" "dangerous_ssh" {
  name        = "dangerous-ssh"
  description = "Intentionally insecure security group for Trivy testing"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "dangerous_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"

  cidr_blocks       = ["203.0.113.10/32"]
  description       = "Allow SSH from trusted IP only"

  security_group_id = aws_security_group.dangerous_ssh.id
}