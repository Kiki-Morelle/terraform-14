variable "bucket_name" {
  description = "Bucket name"
}

variable "aws_cross_origin_name" {
    description = "Cross origin access name"
}

variable "cloudfront_default_object" {
    default = "index.html"
}

variable "cloudfront_origin_id" {
    default = "S3-terraform.bandenkop.store"
}

variable "cert_domain" {

}

variable "dns_record" {

}

variable "hosted_zone_name" {
  
}