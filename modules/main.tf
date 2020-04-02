provider "heroku" {
  version = "~> 2.0"
}

variable "app_name" {
  description = "The name of the app."
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
    url = "https://bitbucket.org/teapigsteam/findmytea-ui/get/master.tar.gz"
  }
}

output "app_url" {
  value = "https://${heroku_app.default.name}.herokuapp.com"
}


