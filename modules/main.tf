provider "heroku" {
  version = "~> 2.0"
}

variable "app_name" {
  description = "Test heroku TDD app."
}

resource "heroku_app" "default" {
    name = var.app_name
    region = "eu"

    buildpacks = [
      "mars/create-react-app"
    ]
}

resource "heroku_build" "default" {
  app = heroku_app.default.name
  source = {
    url = "https://github.com/beatniq/findmytea/tarball/master"
  }
}

output "app_url" {
  value = "https://${heroku_app.default.name}.herokuapp.com"
}


