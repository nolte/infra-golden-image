# Personalized Images 

This Repo will be help creating you own baseline. At the Moment the Focus will be, build Images for your Home Lab Cluster. 

This Process will be make it Possible work with a set of different Distributions. You have the most Important Configurations for starting your device like Network Configurations (WLAN) or handle the Technical User for maintenance. 

For the `arm` image creation we use the [solo-io/packer-plugin-arm-image](https://github.com/solo-io/packer-plugin-arm-image) Packer Plugin.

## Features

Different Distributions like:

* [hypriot](https://blog.hypriot.com/)
* [raspbian](https://www.raspbian.org/) *(planed)*
* [ubuntu](https://ubuntu.com/download/raspberry-pi) *(planed)*

Base Config Settings

* Wifi (ssid + pks)
* User with given Pubic Key for access.
* Updated packages from Image Creation Day.
* Minimize hardered System, like disabling  Password Auth.

## Tested Devices

* [raspberry-pi-4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)


## How to Use

This Repo holds sources for crating Images used [Packer](https://www.packer.io/) (like `src/packer/hypriot`) , and some [Ansible](https://www.ansible.com/) Sources (`src/ansible/sd-card`) for flashing the generated Images to some SD Card.

1. Generate your personal Image, by using [Packer](https://www.packer.io/)

```sh
cd src/packer

# create a hypriot based image 
# The container will be create a img, prepared for flash to your SD Card

docker run \
  --rm \
  --privileged \
  -w /build/hypriot \
  -v /dev:/dev \
  -v ${PWD}:/build:ro \
  -v ${PWD}/packer_cache:/build/packer_cache \
  -v ${PWD}/output-image:/build/output-image \
  -e PACKER_CACHE_DIR=/build/packer_cache \
  ghcr.io/solo-io/packer-plugin-arm-image build \
    -var local_ssh_public_key="$(pass private/keyfiles/ssh/private_ed25519/id_ed25519.pub)" \
    -var wifi_ssid=$(pass private/wlan/home/ssid) \
    -var wifi_psk=$(pass private/wlan/home/psk) \
    .
```

2. Copy the Image to somme sd Card, with [ansible](https://www.ansible.com/).

```sh
# Move to the Playbook Folder
cd src/ansible/sd-card

# Copy the Image to given SD Card
docker run \
   --device=/dev/sda \
   --privileged \
   -w /workspace \
   -v $(pwd):/workspace \
   -v ${PWD}/../../packer/output-image:/tmp/img:ro \
   --rm ansible/ansible-runner \
   ansible-playbook main.yml --extra-vars "os_hostname=flasher sd_card_image=/tmp/img/custom-hypriotos.img"

```

3. Start the Device, now you can connect by using the Private key for your SSH connection and then you can Configuration the node.
