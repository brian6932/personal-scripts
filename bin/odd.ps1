$ErrorActionPreference = 'Stop'
$input | & (Get-Command -CommandType Application curl)[0].Name -SsT $(if ($args[0]) { $args[0] } else { '-' }) https://0dd.sh/
