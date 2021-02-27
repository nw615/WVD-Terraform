##Connect to azure with admin account
Connect-AzAccount

##If there are mulitple Subscriptions use this to select the correct subscriptions
Get-AzSubscription | Out-GridView -PassThru | Select-AzSubscription

## Create Service Principal
$sp = New-AzADServicePrincipal -DisplayName "PackerSP$(Get-Random)"
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sp.Secret)
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)


## Output password and application id
$plainPassword
$sp.ApplicationId