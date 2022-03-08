#Configuració del terraform i aws                                                                                                                                                                                                 
terraform {                                                                                               
    required_providers {                                                                                    
        aws = {                                                                                                   
            source  = "hashicorp/aws"                                                                               
            version = "~> 3.26"                                                                                     
        }                                                                                                     
    }                                                                                                     
}                                                                                                                                                                                                               

provider "aws" {                                                                                          
    profile = "default"                                                                                     
    region  = "us-east-1"                                                                                 
}