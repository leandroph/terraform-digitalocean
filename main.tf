terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_fbcdbf009d1c3ca44046f2231d111fe4a4e2fc57ac0ef4c3d815e3b4c34c4835"
}