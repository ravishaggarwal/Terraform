output "bucketname" {
  value = "${join(", ", aws_s3_bucket.mybucket.*.id)}"
}
