# Bucket to store general s3 data
# Bucket encrypted using default aws/s3 SSE-KMS key

// Following block ( most probably ) used for first time default aluas creation. Need to explore more .

data "aws_kms_alias" "gen-kms-for-s3" {
  provider = aws
  name     = "alias/aws/s3"
}



resource "aws_s3_bucket" "gen-s3-bucket" {
  bucket = var.bucket-name
  acl    = "private"

  versioning {
    enabled = true
  }
  lifecycle_rule {
    prefix  = "/"
    enabled = true

    noncurrent_version_transition {
      days          = 60
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
   server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = ""
      }
    }


  }
  
   tags = { Name = var.bucket-name }
}


resource "aws_s3_bucket_public_access_block" "gen-s3-bucket-bucket-pub-access-block" {
  bucket = aws_s3_bucket.gen-s3-bucket.id

 block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}


resource "aws_vpc_endpoint" "hmh_s3_vpc_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.endpoint_region}.s3"
}

# Assocate the S3 VPC-EP to NAT GW route table
resource "aws_vpc_endpoint_route_table_association" "hmh_s3_vpc_ep_assoc" {
  route_table_id  = var.route-table-id
  vpc_endpoint_id = aws_vpc_endpoint.hmh_s3_vpc_endpoint.id
}
