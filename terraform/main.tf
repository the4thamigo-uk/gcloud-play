provider "google" {
  region = "europe-west2"
  zone   = "europe-west2-a"
}

data "google_secret_manager_secret_version" "message" {
  secret = "message"
}

resource "google_cloud_run_service" "default" {
  name     = "terraform-hello-world"
  location = "europe-west2"

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal"
      "run.googleapis.com/ingress-status" = "internal"
    }
  }

  template {
    spec {
      containers {
        image = "eu.gcr.io/core-advice-314810/hello-world:v0.0.1"
        env {
          name = "MESSAGE"
          value = data.google_secret_manager_secret_version.message.secret_data 
        }
      }
    }
  }
  autogenerate_revision_name = true
}

terraform {
  backend "gcs" {
    bucket = "core-advice-314810"
    prefix = "terraform/state"
  }
}
