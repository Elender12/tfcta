resource "aws_s3_bucket" "ele-bucket" {
  bucket = "my-tf-test-bucket-ecirstea"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
