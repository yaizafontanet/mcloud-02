#Creació del security group per a la public subnet                                                       
resource "aws_security_group" "SG_public_subnet" {                                                        
    name        = "security_group_alb"                                                                
    description = "Allow HTTP - HTTPS"                                                                      
    vpc_id      =  aws_vpc.my_vpc.id                                                                                                                                                                                
    
    ingress {                                                                                                 
        description = "HTTP"                                                                            
        from_port   = 80                                                                                        
        to_port     = 80                                                                                        
        protocol    = "tcp"                                                                                     
        cidr_blocks = ["0.0.0.0/0"]                                                                         
    }                                                                                                                                                                                                              
    
    ingress {                                                                                                  
        description = "HTTPS"                                                                           
        from_port   = 443                                                                                        
        to_port     = 443                                                                                        
        protocol    = "tcp"                                                                                     
        cidr_blocks = ["0.0.0.0/0"]
                                                                                 
    }                                                                                                                                                                                                               
    
    egress {                                                                                                  
        from_port   = 0                                                                                         
        to_port     = 0                                                                                         
        protocol    = "-1"                                                                                      
        cidr_blocks = ["0.0.0.0/0"]                                                                           
    }                                                                                                     
    
}                                                                                                                                                                                                               

#Creació del security group per a la private subnet                                                      
resource "aws_security_group" "SG_private_subnet_" {                                                      
    name        = "security_group_ecs"                                                                    
    description = "ECS"                                                                                   
    vpc_id      =  aws_vpc.my_vpc.id                                                                                                                                                                                
    
    ingress {                                                                                                 
        description = "ecs"                                                                              
        from_port   = aws_vpc.container_port                                                                                      
        to_port     = aws_vpc.container_port                                                                                      
        protocol    = "tcp"                                                                                     
        cidr_blocks = ["0.0.0.0/0"]                                                                           
    }                                                                                                                                                                                                               
    
    egress {                                                                                                  
        from_port   = 0                                                                                         
        to_port     = 0                                                                                         
        protocol    = "-1"                                                                                      
        cidr_blocks = ["0.0.0.0/0"]                                                                           
    }                                                                                                     
    
}
