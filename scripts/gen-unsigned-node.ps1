Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

$nodeVersion = $args[0]
$arch = $args[1]
$url = "https://nodejs.org/dist/$nodeVersion/win-$arch/node.exe"

echo "Downloading node.js $nodeVersion for win/$arch from $url"

$distFolder = "C:\node"
$nodeBinName = "node-${nodeVersion}-win-${arch}.exe"
$nodeBinPath = "$distFolder\${nodeBinName}"

md "$distFolder" -ea 0

Invoke-WebRequest -Uri $url -OutFile $nodeBinPath

docker run --rm -v "${distFolder}:C:\mounted" cmaster11/windows-signtool:latest remove /s "C:\mounted\$nodeBinName"

echo "Done"