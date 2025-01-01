terraform {
  backend "gcs" {
    bucket = "starlit-brand-446515-p8-tfstate"
    prefix = "terraform/eth-node/state"
  }
} 