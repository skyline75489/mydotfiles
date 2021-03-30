# Env
if (-Not $IsWindows) {
    $env:USERNAME = $env:USER
    $env:COMPUTERNAME = $(hostname)
}

# List direcory contents
if (Get-Command "exa" -ErrorAction SilentlyContinue) {
    if ($IsWindows) {
        Remove-Alias ls
        function ls($param) {
            exa $param
        }
    }
    else {
        function ls {
            exa
        }

        function sl {
            exa
        }
    }
    function l {
        exa -la
    }

    function ll {
        exa -l --git
    }

    function la {
        exa -la --git
    }
}
else {
    if (-Not $IsWindows) {
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
    else {
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

# Cat
if (Get-Command "bat" -ErrorAction SilentlyContinue) {
    function cat($file) {
        bat --plain $file
    }

    function catn($file) {
        bat $file
    }
}

if (Get-Command "batcat" -ErrorAction SilentlyContinue) {
    function cat($file) {
        batcat --plain $file
    }

    function catn($file) {
        batcat $file
    }
}

# Git
if (Get-Command "git" -ErrorAction SilentlyContinue) {
    function gck($branch) {
        git checkout $branch
    }

    function gd($param) {
        git diff $param
    }

    function gs($param) {
        git status $param
    }

    function gcam($param) {
        git commit -am $param
    }
}

# Basic directory operations
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

