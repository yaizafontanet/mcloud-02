provider "aws" {
  version    = "~> 3.26"
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}