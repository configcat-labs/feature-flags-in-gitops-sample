provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "flask_api" {
  name    = "flask-api:latest"
  build   = "."
  force_remove = true
}

resource "docker_container" "flask_api" {
  name    = "flask-api-container"
  image   = docker_image.flask_api.latest
  ports {
    internal = 5000
    external = 5000
  }
}

# Setup your provider
terraform {
  required_providers {
    configcat = {
      source  = "configcat/configcat"
      version = "~> 4.0"
    }
  }
}

provider "configcat" {
}

#  Organization Resource is ReadOnly.
data "configcat_organizations" "my_organizations" {
  name_filter_regex = "ConfigCat"
}

resource "configcat_product" "my_product" {
  organization_id = data.configcat_organizations.my_organizations.organizations[0].organization_id
  name            = "My product"
  order           = 0
}

resource "configcat_config" "my_config" {
  product_id = configcat_product.my_product.id
  name       = "My config"
  order      = 0
}

resource "configcat_setting" "is_awesome" {
  config_id    = configcat_config.my_config.id
  key          = "isAwesomeFeatureEnabled"
  name         = "My awesome feature flag"
  hint         = "This is the hint for my awesome feature flag"
  setting_type = "boolean"
  order        = 0
}
