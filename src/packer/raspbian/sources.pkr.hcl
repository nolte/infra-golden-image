source "arm-image" "raspbian" {
  iso_url           = "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-05-28/2021-05-07-raspios-buster-armhf-lite.zip"
  iso_checksum      = "sha256:c5dad159a2775c687e9281b1a0e586f7471690ae28f2f2282c90e7d59f64273c"
  output_filename   = "../output-image/custom-raspbian.img"
  target_image_size = 3 * 1024 * 1024 * 1024
  image_type        = "raspberrypi"
  qemu_binary       = "qemu-aarch64-static"
}
