$dataset = Import-Csv C:\tmp\IPAddresses.csv
foreach ($data in $dataset){
    $User = $data.name
    $IP = $data.ip
    $IPInfo = Invoke-RestMethod -uri "ipinfo.io/$IP/?token=xxxxxxxxxxxxxx"

    $userInfo = @{
        'name' = $User
        'ip' = $IP
        'city' = $IPInfo.city
        'region' = $IPInfo.region
        'country' = $IPInfo.country
        'org' = $IPInfo.org
        'hostname' = $IPInfo.hostname 
    }

    $userInfo| export-csv C:\tmp\IPAddressInfo.csv -Append
