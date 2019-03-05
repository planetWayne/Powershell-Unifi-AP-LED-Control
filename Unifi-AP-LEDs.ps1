param($State="on")

$BaseURI = "HTTPS://192.168.250.11:8443"

$UnifiUsername = "ubnt"
$UnifiPassword = "midtype1;"
$UnifiSite = "default"



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


write-host "Loggin In"

$result = Invoke-WebRequest -uri "$($BaseURI)/api/login" -SessionVariable 'Session' -Body $($cred|convertto-json) -Method 'POST'

write-host "Setting LED State $State"

$Body=@{}
$Body.led_enabled = $(if($state -eq "on") {"true"} Else {"false"})

$result = Invoke-WebRequest -uri "$($BaseURI)/api/s/$($UnifiSite)/set/setting/mgmt"  -WebSession $Session -Body $($Body|convertto-json) -Method 'POST'