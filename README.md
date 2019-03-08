<img align="left" src="images/UBNTLogo.png" style="margin-bottom: 120px">
A simple powershell script to allow control of Ubiquiti Unifi AP's Status LEDs

#### Note - This is a personally created script NOT created by Ubiquiti but posted here for reference, and is free to use.

#### Download Script -> [Unifi-AP-LED-Control.ps1](Unifi-AP-LED-Control.ps1)
![GitHub forks](https://img.shields.io/github/forks/planetWayne/Powershell-Unifi-AP-LED-Control.svg?logo=github&logoColor=1DA1F2&style=flat&colorA=blueviolet&colorB=1DA1F2) ![GitHub repo size in bytes](https://img.shields.io/github/repo-size/planetWayne/Powershell-Unifi-AP-LED-Control.svg?logo=github&style=flat&logoColor=1DA1F2&colorA=blueviolet&colorB=1DA1F2) ![GitHub last commit](https://img.shields.io/github/last-commit/planetWayne/Powershell-Unifi-AP-LED-Control.svg?logo=github2&colorA=blueviolet&colorB=1DA1F2&style=flat)

---------
## Background

This little script is for PowerShell to allow you to control the LED Enabled status on the Ubiquiti Unifi Wireless Access points via either a [Ubiquiti CloudKey](https://www.ui.com/unifi/unifi-cloud-key/) or other [Unifi Controllers](https://www.ui.com/software/). I have seen numerous variations that use CURL or are linux based but nothing that was written in Windows Powershell, hence this.

It was also an exercise in learning [MarkDown](https://daringfireball.net/projects/markdown/) and creating a public GitHub site to hold this and get familiar with the process generally.

Use is straight forward enough, you can either edit the script to set defaults for things like the _BaseURI_ of the controller, _Username_, _Password_ and _Site_ or pass each parameter as a command line option. If no _state_ is passed, it will return the controllers current LED_Enabled state. Specify the state as _on_ to turn on or _off_ to turn it off again, simples.

Examples are given in the powershell script, call with `Unifi-AP-LED-Control.ps1 -?` to get help or `get-help Unifi-AP-LED-Control.ps1 -examples`.


The actual complexities of this script was more the writing of the inbuilt documentation to work with powershell itself rather than the 'working' bits. TBH there are only two working lines that actually inquire on the controller to a) log in and get a session and b) either enquire on the state or change the state of the LED_Enabled setting. The rest is documentation and a little logic to set or get the results.

## Changing Script Defaults
Have a look just after the top comment block `<#...#>` for the section

```PowerShell
# Change your defaults here!!

param([string]$State  = "",
    [string]$BaseURI  = "HTTPS://192.168.1.50:8443",
    [string]$Username = "ubnt",
    [string]$Password = "password",
    [string]$Site     = "default"
)
```

Just change the text within the "" to your new default values. **Note** if you set a default for  '_state_' then you will not be able to enquire as to what the controller has this set to.

### Returning State to a Calling Script
If you would like to return the actual state of LED_Enabled to a calling program, remove the comment from the last line of the script. `# return $LED_Status ` you will then get either an `On` or `Off` to reflect its state on the controller.

### As taken from the scripts examples

```
-------------------------- EXAMPLE 1 --------------------------

PS C:\>.\Unifi-AP-LED-Control.ps1   {no parameters}

Will return the currently set state from the default controllers LED_Enabled setting, as coded in the script.

```


```
-------------------------- EXAMPLE 2 --------------------------

PS C:\>.\Unifi-AP-LED-Control.ps1 on

Changes the LED_Enabled status on the default unifi controller to ON - thus turning on the AP's status LED

```

```
-------------------------- EXAMPLE 3 --------------------------

PS C:\>.\Unifi-AP-LED-Control.ps1 on -BaseURI https:\\192.168.1.10:8443 -Username admin -Password mysecret -Site site3

Requests the state of the controller specified with the BaseURI username and passwords that are not defaulted in the script.

```

Enjoy!

[MyUnifiLogo]: images/UBNTLogo.png