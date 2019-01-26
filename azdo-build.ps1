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

write-host "Creating build folder in $($SourceFolder)\build\$($ModuleName)"

$BuildFolder = join-path -path $SourceFolder  -childpath "\Build\$($ModuleName)"

write-host "Build path $($BuildFolder)"
