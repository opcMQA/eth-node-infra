terraform {
  # Backend configuration is commented out for local development
  # Uncomment and configure when ready for production
  /*
  backend "gcs" {
    bucket = "starlit-brand-446515-p8-tfstate"
    prefix = "terraform/eth-node/state"
  }
  */
} 