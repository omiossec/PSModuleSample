param (
    $BuildModulePath=$Env:BUILD_SOURCESDIRECTORY,
    $ModuleName = $ENV:ModuleName
)

$BuildFolder = $BuildModulePath + "\build\$($ModuleName)"
$ModuleManifestName = "$($ModuleName).psd1"
$ModuleManifestPath = "$($BuildFolder)\$ModuleManifestName"

Get-Module -Name $ModuleName | remove-module

$ModuleInformation = Import-module -Name $ModuleManifestPath -PassThru

Describe "$ModuleName Module - Testing Manifest File (.psd1)"{

    Context "$ModuleName Module Configuration" {

        It "Should contains RootModule" {
            $ModuleInformation.RootModule | Should not BeNullOrEmpty
        }

        It "Should contains a Version" {
            $ModuleInformation.ModuleVersion | Should not BeNullOrEmpty
        }

        It "Should contains Author" {
            $ModuleInformation.Author | Should not BeNullOrEmpty
        }

        It "Should contains Company Name" {
             $ModuleInformation.CompanyName|Should not BeNullOrEmpty
            }

        It "Should contains Description" {
            $ModuleInformation.Description | Should not BeNullOrEmpty
        }

    }

    Context "Testing Internal Functions from $ModuleName" {

        InModuleScope $ModuleName {

            it "Return a datetime result" {


            }



        }



    }

}