Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe ".NET" {
    It ".NET" {
        "dotnet --version" | Should -ReturnZeroExitCode
    }
}

Describe "GCC" {
    $testCases = Get-ToolsetValue -KeyPath gcc.versions | ForEach-Object { @{Version = $_} }

    It "GCC <Version>" -TestCases $testCases {
        param (
            [string] $Version
        )

        "gcc-$Version --version" | Should -ReturnZeroExitCode
    }

    It "Gfortran <Version>" -TestCases $testCases {
        param (
            [string] $Version
        )

        "gfortran-$Version --version" | Should -ReturnZeroExitCode
    }

    It "Gfortran is not found in the default path" {
        "$(which gfortran)" | Should -BeNullOrEmpty
    }
}

Describe "vcpkg" {
    It "vcpkg" {
        "vcpkg version" | Should -ReturnZeroExitCode
    }
}

Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }
    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }

    It "AWS Session Manager CLI" {
        "session-manager-plugin --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "AzCopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}

Describe "Miniconda" -Skip:($os.IsMonterey) {
    It "Conda" {
        Get-EnvironmentVariable "CONDA" | Should -Not -BeNullOrEmpty
        $condaBinPath = Join-Path $env:CONDA "bin" "conda"
        "$condaBinPath --version" | Should -ReturnZeroExitCode
    }
}

Describe "Stack" {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "CocoaPods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "VSMac" {
    It "VS4Mac is installed" {
        $vsPath = "/Applications/Visual Studio.app"
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }

    It "VS4Mac Preview is installed" -Skip:(-not $os.IsMonterey) {
        $vsPath = "/Applications/Visual Studio Preview.app"
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }
}

Describe "Swig" {
    It "Swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "Go" {
    It "Go" {
        "go version" | Should -ReturnZeroExitCode
    }
}

Describe "GraalVM" {
    It "graalvm" {
        '$GRAALVM_11_ROOT/java -version' | Should -ReturnZeroExitCode
    }

    It "native-image" {
        '$GRAALVM_11_ROOT/native-image --version' | Should -ReturnZeroExitCode
    }
}