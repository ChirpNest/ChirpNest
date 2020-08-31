# ChirpNest


<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
<!--
*** [![Contributors][contributors-shield]][contributors-url]
*** [![Forks][forks-shield]][forks-url]
*** [![Stargazers][stars-shield]][stars-url]
*** [![Issues][issues-shield]][issues-url]
*** [![MIT License][license-shield]][license-url]
*** [![LinkedIn][linkedin-shield]][linkedin-url]
-->

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/ChirpNest/ChirpNest">
    <img src="images/logo.jpg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">ChirpNest</h3>

  <p align="center">
    The internetless Iot solution
    <br />
    <a href="https://github.com/ChirpNest/ChirpNest"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ChirpNest/ChirpNest">View Demo</a>
    ·
    <a href="https://github.com/ChirpNest/ChirpNest/issues">Report Bug</a>
    ·
    <a href="https://github.com/ChirpNest/ChirpNest/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project

[TODO]

<!-- GETTING STARTED -->
## Getting Started

Follow this guide to set up and start with ChirpNest

### Prerequisites

* LORIX One with power over ethernet cable
* Power supply
* SD card (minimum 8 GB, 10 MB/s writing speed or more recommended)
* ChirpNest image file for LORIX One
* ADT1 device
* Windows computer
  * SD card reader
  * Browser
  * SSH client
* Flashing software (e.g. balenaEtcher from balena.io/etcher)
* Local network that allows communication between the computer and the LORIX One

### Installation

#### Prepare the LORIX One device
Insert the SD card into the Windows computer and flash the ChirpNest image onto it using the third-party flashing software.
Connect the LORIX One to the local network, put the SD card into the LORIX One and power it.

#### Configure ChirpNest via SSH
Discover the IP address of the LORIX One e.g. through a web interface on the router.
Connect to the LORIX One using an SSH client.
Username: “admin”
Password: “admin”
In Windows 10, PowerShell can be used with the following command (replace “IP_Address” with the actual IP address of the LORIX One):
```sh
ssh admin@IP_Address
```
When connected to the LORIX One, type the following command:
```sh
sudo gateway-config
```
Enter the password “admin” again when prompted.

Select “Configure channel-plan” using the arrow buttons and enter.
Select “EU868 4dBi (outdoor)”.
Confirm the following four messages with enter.
Select “Quit”.
Check if date and time are correct with the following command:
```sh
$	date
```
If date and time are not correct, set it with the following command (enter the current UTC time):
```sh
$	sudo date -s '2020-06-09 07:10:00'
```
Terminate the SSH connection by entering the following command:
```sh
exit
```

