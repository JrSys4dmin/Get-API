$headers = @{}
$headers.Add("accept", "application/json")
$headers.Add("Authorization", "Bearer xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
$companies = "Google.com", "Kraft.com", "Yahoo.com", "LastPass.com"
$Colors = "dark", "light"
foreach ($company in $companies) {
    $response = Invoke-RestMethod -Uri "https://api.brandfetch.io/v2/brands/$company" -Headers $headers -Method Get
    foreach($color in $colors){
    #write-host $response
    $companyName = $company.Replace(".com", "")
    $Logos = $response.logos | Where-Object { $_.theme -eq "$color" } | Select-Object -ExpandProperty formats | Select-Object -ExpandProperty src
    $counter = 0
    foreach ($logo in $logos) {
        if ($logo -like "*png*") {
            $Counter++
            Invoke-WebRequest -uri $logo -OutFile C:\tmp\$CompanyName$color$counter.png
        }
        elseif ($logo -like "*svg*"){
            $Counter++
            Invoke-WebRequest -uri $logo -OutFile C:\tmp\$CompanyName$color$counter.svg
        }
        elseif( $logo -like "jpeg"){
            $Counter++
            Invoke-WebRequest -uri $logo -OutFile C:\tmp\$CompanyName$color$counter.jpeg
        }
    
    }
    $counter = 0
    }
}
