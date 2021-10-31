
build {
  sources = [
    "source.arm-image.hypriotos",
  ]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y git vim"
    ]
  }

  provisioner "file" {
    content = templatefile("files/cloud-init.yaml", {
      hostname                    = var.hostname,
      username                    = var.user_name,
      user_user_plain_text_passwd = var.user_plain_text_passwd,
      ssh_pwauth                  = var.ssh_pwauth,
      ssh_authorized_key          = var.local_ssh_public_key,
      wpa_supplicant_country      = lower(var.wpa_supplicant_country),
      wifi_ssid                   = var.wifi_ssid,
      wifi_psk                    = var.wifi_psk,
    })
    destination = "/boot/user-data"
  }
}
