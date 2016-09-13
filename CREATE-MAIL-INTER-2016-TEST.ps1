function Select-FileDialog

{param([string]$Title,[string]$Directory,[string]$Filter="All Files (*.*)|*.*")
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
$objForm = New-Object System.Windows.Forms.OpenFileDialog
$objForm.ShowHelp = $true
$objForm.InitialDirectory = $Directory
$objForm.Filter = $Filter
$objForm.Title = $Title
$Show = $objForm.ShowDialog()
If ($Show -eq "OK")
{
Return $objForm.FileName
}
Else
{
Write-Error "Operation cancelled by user."
}
}
$inputfile = Select-FileDialog -Title "Select a file" -Directory "c:\temp"
$tempfile = "c:\temp\import-tmp.csv"
Get-Content $inputfile -encoding string |
	Set-Content $tempfile -encoding UTF8
Import-Csv -Delimiter ";" -Path $tempfile