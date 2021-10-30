
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
    source      = "files/cloud-init.yaml"
    destination = "/boot/user-data"
  }
}
