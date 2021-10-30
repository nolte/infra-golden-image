source "arm-image" "hypriotos" {
  iso_url           = "https://github.com/hypriot/image-builder-rpi/releases/download/v1.12.3/hypriotos-rpi-v1.12.3.img.zip"
  iso_checksum      = "sha256:9015ee2d8834254d561694a93d45c21b2d345cabfa6f1d44152b0d247eee9f7e"
  output_filename   = "../output-image/custom-hypriotos.img"
  target_image_size = 3 * 1024 * 1024 * 1024
  image_type        = "raspberrypi"
  qemu_binary       = "qemu-aarch64-static"
}
