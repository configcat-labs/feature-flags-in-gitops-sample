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