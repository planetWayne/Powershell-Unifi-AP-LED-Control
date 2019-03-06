# ![Unifi Logo][MyUnifiLogo] Powershell - Unifi-AP-LED-Control

### Note - This is a personally created script NOT created by Ubiquiti but posted here for reference, free to use.

This little script is for PowerShell to allow you to control the LED status lights on the Ubiquiti Unifi Wireless Access points via either a [Ubiquiti CloudKey](https://www.ui.com/unifi/unifi-cloud-key/) or other [Unifi Controller](https://www.ui.com/software/).

Use is straight forward enough, you can either edit the script to set defaults for things like the BaseURI of the controller, Username, Password and Unifi Site or pass each parameter as a command line option. If no 'state' is passed then it will return what the current LED state is or specifying 'on' to turn on or 'off' to turn it off again.

Examples are given in the powershell script, call with `Unifi-AP-LED-Control.ps1 -?` to get help or `get-help Unifi-AP-LED-Control.ps1 -examples` to see some examples.


The actual complexities of this script was more the writing of the inbuilt documentation to work with powershell itself rather than the 'working' bits. TBH there are only two working lines that actually inquire on the controller to a) log in and get a session and b) either enquire on the state or change the state of the LED_STATUS setting.

## Changing Script Defaults
Have a look just after the top comment block <#...#> for the section

```PowerShell
# Change your defaults here!!

param([string]$State="",
    [string]$BaseURI  = "HTTPS://192.168.1.50:8443",
    [string]$Username = "ubnt",
    [string]$Password = "password",
    [string]$Site     = "default"
)
```

Just change the text within the "" to your new default values. #note# if you change the default for 'state' then you will never actually get the state back as not specifying it will either turn it on or off respectively.

As taken from the scripts examples

```
-------------------------- EXAMPLE 1 --------------------------

PS C:\>.\Unifi-AP-LEDs.ps1   {no parameters}

Will return the currently set state from the default controllers LED_STATE setting, as coded in the script.

```


```
-------------------------- EXAMPLE 2 --------------------------

PS C:\>.\Unifi-AP-LEDs.ps1 on

Changes the LED_STATUS on the default unifi controller to ON - thus turning on the AP's status LED

```

```
-------------------------- EXAMPLE 3 --------------------------

PS C:\>.\Unifi-AP-LEDs.ps1 on -BaseURI https:\\192.168.1.10:8443 -Username admin -Password mysecret -Site site3

Requests the state of the controller specified with the BaseURI username and passwords that are not defaulted in the script.

```



[MyUnifiLogo]: images/UBNTLogo.png