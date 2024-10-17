#Prática de criação de bucket AWS

terraform {

  # required_version = "= 1.3.0"                 Versão precisa ser igual a 1.3.0
  # required_version = ">= 1.0.0, < 1.3.0"       Versão pode ser maior ou igual a 1.0.0 e menor que 1.3.0
  # required_version = "~> 1.0.0"                #Versão pode ser de 1.0.0 até 1.0.n, n=maior versao de patch

  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.67.0"
    }
  }

  # https://developer.hashicorp.com/terraform/language/backend/s3
  # Declaração de um backend para armazenamento remoto do arquivo de state deste código
  backend "s3" {
     
    #Backend referencia para exercicio de remote state
    bucket = "johnz-remote-state"                       # Nome do bucket em bucket.tf que armazenará o arquivo de state, mesmo usado em outros exercicios, porém alterando o PATH  
    key    = "aws-vm-provisioners/terraform.tfstate"    # Altero o PATH para criar outro somente para o state desse exercicio de provisioner sem sobreescrever o anterior
    region = "sa-east-1"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs
#Documentação com referência de argumentos declaráveis para o bloco provider AWS
provider "aws" {

  #https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
  #Documentação com a lista de regiões disponíveis na AWS
  region = "sa-east-1"

  # AWS permite a declaração de tags default no bloco provider, ao contrário da Azure, por exemplo
  default_tags {
    tags = {
      owner      = "joaozordan"
      managed-by = "terraform"
    }
  }
}


# https://developer.hashicorp.com/terraform/language/backend/s3#data-source-configuration
# Documentação para criação do data source remote state

# Criação do data source que irá acessar o state remoto armazenado no bucket johnz-remote-state criado em exercício anterior do curso
data "terraform_remote_state" "vpc" {
  backend = "s3"                          # Define o tipo do backend que será acessado, onde se encontra o state que é necessário
  config = {                              # Configuração de acesso
    bucket = "johnz-remote-state"         # Nome do bucket
    key    = "aws-vpc/terraform.tfstate"  # Path onde está o arquivo de state criado no código de criação da VPC
    region = "sa-east-1"
  }
}
