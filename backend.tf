terraform {
  backend "s3" {
    bucket = "wwt-state-bucket"
    key    = "lab-state-files/state.tfstate"
    region = "us-west-1"
  }
}
