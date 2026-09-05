# Vpc 
module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = "192.168.0.0/16"
  vpc_name       = "Dev-vpc"

}
# Front end
module "frontend" {
  source                = "../../modules/frontendaws"
  bucket_name           = "frontend.bandenkop.store"
  aws_cross_origin_name = "Cross access from cloudfront"
  cert_domain           = "*.bandenkop.store"
  dns_record            = "frontend.bandenkop.store"
  hosted_zone_name      = "bandenkop.store"
}

