# Catspi_PPP_Installer
Repository of Catspi PPP Installer Tool 

## Standalone Installation

All source files are downloded from internet in this method. It is enough to download **ppp_install_standalone.sh** and run it.

```
wget https://raw.githubusercontent.com/QWaveSystems/Catspi_PPP_Installer/master/ppp_catspi_install.sh
sudo chmod +x ppp_catspi_install.sh
sudo ./ppp_catspi_install.sh
```

## After running installation script

Then it installs ppp. 

`What is your carrier APN?`

Here, it asks for your carrier's APN. For True-H it is `internet`. Because I use True-H SIM. Please search it on documentations of your SIM provider . You can reach the information by using `WHAT IS [YOUR PROVIDER NAME]'s APN` keywords probably.

`Does your carrier need username and password? [Y/n]`
n for True-H

Then it asks if your carrier needs username and password. 

`Enter username`
If yes then it will ask for user name.

`Enter password`
Then it will ask for password.

`What is your device communication PORT? (ttyS0/ttyUSB3/etc.`

In this step you will enter your PORT. e.g For Catspi it will be ttyUSB3.

`Do you want to activate auto connect/reconnect service at R.Pi boot up?`

This option allows you to connect to Internet via your shield automatically when your Raspberry Pi Starts. If you want to connect to Internet automatically type Y else n. If you have selected n then you will need to run `sudo pon` to connect to internet and `sudo poff` to stop it. 

Enjoy your Internet connection.

Important Links: 
* [Linux PPP HOW TO](https://tldp.org/HOWTO/PPP-HOWTO/index.html)
* [PAP CHAP authentications](https://tldp.org/HOWTO/PPP-HOWTO/pap.html)
