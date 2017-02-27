provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "sfg" {
  bucket = "trp-shared-dev-us-east-1-sfg"
  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.sfg.arn}"
}


data "aws_iam_policy_document" "sfg-s3-policy-doc" {
    statement {
        actions = [
            "s3:*",
        ]
        resources = [
            "arn:aws:s3:::${var.s3_bucket_name}/home/&{aws:username}",
            "arn:aws:s3:::${var.s3_bucket_name}/home/&{aws:username}/*",
        ]
    }
}
/*
resource "aws_iam_policy" "sfg-s3-policy" {
    name = "mft-application-sfg-policy"
    path = "/"
    policy = "${data.aws_iam_policy_document.sfg-s3-policy-doc.json}"
}
*/
