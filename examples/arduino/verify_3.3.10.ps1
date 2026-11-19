param(
    [string]$ArduinoCli = 'arduino-cli',
    [string]$BuildRoot = (Join-Path $PSScriptRoot 'work\build_3.3.10'),
    [string]$ConfigFile,
    [string[]]$BuildProperty = @()
)

$ErrorActionPreference = 'Stop'
$commonArgs = @()
if ($ConfigFile) {
    $commonArgs += @('--config-file', $ConfigFile)
}
$coreText = & $ArduinoCli core list @commonArgs --format json
if ($LASTEXITCODE -ne 0) { throw 'Cannot read installed Arduino cores.' }
$coreData = ($coreText -join "`n") | ConvertFrom-Json
$core = @($coreData.platforms | Where-Object { $_.id -eq 'esp32:esp32' })
if ($core.Count -ne 1 -or $core[0].installed_version -ne '3.3.10') {
    throw 'Install esp32:esp32@3.3.10 before running this script.'
}

$fqbn = 'esp32:esp32:esp32c6:CDCOnBoot=cdc,FlashSize=4M,PartitionScheme=default'
New-Item -ItemType Directory -Path $BuildRoot -Force | Out-Null
$results = @()
foreach ($sketch in (Get-ChildItem -LiteralPath (Join-Path $PSScriptRoot 'examples') -Directory | Sort-Object Name)) {
    $cliArgs = @('compile') + $commonArgs + @(
        '--fqbn', $fqbn,
        '--libraries', (Join-Path $PSScriptRoot 'libraries'),
        '--build-path', (Join-Path $BuildRoot $sketch.Name),
        '--jobs', '4', '--warnings', 'default'
    )
    foreach ($property in $BuildProperty) { $cliArgs += @('--build-property', $property) }
    $cliArgs += $sketch.FullName
    Write-Host "Building $($sketch.Name) with Arduino-ESP32 3.3.10..."
    $ErrorActionPreference = 'Continue'
    $log = & $ArduinoCli @cliArgs 2>&1
    $buildExitCode = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    $log | Out-File -LiteralPath (Join-Path $BuildRoot "$($sketch.Name).log") -Encoding utf8
    $log | ForEach-Object { Write-Host $_ }
    $results += [pscustomobject]@{ Example = $sketch.Name; ExitCode = $buildExitCode; Passed = ($buildExitCode -eq 0) }
}
$results | ConvertTo-Json | Out-File -LiteralPath (Join-Path $BuildRoot 'results.json') -Encoding utf8
$results | Format-Table -AutoSize
if (@($results | Where-Object { -not $_.Passed }).Count -gt 0) { exit 1 }
