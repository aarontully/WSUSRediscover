REM Batch file will stop the update services, delete the regkeys that WSUS created
REM Delete any corrupted download software, restart the services and use a powershell command to 
REM enable WSUS server to rediscover that client 

net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f
rd /s /q "%SystemRoot%\SoftwareDistribution"
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
wuauclt /resetauthorization /detectnow
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()