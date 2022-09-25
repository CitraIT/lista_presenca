'------------------------------------------------------------------------------
' CITRA IT - EXCELENCIA EM TI
' Script para notificar a lista de presenca do usuario conectado no computador
' author: luciano@citrait.com.br
' Data: 18/12/2021
'------------------------------------------------------------------------------
On Error Resume Next




'------------------------------------------------------------------------------
' Retrieving Computername and Username
'------------------------------------------------------------------------------
Set objNetwork = CreateObject("WSCript.Network")
Computername = objNetwork.Computername
Username     = objNetwork.Username


'------------------------------------------------------------------------------
' Retrieving IPAddresses
'------------------------------------------------------------------------------
IPAddresses = ""
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
Set colNetworkConfig = objWMI.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE")
For Each NetworkConfig In colNetworkConfig
    'WScript.Echo NetworkConfig.IPAddress.Get(0)
    For Each IPAddress In NetworkConfig.IPAddress
        If InStr(IPAddress, "192.") <> 0 OR InStr(IPAddress, "172.") <> 0 OR InStr(IPAddress, "10.") <> 0 Then
            IPAddresses = IPAddress
        End If
    Next
Next



'------------------------------------------------------------------------------
' Retrieve Anydesk Connection ID
'------------------------------------------------------------------------------
ANYDESK_PATH = ""
AnydeskID = ""
Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")

' Searching anydesk on possible paths
If objFSO.FileExists("C:\\Program Files (x86)\\AnyDesk\\AnyDesk.exe") Then
  ANYDESK_PATH = "C:\\Program Files (x86)\\AnyDesk\\AnyDesk.exe"
ElseIf objFSO.FileExists("C:\\Program Files\\AnyDesk\\AnyDesk.exe") Then
  ANYDESK_PATH = "C:\\Program Files\\AnyDesk\\AnyDesk.exe"
End If

If ANYDESK_PATH <> "" Then
    ' Obtendo o ID do anydesk
    Set wshShell = WScript.CreateObject("WScript.Shell")
    Set oExec = wshShell.Exec(chr(34) & ANYDESK_PATH & chr(34) & " --get-id")
    Do While oExec.Status = 0
        WScript.Sleep 100
    Loop
    AnydeskID = oExec.Stdout.ReadLine()
End If



' Sending data to web server
Set Http = CreateObject("WinHttp.WinHttpRequest.5.1")
Http.Open "POST", "http://172.16.90.10:9090/ListaPresenca/register"
Http.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
Http.Send "ComputerName="&Computername&"&ComputerIP="&IPAddresses&"&ConnectedUser="&Username&"&AnydeskID="&AnydeskID





