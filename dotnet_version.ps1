$Servers = 
(
	Get-Content -Path "c:\zxc\srv.txt"
)

foreach ($Server in $Servers)
{

	#Write-Host $Server
	Invoke-Command -ComputerName $Server -ScriptBlock {
	Write-Output "--$(hostname)--"
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version,Release -EA 0 | `
     Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} `
    | Select-Object PSChildName, Version, Release | Select-Object -ExpandProperty Version | Sort-Object Version
	Write-Output "`n";

	}

}
