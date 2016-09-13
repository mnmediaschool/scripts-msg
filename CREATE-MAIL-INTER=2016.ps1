Import-Csv -Delimiter ";" -Path C:\Users\mnegre.IEJ-ELEVES\Desktop\SDWNICEINTER2016.csv | ForEach-Object   {  
$Logfile = "c:\Users\mnegre.IEJ-ELEVES\Desktop\Logimport.log"
Function LogWrite
{
Param ([string]$logstring)
Add-Content $Logfile -value $Logstring
}

$Detailedname = $_.Nom + " " + $_.Prénom
$CheckIfUserAccountExists = Get-MsolUser -UserPrincipalName $_.Login -ErrorAction SilentlyContinue
If ($CheckIfUserAccountExists -eq $Null) {$MyAction = New-MsolUser –Department $_.Centre -Title INTERVENANT -FirstName $_.Prénom `
   -DisplayName $Detailedname -LastName $_.Nom `
   -Password Welcome06 -UserPrincipalName $_.Login `
   -LicenseAssignment 'IECM064:STANDARDWOFFPACK_FACULTY' `
   -UsageLocation "FR"}
Else {$MyAction = LogWrite "$Detailedname existe déjà"}
$MyAction
} | LogWrite -Path c:\Users\mnegre.IEJ-ELEVES\Desktop\CreationLog.log
