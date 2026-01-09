#################################
# Backend Cloud Run Service
#################################

resource "google_cloud_run_service" "backend" {
  name     = "backend"
  location = var.region

  template {
    spec {
      containers {
        image = var.backend_image

        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "backend_public" {
  service  = google_cloud_run_service.backend.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}

#################################
# Frontend Cloud Run Service
#################################

resource "google_cloud_run_service" "frontend" {
  name     = "frontend"
  location = var.region

  template {
    spec {
      containers {
        image = var.frontend_image

        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = google_cloud_run_service.backend.status[0].url
        }

        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "frontend_public" {
  service  = google_cloud_run_service.frontend.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}
