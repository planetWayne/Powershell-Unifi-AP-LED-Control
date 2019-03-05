<#
.SYNOPSIS

Queries state of LED status from a Unifi Controller.

.Description

Simply call script with either 'on' or 'off' to change the state of the Unifi AP ring LED's on the access points.
If no paramter is given, it returns the current state of the controller.
To use, you can either specify each parameter on the command line or set defaults within the script.
Change the BaseURI, UnifiUsername, UnifiPassword and UnifiSite's to match your installation.

.PARAMETER State

'On' or 'Off' - to change the state of the LEDs, if left blank, will return the currently set state.

.PARAMETER BaseURI

Specify the URI for your controller, eg HTTPS://192.168.1.10:8443

.PARAMETER UnifiUsername

Manager username for your controller.

.PARAMETER UnifiPassword

Password for your specified username.

.PARAMETER UnifiSite

Name of the site you want to change.
Please note that it is possible to rename the default site witout it having to change the name used in the API call.

.NOTE

It would appear that if you rename the 'default' site, it will still carry the 'default' name when called via the API.

#>



###############################################################################################################################
# Simply call script with either 'on' or 'off' to change the state of the Unifi AP ring LED's on the access points.
# If no paramter is given, the output would reflect the current state that the controller is set to.
#
# To use
# Change the BaseURI, UnifiUsername, UnifiPassword and UnifiSite's to match your installation.
# Note, it would appear that if you rename the 'default' site, it will still carry the 'default' name when called via the API.
#






param([string]$State="",
    [string]$BaseURI = "HTTPS://192.168.250.11:8443",
    [string]$UnifiUsername = "ubnt",
    [string]$UnifiPassword = "midtype1;",
    [string]$UnifiSite = "default"
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
$cred.username=$UnifiUsername
$cred.password=$UnifiPassword


write-host "Logging In"

$result = Invoke-WebRequest -uri "$($BaseURI)/api/login" -SessionVariable 'Session' -Body $($cred|convertto-json) -Method 'POST'


$Body=@{}

if ("on","off" -contains $state)
{
    write-host "Setting LED State $State"
    $Body.led_enabled = $(if($state -eq "on") {"true"} else {"false"})
}

$result = Invoke-WebRequest -uri "$($BaseURI)/api/s/$($UnifiSite)/set/setting/mgmt"  -WebSession $Session -Body $($Body|convertto-json) -Method 'POST'
$LED_Status = if( (convertfrom-json $result.content).data.led_enabled -eq "true") {"On"} else {"Off"} 

write-host "System reports status as '$LED_Status'"
