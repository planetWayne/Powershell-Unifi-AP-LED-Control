# ![Unifi Logo][MyUnifiLogo] Powershell - Unifi-AP-LED-Control

### Note - This is a personally created script NOT created by Ubiquiti but posted here for reference, free to use.

This little script is for PowerShell to allow you to control the LED status lights on the Ubiquiti Unifi Wireless Access points via either a [Ubiquiti CloudKey](https://www.ui.com/unifi/unifi-cloud-key/) or other [Unifi Controller](https://www.ui.com/software/).

Use is straight forward enough, you can either edit the script to set defaults for things like the BaseURI of the controller, Username, Password and Unifi Site or pass each parameter as a command line option. If no 'state' is passed then it will return what the current LED state is or specifying 'on' to turn on or 'off' to turn it off again.

Examples are given in the powershell script, call with `Unifi-AP-LED-Control.ps1 -?` to get help or `get-help Unifi-AP-LED-Control.ps1 -examples` to see some examples.


[MyUnifiLogo]: images/UBNTLogo.png