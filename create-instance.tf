#Instancia de Wordpress                                                             
resource "aws_key_pair" "keypair" {                                                               
    key_name    = "joc-key-pair"                                                                      
    public_key  = "${file("joc-key-pair.pub")}"                                                                                                                                                                   
}                                                                                                                                                                                                                                                                                                                       

resource "aws_instance" "WordPress" {                                                                     
    depends_on = [aws_internet_gateway.public_internet_gw]                                                  
    ami           = "ami-04ad2567c9e3d7893"                                                                 
    instance_type = "t2.micro"                                                                              
    key_name = aws_key_pair.keypair.key_name                                                                
    subnet_id = aws_subnet.public_subnet.id                                                                 
    vpc_security_group_ids = [aws_security_group.SG_public_subnet.id]                                       
    user_data = "${file("script.sh")}"                                                                      
    tags = {                                                                                                   
        Name = "WEB"                                                                                         
    }                                                                                                                                                                                                              
    provisioner "local-exec" {                                                                               
        command = "echo ${aws_instance.WordPress.public_ip} > public.txt"                                    
    }                                                                                                                                                                                                              
}                                                                                                                                                                                                               

#Instancia de la BBDD - RDS                                                                            
resource "aws_db_instance" "DataBase" {                                                                   
    allocated_storage = 20                                                                               
    max_allocated_storage = 100                                                                             
    storage_type = "gp2"                                                                            
    engine = "mysql"                                                                          
    engine_version = "5.7.22"                                                                         
    instance_class = "db.t2.micro"                                                                    
    name = "mcloud"                                                                           
    username = "yaiza"                                                                          
    password = "yaiza12345"                                                                     
    parameter_group_name = "default.mysql5.7"                                                               
    publicly_accessible = false                                                                             
    db_subnet_group_name = aws_db_subnet_group.db_subnet.name                                               
    vpc_security_group_ids = [aws_security_group.SG_private_subnet_.id]                                     
    skip_final_snapshot = true                                                                                                                                                                                    
    provisioner "local-exec" {                                                                                
        command = "echo ${aws_db_instance.DataBase.endpoint} > BBDD-RDS.txt"                                       
    }                                                                                                                                                                                                           
} 
