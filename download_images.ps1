# Download script for images
Set-Location "S:\Фигурки_3d\Site"

$response = Invoke-WebRequest -Uri "https://iodnt.ru/virtualnye-vystavki/4012-virtualnaya-vystavka-korennye-narody-sibiri-2" -UseBasicParsing
$html = $response.Content

# Extract original image URLs
$originalMatches = [regex]::Matches($html, 'href="/images/virtualvistavki/[^"]+\.jpg"')
$originalUrls = @()
foreach ($match in $originalMatches) {
    $url = $match.Value -replace 'href="', '' -replace '"', ''
    $originalUrls += $url
}

# Extract thumbnail URLs
$thumbMatches = [regex]::Matches($html, 'data-thumb="/cache/jw_sigpro/jwsigpro_cache_[^"]+\.jpg"')
$thumbUrls = @()
foreach ($match in $thumbMatches) {
    $url = $match.Value -replace 'data-thumb="', '' -replace '"', ''
    $thumbUrls += $url
}

Write-Host "Found $($originalUrls.Count) original images"
Write-Host "Found $($thumbUrls.Count) thumbnail images"

$i = 1
foreach ($url in $originalUrls) {
    $fullUrl = "https://iodnt.ru" + $url
    $filename = Split-Path $url -Leaf
    $outputPath = "images_originals\$filename"
    Write-Host "Downloading original $i/$($originalUrls.Count): $filename"
    Invoke-WebRequest -Uri $fullUrl -OutFile $outputPath -UseBasicParsing
    $i++
}

$i = 1
foreach ($url in $thumbUrls) {
    $fullUrl = "https://iodnt.ru" + $url
    $filename = Split-Path $url -Leaf
    $outputPath = "thumbnails\$filename"
    Write-Host "Downloading thumbnail $i/$($thumbUrls.Count): $filename"
    Invoke-WebRequest -Uri $fullUrl -OutFile $outputPath -UseBasicParsing
    $i++
}

Write-Host "Download complete!"
