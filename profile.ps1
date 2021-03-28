if (-Not $IsWindows) {
    $env:USERNAME = $env:USER
    $env:COMPUTERNAME = $(hostname)

    if (Get-Command "exa" -ErrorAction SilentlyContinue)
    {
        function l {
            exa -la
        }

        function ls {
            exa
        }

        function ll {
            exa -l --git
        }

        function la {
            exa -la --git
        }

        function sl {
            exa
        }
    }
    else
    {
        function l {
            ls -lah
        }

        function ll {
            ls -lhG
        }

        function la {
            ls -lAhG
        }
    }
} else {
    if (Get-Command "exa.exe" -ErrorAction SilentlyContinue)
    {
        Remove-Alias ls
        function l {
            exa -la
        }

        function ls {
            exa
        }

        function ll {
            exa -l --git
        }

        function la {
            exa -la --git
        }
    }
    else
    {
        function l {
            ls -Force
        }

        function ll {
            ls
        }

        function la {
            ls -Force
        }
    }
}

function .. {
    cd ..
}

function ... {
    cd ../../
}

function .... {
    cd ../../../
}

function c {
    clear
}

if (Get-Command "bat.exe" -ErrorAction SilentlyContinue)
{
    Remove-Alias cat
    function cat($file) {
        bat.exe --plain $file
    }

    function catn($file) {
        bat.exe $file
    }
}

function prompt {
    $p = $($executionContext.SessionState.Path.CurrentLocation)
    $converted_path = Convert-Path $p
    $ansi_escape = [char]27
    Write-Host $Env:CONDA_PROMPT_MODIFIER -NoNewline
    Write-Host $env:USERNAME -ForegroundColor Green -NoNewline
    Write-Host "@" -ForegroundColor White -NoNewLine
    Write-Host $env:COMPUTERNAME -ForegroundColor Blue -NoNewLine
    Write-Host " " -NoNewLine
    Write-Host $p -NoNewLine
    "PS $('>' * ($nestedPromptLevel + 1)) ";
    Write-Host "$ansi_escape]7;file://$env:COMPUTERNAME/$converted_path$ansi_escape\" -NoNewline
    Write-Host "$ansi_escape]9;9;$converted_path$ansi_escape\"
}

