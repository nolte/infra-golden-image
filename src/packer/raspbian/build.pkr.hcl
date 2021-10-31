
build {
  sources = [
    "source.arm-image.raspbian",
  ]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y git vim"
    ]
  }

  provisioner "file" {
    content = templatefile("files/wpa_supplicant.conf", {
      wpa_supplicant_country = upper(var.wpa_supplicant_country),
      wifi_ssid              = var.wifi_ssid,
      wifi_psk               = var.wifi_psk,
    })
    destination = "/etc/wpa_supplicant/wpa_supplicant.conf"
  }

  provisioner "file" {
    source      = "files/rfkill-unblock-wifi.service"
    destination = "/etc/systemd/system/rfkill-unblock-wifi.service"
  }

  provisioner "shell" {
    inline = [
      "systemctl enable rfkill-unblock-wifi.service",
    ]
  }

  # enable ssh in the pi.
  # if you don't know or don't care about ssh, delete these steps.
  provisioner "shell" {
    inline = ["touch /boot/ssh"]
  }

  # upload our public key as an authorized key.
  provisioner "shell" {
    inline = [
      "mkdir -p ${var.image_home_dir}/.ssh",
    ]
  }

  provisioner "file" {
    content = templatefile("files/authorized_keys", {
      authorized_keys = [var.ssh_public_key],
    })
    destination = "${var.image_home_dir}/.ssh/authorized_keys"
  }

  # change folder permissions and decativate the Password Authentication.
  # now
  provisioner "shell" {
    inline = [
      "chown -R pi:pi ${var.image_home_dir}/.ssh",
      "chmod 644 ${var.image_home_dir}/.ssh/authorized_keys",
      "sed '/PasswordAuthentication/d' -i /etc/ssh/sshd_config",
      "echo >> /etc/ssh/sshd_config",
      "echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config",
    ]
  }
}
