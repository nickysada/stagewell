terraform {
  backend "gcs" {
    bucket = ""  # Update the bucket name
    prefix = ""   # Update virtual directory structure within GCS bucket where terraform will store its state file. 
  }
}