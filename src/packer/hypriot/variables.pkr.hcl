
variable "image_home_dir" {
  type    = string
  default = "/home/pi"
}

variable "wifi_ssid" {
  type = string
}

variable "wifi_psk" {
  type      = string
  sensitive = true
}

variable "wpa_supplicant_country" {
  type    = string
  default = "DE"
}

variable "local_ssh_public_key" {
  type = string
}

locals {
  ssh_key = "${pathexpand(var.local_ssh_public_key)}"
}


variable "hostname" {
  type    = string
  default = "black-pearl"
}

variable "user_name" {
  type    = string
  default = "pirate"
}

variable "user_plain_text_passwd" {
  type    = string
  default = "hypriot"
}
variable "ssh_pwauth" {
  type    = bool
  default = false
}
