resource "random_string" "tftraining" {
  length  = 8
  upper   = false
  lower   = true
  number  = false
  special = false
}

