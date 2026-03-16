# Ipad pro to Raspberry PI 4

## Overview
* This is a custom DIY project for programmers who own an Ipad but have no idea how to make it a useful daily essential.
* This configuration allows you directly create a peer-to-peer connection between the Ipad and the raspberry pi.
* You'll be able to ssh and vnc to the pi through your ipad even without an internet connection.
* This project includes my personal Neovim setup with my custom keybinds for those of you who use Neovim

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
* Install an application on your Ipad called Real-vnc-viewer
* Once installed open it and press the plus sign in the top right hand corner
* Input as follows,    Adress: 192.168.50.1:5900          Name: This can be any name of your choice
* You should get prompted with the username and password and the VNC setup should be configured

### 9. Installation and configuration of NeoVim
* run this command:
  ```bash
  sudo apt install neovim -y
  ````
* Create a nvim config dir
  ````bash
  mkdir -p ~/.config/nvim
  ````
* open this file
  ````bash
  nano ~/.config/nvim/init.lua
  ````
  and paste in the init.lua file, save and exit
* The lua file expects packer, so install it:
  ````bash
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  ````
* Open up Neovim
  ````bash
  nvim
  ````
* Then install the plugins like this:
  ````bash
  :PackerSync
  ````
* Whenever you install new plugins just run:
    ````bash
  :PackerSync
  ````




## Nvim custom keybinds included in the lua file


NEOVIM SHORTCUT CHEAT SHEET

MODES:
* i          -> insert mode
* a          -> insert after cursor
* o          -> new line below
* crl + [        -> return to normal mode

NAVIGATION:
* h          -> move left
* j          -> move down
* k          -> move up
* l          -> move right
* b        -> beginning of previous word
* e        -> end of next work
* gg         -> go to top of file
* G          -> go to bottom of file
* 0          -> start of line
* $          -> end of line
* w          -> next word
* b          -> previous word
* number + k      -> Moves to that number up
* number + j       -> Moves to that number down

EDITING:
* dd         -> delete line
* yy         -> copy line
* p          -> paste
* u          -> undo
* Ctrl+r     -> redo
* x          -> delete character
* cw         -> change word

SEARCH
* /word      -> search for "word"
* n          -> next result
* N          -> previous result

FILES
* :w         -> save file
* :q         -> quit
* :wq        -> save and quit
* :q!        -> quit without saving
* :qa        -> quit all files

SPLITS (GENERIC VIM)
* :split     -> horizontal split
* :vsplit    -> vertical split
* Ctrl+w h   -> move to left split
* Ctrl+w j   -> move to bottom split
* Ctrl+w k   -> move to top split
* Ctrl+w l   -> move to right split
* Ctrl+w c   -> close split

FILE EXPLORER (GENERIC)
* :Ex
* :Explore


CUSTOM KEYBINDS FROM init.lua
* Ctrl+n     -> toggle file explorer (NvimTree)
* Ctrl+h     -> move to split left
* Ctrl+j     -> move to split down
* Ctrl+k     -> move to split up
* Ctrl+l     -> move to split right
* Ctrl+s     -> save file
* Ctrl+q     -> quit file
* Ctrl+p     -> file search (Telescope if installed)


NVIMTREE FILE EXPLORER KEYS
* Enter      -> open file
* a          -> create file/folder
* d          -> delete
* r          -> rename
* c          -> copy
* x          -> cut
* p          -> paste
* R          -> refresh


THEMES
* :colorscheme gruvbox
* :colorscheme dracula
* :colorscheme nord
* :colorscheme catppuccin
* :colorscheme tokyonight


PLUGINS
* :PackerSync    -> install/update plugins
* :NvimTreeToggle -> toggle file explorer










