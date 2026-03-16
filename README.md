# Ipad pro to Raspberry PI 4

## Overview
This is a custom DIY project for programmers who own an Ipad but have no idea how to make it a useful daily essential.
This configuration allows you directly create a peer-to-peer connection between the Ipad and the raspberry pi.
You'll be able to ssh and vnc to the pi through your ipad even without an internet connection.
This project includes my personal Neovim setup with my custom keybinds for those of you who use Neovim

## What do you need to complete this setup?
* An Ipad
* A raspberry pi 4 (I haven't tried any others yet)
* A usb-c to usb-c cable
* A usb-c hub that has an ethernet port and a usb-c port
* An ethernet cable

## Steps into completing configuration

### 1. Install Raspberry Pi OS
Flash Raspberry Pi OS to the SD card.
* Use Raspberry Pi Imager.
* Enable in advanced options:
* SSH
* set username/password
* set WiFi
* enable hostname
* Insert SD card and boot Pi

### 2. Install Required Packages
SSH into the Pi:
```bash
ssh hostname@raspberrypi.local
```
Update packages:
```bash
sudo apt update
sudo apt install -y iptables network-manager
```

### 3. Create the Gateway Script
paste the script:
```bash
sudo nano /usr/local/bin/pi-all-in-one.sh
````
now paste in the pi-all-in-one.sh file in here, save and exit the file.
make sure to change the primary and seconday wifi along with the password.
I usually like to set my primary wifi as my home network and the secondary one as my mobile hotspot.
Make executable:
```bash
sudo chmod +x /usr/local/bin/pi-all-in-one.sh
````

### 4. Create the systemd Service
Create the service:
````bash
sudo nano /etc/systemd/system/pi-all-in-one.service
````
now paste in the pi-all-in-one.service file in here, save and exit the file.

### 5. Enable the Service
Reload systemd:
````bash
sudo systemctl daemon-reload
````
Enable the service:
````bash
sudo systemctl enable pi-all-in-one.service
````
Start it:
````bash
sudo systemctl start pi-all-in-one.service
````
Check Status:
````bash
sudo systemctl status pi-all-in-one.service
````
You should see:
````bash
[*] Starting Pi gateway service
[+] Internet available on Ethernet gateway
````

### 6. Configure the Ipad
On the iPad:

Settings → WiFi → Ethernet
Set:
IP Address: 192.168.50.2

Subnet: 255.255.255.0

Router: 192.168.50.1

Now the iPad routes internet through the Pi.

### 7. Connect to the PI through the ssh
Install an application on the ipad called ISH
open it and run these commands:
`````bash
apk update
apk add openssh-client
``````
Now you can ssh into the PI
run this command:
`````bash
ssh hostname@192.168.50.1
``````
Input your password and you should be good to go

## By this point you are fully set however if you want to setup VNC and Neovim the steps are as follows

### 8. VNC configuration
*Install an application on your Ipad called Real-vnc-viewer
*once installed open it and press the plus sign in the top right hand corner
*input as follows, Adress: 192.168.50.1:5900      Name: This can be any name of your choice
*You should get prompted with the username and password and the VNC setup should be configured

### 9. Installation and configuration of NeoVim









