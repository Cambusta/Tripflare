param (
    [ValidateSet('Prebuild', 'Full')]
    $BuildMode = 'Full'
)

$ErrorActionPreference = "Stop"

$SourceDirectoryPath = "..\source\*"
$TempDirectoryPath = "..\temp"
$BuildDirectoryPath = "..\build"
$VersionFile = "..\version.txt"
$IncludeFile = ".\include.txt"
$AddonFolderName = "dnct_tripflare"

$AddonBuilder=${env:AddonBuilder}
$PrivateBikeyFile=${env:PrivateBikey}

function Run()
{
    RunPrebuild

    if ($BuildMode -eq 'Full')
    {
        if ([string]::IsNullOrWhiteSpace($AddonBuilder) -Or [string]::IsNullOrWhiteSpace($PrivateBikeyFile))
        {
            Write-Host "Build error: paths to AddonBuilder or signature private key are not set." -BackgroundColor Red
            Write-Host "Please set them by editing respective variables in build.ps1" -BackgroundColor Red
            exit
        }

        RunBuild
        RunPostBuild

        $decision = $Host.UI.PromptForChoice($null, 'Publish nightly?', @('&Yes', '&No'), 1)
        if ($decision -eq 0) {
            PublishNightly
        }

        Write-Host "Done." -ForegroundColor Green
    }
}

function RunPrebuild()
{
    Write-Host "Runnning pre-build..."
    $version = Get-Content $VersionFile -Raw
    Write-Host "Got version $version"

    EnsureDirectories
    CopySourceToTempFolder

    SetVersion -FilesRoot $TempDirectoryPath -Version $version

    Write-Host "Pre-build completed. Prepared files are at: $(Resolve-Path $TempDirectoryPath)"
}

function RunBuild()
{
    Write-Host "Runnning build..."

    BuildAddon -Source $TempDirectoryPath -Output $BuildDirectoryPath

    Write-Host "Build completed."
}

function RunPostBuild()
{
    Write-Host "Running post-build...";

    $addonRoot = Join-Path $BuildDirectoryPath "@$AddonFolderName"

    Write-Host "Copying mod.cpp"
    $modCppPath = Join-Path $TempDirectoryPath "mod.cpp"
    Copy-Item -Path $modCppPath $addonRoot

    Write-Host "Copying public key"
    $signatureFilePath = Get-Item $PrivateBikeyFile
    $signatureFileName = $signatureFilePath.BaseName
    $signatureDirectory = $signatureFilePath.Directory

    $publicKey = Get-ChildItem $signatureDirectory -Filter "$signatureFileName.bikey"

    if ($publicKey)
    {
        $keysDirectory = "$addonRoot\keys"
        New-Item $keysDirectory -ItemType Directory | Out-Null
        Copy-Item $publicKey.FullName $keysDirectory
    }
    else 
    {
        Write-Warning "Unable to find the public key"
    }

    RemoveTempDirectory

    Write-Host "Post-build completed. Addon at: $(Resolve-Path $addonRoot)"
}

function PublishNightly()
{
    . .\publish_nightly.ps1
}

function BuildAddon()
{
    $sourceDir = Resolve-Path $(Join-Path $TempDirectoryPath $AddonFolderName)
    $desinationDir = Join-Path $(Resolve-Path $BuildDirectoryPath) "@$AddonFolderName\addons\"
    $arguments = @($sourceDir, $desinationDir, "-clear", "-sign=$PrivateBikeyFile", "-include=$IncludeFile")

    Write-Host "Running AddonBuilder..."

    Start-Process -NoNewWindow -FilePath $AddonBuilder -ArgumentList $arguments -Wait
}

function EnsureDirectories {

    if (Test-Path $TempDirectoryPath)
    {
        Write-Host "Clearing temp folder"
        Remove-Item -Path "$TempDirectoryPath\*" -Recurse -Force
    }
    else 
    {
        Write-Host "Creating temp folder"
        New-Item $TempDirectoryPath -ItemType Directory | Out-Null
    }

    if (Test-Path $BuildDirectoryPath)
    {
        Write-Host "Clearing build folder"
        Remove-Item -Path "$BuildDirectoryPath\*" -Recurse -Force
    }
    else 
    {
        Write-Host "Creating build folder"
        New-Item $BuildDirectoryPath -ItemType Directory | Out-Null
    }
}

function CopySourceToTempFolder {

    Write-Host "Copying source"
    Copy-Item -Path $SourceDirectoryPath -Destination $TempDirectoryPath -Recurse -Exclude "*.txt", "*.ps1" | Out-Null
}

function SetVersion {
    param(
        [Parameter(Mandatory=$true)]
        $FilesRoot,

        [Parameter(Mandatory=$true)]
        $Version
    )

    $fileList = Get-ChildItem -Path $FilesRoot -Recurse -File -Exclude "*.paa", "*.ps1", ".txt"

    Write-Host "Replacing version placeholders"

    foreach($file in $fileList)
    {
        ReplaceVersionPlaceholder -FileName $file.FullName -Version $Version
    }
}

function ReplaceVersionPlaceholder()
{
    param(
        [Parameter(Mandatory=$true)]
        $FileName,

        [Parameter(Mandatory=$true)]
        $Version
    )

    $content = Get-Content -Path $FileName -Raw
    $content = $content -replace "%VERSION%", $Version
    Set-Content $FileName $content

    if ($LogLevel -eq "debug")
    {
        Write-Host "Set version in $FileName"
    }
}

function RemoveTempDirectory()
{
    Write-Host "Removing temp directory"
    Remove-Item $TempDirectoryPath -Recurse -Force
}

try {
    Run
}
catch {
    Write-Host "An error occured: $_" -BackgroundColor Red -ForegroundColor Yellow
}
