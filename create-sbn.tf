#Creació de la Public Subnet per a Wordpress                                                                  
resource "aws_subnet" "public_subnet" {                                                                   
    vpc_id     = aws_vpc.my_vpc.id                                                                          
    cidr_block = "10.0.1.0/24"                                                                              
    map_public_ip_on_launch = true                                                                                                                                                                                  
    tags = {                                                                                                  
        Name = "public_subnet"                                                                                
    }                                                                                                     
}                                                                                                                                                                                                               

#Creació de la Private Subnet per a la base de dades                                                                  
resource "aws_subnet" "private_subnet" {                                                                  
    vpc_id     = aws_vpc.my_vpc.id                                                                          
    cidr_block = "10.0.2.0/24"                                                                                                                                                                                      
    tags = {                                                                                                  
        Name = "private_subnet"                                                                               
    }                                                                                                     
}                                                                                                                                                                                                               

#Creació del Subnet group sota la nostra VPC                                                          
resource "aws_db_subnet_group" "db_subnet" {                                                              
    name = "rds"                                                                                   
    subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.public_subnet.id ]                                                                                                                                       
    tags = {                                                                                                  
        Name = "Grup subnet de la BBDD"                                                                          
    }                                                                                                     
}

