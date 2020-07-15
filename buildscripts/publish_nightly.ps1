$ErrorActionPreference = "Stop"

$PublisherRoot = "D:\SteamLibrary\steamapps\common\Arma 3 Tools\Publisher";
$Publisher = Get-ChildItem -Path $PublisherRoot -Filter "PublisherCmd.exe"

$itemId = Get-Content ".\nightly_id.txt" -Raw
$version = (Get-Content "..\version.txt" -Raw) -replace '\s',''
$changeNote = "AutomatedNightly_Version$version"
$addonPath = Resolve-Path "..\build\@dnct_tripflare"

$pboExists = Test-Path "$addonPath\addons\dnct_tripflare.pbo"
$modCppExists = Test-Path "$addonPath\mod.cpp"

if (-Not $itemId)
{
    Write-Host "Failed to obtain Workshop item ID, aborting." -BackgroundColor Red -ForegroundColor Yellow
    exit
}

if ((-Not $pboExists) -Or (-Not $modCppExists))
{
    Write-Host "Addon files missing, aborting." -BackgroundColor Red -ForegroundColor Yellow
    exit
}

Write-Host "Publishing nightly build..."

$arguments = @("update", "/id:$itemId", "/changeNote:$changeNote", "/path:$addonPath", "/nologo")

$process = Start-Process -NoNewWindow -FilePath $Publisher.FullName -ArgumentList $arguments -PassThru -Wait
$code = $process.ExitCode

if ($code -eq 0)
{
    Write-Host "Nightly build published." -ForegroundColor Green
}
else {
    Write-Host "Unknown Publisher failure. Code $code" -BackgroundColor Red -ForegroundColor Yellow
}
