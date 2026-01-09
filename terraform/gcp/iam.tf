# resource "google_service_account" "cloudrun_sa" {
#   account_id   = "cloudrun-sa"
#   display_name = "Cloud Run Service Account"
# }

# resource "google_project_iam_member" "cloudrun_sa_role" {
#   project = var.project_id
#   role    = "roles/run.invoker"
#   member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
# }
