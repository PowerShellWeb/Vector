$commandsPath = Join-Path $PSScriptRoot Commands
:ToIncludeFiles foreach ($file in (Get-ChildItem -Path "$commandsPath" -Filter "*-*" -Recurse)) {
    if ($file.Extension -ne '.ps1')      { continue }  # Skip if the extension is not .ps1
    foreach ($exclusion in '\.[^\.]+\.ps1$') {
        if (-not $exclusion) { continue }
        if ($file.Name -match $exclusion) {
            continue ToIncludeFiles  # Skip excluded files
        }
    }     
    . $file.FullName
}

$myModule = $MyInvocation.MyCommand.ScriptBlock.Module
$ExecutionContext.SessionState.PSVariable.Set($myModule.Name, $myModule)
$myModule.pstypenames.insert(0, $myModule.Name)

New-PSDrive -Name $MyModule.Name -PSProvider FileSystem -Scope Global -Root $PSScriptRoot -ErrorAction Ignore

if ($home) {
    $MyModuleProfileDirectory = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $MyModule.Name
    if (-not (Test-Path $MyModuleProfileDirectory)) {
        $null = New-Item -ItemType Directory -Path $MyModuleProfileDirectory -Force
    }
    New-PSDrive -Name "My$($MyModule.Name)" -PSProvider FileSystem -Scope Global -Root $MyModuleProfileDirectory -ErrorAction Ignore
}

# Set a script variable of this, set to the module
# (so all scripts in this scope default to the correct `$this`)
$script:this = $myModule

#region Custom

foreach ($type in [Numerics.Vector2], [Numerics.Vector3],[Numerics.Vector4]) {
    $staticMembers = $type | Get-Member -Static
    $typeData = [Management.Automation.Runspaces.TypeData]::new($type.FullName)
    foreach ($staticMember in $staticMembers) {
        if ($staticMember.MemberType -eq 'Method' -and 
            $staticMember.Definition -match "\($([Regex]::Escape($type.FullName))\s\w+\)"
        ) {
            $typeData.Members.Add(
                $staticMember.Name,
                [Management.Automation.Runspaces.ScriptMethodData]::new(
                    $staticMember.Name,
                    [ScriptBlock]::Create("
`$invokeArgs = @(`$this) + `$args
[$($type.FullName -replace '^System\.')]::$($staticMember.Name).Invoke(`$invokeArgs)
")
                )                
            )
        }
        if ($staticMember.MemberType -eq 'Property' -and 
            $staticMember.Definition -match "^$([Regex]::Escape($type.FullName))\s") {
            <#$typeData.Members.Add(
                $staticMember.Name,
                [Management.Automation.Runspaces.ScriptPropertyData]::new(
                    $staticMember.Name,
                    [ScriptBlock]::Create("[$($type.FullName -replace '^System\.')]::$($staticMember.Name)")
                )                
            )#>
        }

    }
    Update-TypeData -TypeData $typeData -Force
}

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = { 
    Remove-TypeData -ErrorAction Ignore -TypeName 'System.Numerics.Vector2'
    Remove-TypeData -ErrorAction Ignore -TypeName 'System.Numerics.Vector3'
    Remove-TypeData -ErrorAction Ignore -TypeName 'System.Numerics.Vector4'
}
#endregion Custom

Export-ModuleMember -Alias * -Function * -Variable $myModule.Name


