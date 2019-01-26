# Fill in custom build functions.
[cmdletbinding()]
param (
    [Parameter(Mandatory=$false)]
    [String]
    $SourceFolder = $Env:BUILD_SOURCESDIRECTORY,
    [Parameter(Mandatory=$false)]
    [String]
    $ModuleName=$ENV:ModuleName
    )

write-host "Where are we ? : Here $($SourceFolder)"

write-host "The reason for starting this building $($Env:Build_Reason)"

write-host "Commit message is $($Env:Build_SourceVersionMessage)"

write-host "Hi, I am your build agent. I will build the module $($ModuleName)"

write-host "More info of this task can be found here $($Env:Build_BuildUri)"

if ($modulename.Length -lt 1) {

    Exit-PSHostProcess
}

$BuildFolder = join-path -path $SourceFolder  -childpath "Build"

$BuildModulePath =  join-path -path $BuildFolder -ChildPath $ModuleName


$SourceFolder = join-path -path $SourceFolder  -childpath "$($ModuleName)"

write-host "Build path $($BuildFolder) and module path $($BuildModulePath)"

write-host "Source Folder $($SourceFolder)"


if (Test-Path $BuildFolder) {
    Remove-Item -Path $BuildFolder -Force -Recurse -Confirm:$false
}

new-item -Path $BuildFolder -ItemType Directory

new-item -Path $BuildModulePath -ItemType Directory



# Creating Modle path
$BuildModuleFile = Join-Path -Path $BuildModulePath -ChildPath "$($ModuleName).psm1"
$BuildModuleManifest = Join-Path -Path $BuildModulePath -ChildPath "$($ModuleName).psd1"
$SourceMouduleManifest = Join-Path -Path $SourceFolder -ChildPath "$($ModuleName).psd1"


Copy-Item -Path $SourceMouduleManifest -Destination $BuildModuleManifest -Force



$PublicFunctionsList = Get-ChildItem -Path "$($ModuleName)\Public" -Filter *.ps1

$AllFunctions = Get-ChildItem -Path $SourceFolder -Include 'Public', 'External' -Recurse -Directory | Get-ChildItem -Include *.ps1 -File

new-item -Path $BuildModuleFile -ItemType File

if ($AllFunctions) {
    Foreach ($Function in $AllFunctions) {
        Get-Content -Path $AllFunctions.FullName | Add-Content -Path $BuildModuleFile
    }
}

write-host "Updating Module Manifest with $($PublicFunctionsList.BaseName)"
Update-ModuleManifest -Path $BuildModuleManifest -FunctionsToExport $PublicFunctionsList.BaseName


install-module -name pester -force -AllowClobber -Scope CurrentUser
