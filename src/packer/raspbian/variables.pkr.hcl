
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

variable "ssh_public_key" {
  type = string
}

variable "system_user" {
  type    = string
  default = "pirate"
}

