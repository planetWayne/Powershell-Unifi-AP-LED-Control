<#
.SYNOPSIS
Gets / Sets the state of a sites LED_STATUS status from a Unifi Controller.

.Description
Simply call script with either 'on' or 'off' to change the state of the Unifi AP ring LED's on the access points.

If no paramter is given, this will return the current state of the sites LED_STATUS.

To use, you can either specify each parameter on the command line or set defaults within the script.
Change the BaseURI, Username, Password and Site's to match your installation. In doing this, the only thing that needs to be passed is the 'state' if you want to turn it on or off.

NOTE
It would appear that if you rename the 'default' site, it will still carry the 'default' name when called via the API.

.example
.\Unifi-AP-LEDs.ps1   {no parameters}

Will return the currently set state from the default controllers LED_STATE setting, as coded in the script.

.EXAMPLE
.\Unifi-AP-LEDs.ps1 on

Changes the LED_STATUS on the default unifi controller to ON - thus turning on the AP's status LED

.EXAMPLE
.\Unifi-AP-LEDs.ps1 on -BaseURI https:\\192.168.1.10:8443 -Username admin -Password mysecret -Site site3

Requests the state of the controller specified with the BaseURI Username and Passwords that are not defaulted in the script.

.PARAMETER State

'On' or 'Off' - to change the state of the LEDs, if left blank, will return the currently set state.

.PARAMETER BaseURI

Specify the URI for your controller, eg HTTPS://192.168.1.10:8443

.PARAMETER Username

Manager username for your controller.

.PARAMETER Password

Password for your specified username.

.PARAMETER Site

Name of the site you want to change.
Please note that it is possible to rename the default site witout it having to change the name used in the API call.

.LINK
https://www.ui.com/download/unifi/unifi-cloud-key
.LINK
https://www.ui.com/unifi/unifi-cloud-key/
.LINK
https://www.ui.com/software/

#>


# Change yor defaults here!!

param([string]$State="",
    [string]$BaseURI  = "HTTPS://192.168.1.50:8443",
    [string]$Username = "ubnt",
    [string]$Password = "password",
    [string]$Site     = "default"
)



# There be demons below...

# a fudge to get powershell to ignore certificate issues
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy


$cred = @{}
$cred.username=$Username
$cred.password=$Password

write-host "Logging In"

$result = Invoke-WebRequest -uri "$($BaseURI)/api/login" -SessionVariable 'Session' -Body $($cred|convertto-json) -Method 'POST'

$Body=@{}

if ("on","off" -contains $state)
{
    write-host "Setting LED State $State"
    $Body.led_enabled = $(if($state -eq "on") {"true"} else {"false"})
}

$result = Invoke-WebRequest -uri "$($BaseURI)/api/s/$($Site)/set/setting/mgmt"  -WebSession $Session -Body $($Body|convertto-json) -Method 'POST'

$LED_Status = if( (convertfrom-json $result.content).data.led_enabled -eq "true") {"On"} else {"Off"} 

write-host "Controller reports status as '$LED_Status'"
