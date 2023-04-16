module "datastore" {
  count         = var.enable_datastore ? 1 : 0
  source        = "../app_engine"
  project_id    = var.project_id
  location      = var.location
  create_app    = false
  database_type = "CLOUD_DATASTORE_COMPATIBILITY"
}

resource "google_datastore_index" "indexes" {
  for_each = fileexists("${path.module}/indexes/index.yaml") ? { for index in yamldecode(file("${path.module}/indexes/index.yaml")).indexes : join("_", index.properties[*].name) => index } : {}
  kind     = each.value.kind
  ancestor = lookup(each.value, "ancestor", false) ? "ALL_ANCESTORS" : "NONE"
  project  = var.project_id
  dynamic "properties" {
    for_each = { for property in each.value.properties : property.name => property }
    content {
      name      = properties.value.name
      direction = lookup(properties.value, "direction", "asc") == "asc" ? "ASCENDING" : "DESCENDING"
    }
  }
}
