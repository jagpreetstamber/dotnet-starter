$ErrorActionPreference = "Stop"

Remove-Item "$PSScriptRoot\TestResults" -Recurse -Force -ErrorAction SilentlyContinue

if (Test-Path -Path "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe") {
    $visualStudioPath = & "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -property installationPath 

    if ($visualStudioPath) {
        & "$visualStudioPath\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
        dotnet restore /t:slngen .\dirs.proj
    }
}

dotnet restore dirs.proj
if ($LASTEXITCODE -ne 0) {
    Write-Error "dotnet restore failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

dotnet build dirs.proj --no-restore
if ($LASTEXITCODE -ne 0) {
    Write-Error "dotnet build failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

dotnet test dirs.proj --no-build --no-restore --logger "console" --blame --collect "XPlat Code coverage" --results-directory "$PSScriptRoot\TestResults\"
if ($LASTEXITCODE -ne 0) {
    Write-Error "dotnet test failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

dotnet publish dirs.proj --no-build --no-restore 
if ($LASTEXITCODE -ne 0) {
    Write-Error "dotnet publish failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

if (-not (Test-Path -Path "$PSScriptRoot\tools\reportgenerator.exe")) {
    dotnet tool install dotnet-reportgenerator-globaltool --tool-path tools --ignore-failed-sources
    if ($LASTEXITCODE -ne 0) {
        Write-Error "dotnet publish failed with exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }
}

.\tools\reportgenerator.exe "-reports:$PSScriptRoot\TestResults\*\coverage.cobertura.xml" "-targetdir:$PSScriptRoot\TestResults\coverage" "-reporttypes:HtmlInline_AzurePipelines;Cobertura"