# ![Unifi Logo][UnifiLogo] Powershell-Unifi-AP-LED-Control


This little script is for PowerShell to allow you to control the LED status lights on the Ubiquiti Unifi Wireless Access points via either a [Ubiquiti CloudKey](https://www.ui.com/unifi/unifi-cloud-key/) or other [Unifi Controller](https://www.ui.com/software/).

Use is streight forward enough, you can either edit the script to set defaults for things like the BaseURI of the controller, Username, Password and Unifi Site or pass each parameter as a commad line option. If no 'state' is passed then it will return what the current LED state is or specifying 'on' to turn on or 'off' to turn it off again.

Exaples are given in the powershell script, call with `Unifi-AP-LED-Control.ps1 -?` to get help or `get-help Unifi-AP-LED-Control.ps1 -examples` to see some examples.

[UnifiLogo]: http://www.ui.com/media/images/ubnt-logo-u.svg