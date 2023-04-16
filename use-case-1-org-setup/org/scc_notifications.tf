module "pubsub_scc_notification" {
  count  = var.create_pub_sub ? 1 : 0
  source = "../../modules/pubsub"

  topic_name   = "scc_notification_topic"
  project_id   = module.scc_notifications.project_id
  create_topic = true
  enable_cmek  = var.enable_cmek_pubsub
}

module "scc_notification" {
  source  = "terraform-google-modules/gcloud/google"
  version = "~> 1.1.0"

  additional_components = var.skip_gcloud_download ? [] : ["alpha"]

  create_cmd_entrypoint = "gcloud"
  create_cmd_body       = <<-EOF
    scc notifications create ${var.scc_notification_name} --organization ${var.org_id} \
    --description "SCC Notification for all active findings" \
    --pubsub-topic projects/${module.scc_notifications.project_id}/topics/${module.pubsub_scc_notification[0].topic_name} \
    --filter "${var.scc_notification_filter}" \
    --project "${module.scc_notifications.project_id}" \
    --impersonate-service-account=${var.terraform_service_account}
EOF

  destroy_cmd_entrypoint = "gcloud"
  destroy_cmd_body       = <<-EOF
  scc notifications delete organizations/${var.org_id}/notificationConfigs/${var.scc_notification_name} \
  --impersonate-service-account ${var.terraform_service_account} \
  --project "${module.scc_notifications.project_id}" \
  --quiet
  EOF
  skip_download          = var.skip_gcloud_download
}
