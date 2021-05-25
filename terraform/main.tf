provider "google" {
  region = "europe-west2"
  zone   = "europe-west2-a"
}

resource "google_cloud_run_service" "default" {
  name     = "terraform-hello-world"
  location = "europe-west2"

  template {
    spec {
      containers {
        image = "eu.gcr.io/core-advice-314810/hello-world:v0.0.1"
        env {
          name = "MESSAGE"
          value = "Hello Everybody!"
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
