variable "project_name" {}
variable "billing_account" {}
#variable "org_id" {}
variable "region" {}

provider "google" {
 region = "${var.region}"
}

resource "random_id" "id" {
 byte_length = 4
 prefix      = "${var.project_name}-"
}

resource "google_project" "project" {
 name            = "${var.project_name}"
 project_id      = "${random_id.id.hex}"
 billing_account = "${var.billing_account}"
# org_id          = "${var.org_id}"
}

resource "google_project_services" "project" {
 project = "${google_project.project.project_id}"
 services = [
   "compute.googleapis.com",
   "iam.googleapis.com",
   "container.googleapis.com",
   "deploymentmanager.googleapis.com"   
 ]
}

resource "google_project_iam_member" "project" {
  project = "${google_project.project.project_id}"
  role    = "roles/owner"
  member  = "serviceAccount:gce-enforcer-exemption@ce-gce-enforcer-service-acct.iam.gserviceaccount.com"
}


output "project_id" {
 value = "${google_project.project.project_id}"
}