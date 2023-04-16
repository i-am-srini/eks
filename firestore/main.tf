locals {
  documents = fileexists("${path.module}/jsons/index.json") ? jsondecode(file("${path.module}/jsons/index.json")) : {}
}

module "firestore" {
  count         = var.enable_firestore ? 1 : 0
  source        = "../app_engine"
  project_id    = var.project_id
  location      = var.location
  create_app    = false
  database_type = "CLOUD_FIRESTORE"
}

resource "google_firestore_document" "firestore_document" {
  count       = fileexists("${path.module}/jsons/index.json") ? length(local.documents) : 0
  project     = var.project_id
  collection  = local.documents[count.index]["collection"]
  document_id = local.documents[count.index]["document_id"]
  fields      = jsonencode(local.documents[count.index]["fields"])
}
