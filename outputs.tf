# https://registry.terraform.io/providers/hashicorp/aws/2.36.0/docs/resources/instance
# Documentação do resource instância ec2 com atributos do recurso disponíveis para utilização como output

output "instance_ip" {
  description = "IP da instancia ec2 criada na AWS"
  value = aws_instance.instance.public_ip    # Atributo de instância ec2 
}