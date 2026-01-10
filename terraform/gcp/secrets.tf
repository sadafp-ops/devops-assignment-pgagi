resource "google_secret_manager_secret" "backend_env" {
  secret_id = "backend-env"

  replication {
    auto {}
  }

  lifecycle {
    prevent_destroy = true
  }
}
