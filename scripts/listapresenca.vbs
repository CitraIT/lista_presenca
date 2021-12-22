'------------------------------------------------------------------------------
' CITRA IT - EXCELÊNCIA EM TI
' Script para notificar a lista de presenca do usuário conectado no computador
' author: luciano@citrait.com.br
' Data: 18/12/2021
'------------------------------------------------------------------------------

On Error Resume Next


' Retrieving Computername and Username
Set objNetwork = CreateObject("WSCript.Network")
Computername = objNetwork.Computername
Username     = objNetwork.Username


' Retrieving IPAddresses
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

' Sending data to web server
Set Http = CreateObject("WinHttp.WinHttpRequest.5.1")
Http.Open "POST", "http://172.16.90.10:9090/ListaPresenca/register"
Http.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
Http.Send "ComputerName="&Computername&"&ComputerIP="&IPAddresses&"&ConnectedUser="&Username