#### Configure ChirpNest through the ChirpStack Web Interface
Connect to the LORIX One ChirpStack web interface with a browser on port 8080 (i.e. call http://IP_Address:8080 and replace “IP_Address” with the actual IP address of the LORIX One).
Log in using the following credentials:
Username: “admin”
Password: “admin”

Navigate to “Network-servers”, click the “+ Add” button, enter the following data and click “Add network-server”:

* General
  * Network-server name: “ChirpNest-Network-Server”
  * Network-server server: “localhost:8000”
* Gateway discovery
  * leave all fields unchanged
* TLS certificates
  * leave all fields unchanged

Navigate to “Service-profiles”, click the “+ Create” button, enter the following data and click “Create service-profile”:
* Service-profile name: “ChirpNest-Service-Profile”
* Network-server: select “ChirpNest-Network-Server”
* remaining fields: leave unchanged

Navigate to “Device-profiles”, click the “+ Create” button, enter the following data and click “Create device-profile” (the following parameters are chosen specifically for and tested with the ADT1; using OTAA instead of ABP should also be possible):
* General
  * Device-profile name: “device_profile_1.0.2_B_abp_ADT1”
  * Network-server: select “ChirpNest-Network-Server”
  * LoRaWAN MAC version: select “1.0.2”
  * LoRaWAN Regional Parameters revision: select “B”
  * remaining fields: leave unchanged
* Join (OTAA / ABP)
  * leave all fields unchanged
* Class-B
  * leave all fields unchanged
* Class-C
  * leave all fields unchanged
* Codec
  * Payload codec: select “Custom JavaScript codec functions”
  * Decode function:
paste the decode function, see “Decode function for ADT1” on page 119
make sure the function signature is function Decoder(port, bytes)
* Encode function:
leave unchanged

Navigate to “Applications”, click the “+ Create” button, enter the following data and click “Create application”:
* Application name: “ChirpNest-Application”
* Application description:
“This is the single application configured on this ChirpNest environment.”
* Service-profile: select “ChirpNest-Service-Profile”

Navigate to “Applications”, select the single existing application “ChirpNest-Application” (click on the name) which navigates to the “Devices” tab of that application, then click the “+ Create” button, enter the following data and click “Create device”:

* General
  * Device name: enter any name consisting of letters, numbers and hyphens (e.g. “ADT1­No­92” where 92 is the serial number)
  * Device description: enter any description (e.g. “ADT1 with serial number 92”)
  * Device EUI: enter the device EUI of your device (e.g. “00 9D 6B 00 00 C5 D2 4F”)
  * Device-profile: select “device_profile_1.0.2_B_abp_ADT1”
  * Disable frame-counter validation: check
* Variables
  * leave unchanged
  *	Tags
* leave unchanged

Navigate to “Applications”, select the single existing application “ChirpNest-Application” (click on the name) which navigates to the “Devices” tab of that application, select the single existing device just created before (click on the name), switch to the “Activation” tab, enter the following data and click “(Re)activate device”:
* Device address:
enter the device address of your device (e.g. “26 01 16 83”) or click the round arrow to generate a new device address which must then be configured on the ADT1
* Network session key (LoRaWAN 1.0):
enter the network session key of your device (e.g. “E6 19 A5 8F 1F 1F 84 F2 C3 0B 2E EA 1E 1F B4 7D”) or click the round arrow to generate a new network session key which must then be configured on the ADT1
* Application session key (LoRaWAN 1.0):
enter the application session key of your device (e.g. “F5 32 68 0E C0 4C C4 95 7D AA FC 5E 34 CC 6E 35”) or click the round arrow to generate a new application session key which must then be configured on the ADT1
* Uplink frame-counter: leave “0”
* Downlink frame-counter: leave “0”

Now the ADT1 is configured and activated. You can verify by opening the “Device data” tab on your newly created device configuration and then sending a measurement packet (see “Configure ADT1 Device” below). Note that the “Device data” tab must be opened before the measurement is sent.

Last step: Send the information packet from the ADT1 device so the details of the device are stored in ChirpNest (see “Configure ADT1 Device” below). After that, the configuration of ChirpNest is complete.

#### Connect KIWI Desktop with ChirpNest
When ChirpNest is set up, KIWI Desktop can simply be connected to ChirpNest by entering the IP address of the LORIX One.

#### Configure ADT1 Device
This section explains how the required parameters “device EUI”, “device address”, “network session key” and “application session key” can be read out and/or configured.
The software “GSM setup for remote transmission units” needs to be installed on the Windows computer. It can be downloaded from here:
https://keller-druck.com/en/products/software/desktop-applications/gsm-setup-for-remote-transmission-units
Connect the ADT1 device to the Windows computer using a Micro USB cable.
Select the corresponding COM port and press the “Read Configuration” button (see screenshot).

[TODO: Add GSM Setup screentshot]

To read out or configure said parameters, switch to the “LoRa Settings” tab. The parameters are then displayed (see screenshot). To configure the parameters, select “ABP” as “Activation Methode” and enter the parameters. Press the “Write Configuration” button after entering the parameters.

[TODO: Add GSM Setup screentshot]

To send the information packet from the ADT1 device, switch to the “Error/Status” tab and press the “Send Info LoRa” button (see screenshot).

[TODO: Add GSM Setup screentshot]

To manually trigger sending a measurement packet, the button “Send Measure-Data LoRa” can be pressed.

#### Decode function for ADT1
The decode function is provided by KELLER in a GitHub repository.

Follow this URL:
https://github.com/KELLERAGfuerDruckmesstechnik/KellerAgTheThingsNetworkPayloadDecoder

The actual function is in the file “PayloadDecoderFunction.js”.

Important: ChirpStack required another function signature than The Things Network. For this reason, function Decoder(bytes, port) has to be changed to function Decoder(port, bytes).

#### Create ChirpNest Image

Navigate to the folder where the repository should be created and clone it:

```sh
$	git clone https://github.com/ChirpNest/ChirpNest
```
Run the following commands:
```sh
$	make submodules
$	make permissions
$	sudo docker-compose run --rm busybox
```
(indented commands are to be run within the docker machine)
```sh
    $	chown 999:999 /build
    $	exit
$	sudo docker-compose run --rm yocto bash
    $	source oe-init-build-env /build/ /chirpstack-gateway-os/bitbake/
``` 
   The configurations should already be correct. However, if a configuration needs to be edited, now is the moment to do that. 
```sh
    $	nano conf/local.conf
    $	nano conf/bblayers.conf
```
   Run the following command to start creating the image:
```sh
    $	bitbake chirpstack-gateway-os-full
```
   Continue:
```sh
$	/chirpstack-gateway-os/scripts/chirpstack-prepare-deploy
$	exit
```
Now, the file ending with .sdimg.gz is the image file. It’s located here:
```sh
$	ls -l ./deploy/wifx/lorix-one-512-sd/3.2.0test1/
```



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/github_username/repo_name/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/ChirpNest/ChirpNest](https://github.com/ChirpNest/ChirpNest)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

<!--
* []()
* []()
* []()
-->




<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo.svg?style=flat-square
[contributors-url]: https://github.com/github_username/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo.svg?style=flat-square
[forks-url]: https://github.com/github_username/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo.svg?style=flat-square
[stars-url]: https://github.com/github_username/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo.svg?style=flat-square
[issues-url]: https://github.com/github_username/repo/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo.svg?style=flat-square
[license-url]: https://github.com/github_username/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/github_username
[product-screenshot]: images/screenshot.png
