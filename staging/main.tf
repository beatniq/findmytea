provider "heroku" {
  version = "~> 2.0"
}

module "app" {
    source = "../modules"
    app_name = "findmytea-stage"
}
