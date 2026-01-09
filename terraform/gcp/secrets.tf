resource "google_secret_manager_secret" "app_secret" {
  secret_id = "backend-secret"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "app_secret_value" {
  secret      = google_secret_manager_secret.app_secret.id
  secret_data = "example-secret-value"
}
