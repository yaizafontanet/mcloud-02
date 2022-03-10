region = "us-east-1"
rds_instance_identifier = "terraform-mysql"
database_name = "mcloud"
database_user = "yaiza"
database_password = "yaiza12345"
s3_bucket_name = "springboot-s3-example"
amis = {
  "us-east-1" = "ami-04ad2567c9e3d7893"
}
instance_type = "t2.micro"
autoscaling_group_min_size = 3
autoscaling_group_max_size = 5