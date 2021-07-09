terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
}

data "digitalocean_ssh_key" "terraform-key" {
  name = "Blink-rsa-Curt-iPad"
}
