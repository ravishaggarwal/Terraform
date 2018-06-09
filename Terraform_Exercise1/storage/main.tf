resource "random_id" "mybucket_randomId" {
  byte_length = 2
  count = 2

}
resource "aws_s3_bucket" "mybucket" {
  count         = 2
  bucket        = "${var.project_name}-${random_id.mybucket_randomId.*.dec[count.index]}"
  acl           = "private"
  force_destroy = true
  tags {
    Name = "mybucket_${var.env}"
  }
}
