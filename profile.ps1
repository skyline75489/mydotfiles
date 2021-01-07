function prompt {
    $p = $($executionContext.SessionState.Path.CurrentLocation)
    $converted_path = Convert-Path $p
    $ansi_escape = [char]27
    Write-Host $env:USERNAME -ForegroundColor Green -NoNewline
    Write-Host "@" -ForegroundColor White -NoNewLine
    Write-Host $env:COMPUTERNAME -ForegroundColor Blue -NoNewLine
    Write-Host " " -NoNewLine
    Write-Host $p -NoNewLine
    "PS $('>' * ($nestedPromptLevel + 1)) ";
    Write-Host "$ansi_escape]9;9;$converted_path$ansi_escape\"
}
