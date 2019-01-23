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

write-host "Hi, I am your build agent. I run on $($Env:Agent.OS)"

Write-host "I am starting the jon nammed $($Env:Agent.JobName) just for you"

write-host "This is a Build Task, but nothing is done"
