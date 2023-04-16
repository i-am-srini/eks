subnet_config = [
  {
    name   = "mci-config-subnet"
    ip     = "10.0.64.0/29"
    region = "us-east1"
    secondary_ranges = [
      {
        range_name    = "pod-ip-range"
        ip_cidr_range = "100.64.64.0/22"
      },
      {
        range_name    = "services-ip-range"
        ip_cidr_range = "100.64.68.0/26"
      }
    ]
  },
  {
    name   = "gke-cluster1-subnet"
    ip     = "10.0.65.0/27"
    region = "us-east1"
    secondary_ranges = [
      {
        range_name    = "pod-ip-range"
        ip_cidr_range = "100.64.72.0/22"
      },
      {
        range_name    = "services-ip-range"
        ip_cidr_range = "100.64.76.0/26"
      }
    ]
  },
  {
    name             = "bastion-host-subnet"
    ip               = "10.0.66.0/29"
    region           = "us-east1"
    secondary_ranges = []
  },
  {
    name   = "gke-cluster2-subnet"
    ip     = "10.1.64.0/27"
    region = "us-east1"
    secondary_ranges = [
      {
        range_name    = "pod-ip-range"
        ip_cidr_range = "100.65.64.0/22"
      },
      {
        range_name    = "services-ip-range"
        ip_cidr_range = "100.65.68.0/26"
      }
    ]
  }
]
