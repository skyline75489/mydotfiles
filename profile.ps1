# Env
if (-Not $IsWindows) {
    $env:USERNAME = $env:USER
    $env:COMPUTERNAME = $(hostname)
}
# `which` on Windows
else {
    function which($param) {
        (Get-Command $param).source
    }
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
            exa --group-directories-first
        }

        function sl {
            exa --group-directories-first
        }
    }
    function l {
        exa -la --group-directories-first
    }

    function ll {
        exa -l --git --group-directories-first
    }

    function la {
        exa -la --git --group-directories-first
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
    if ($IsWindows) {
        Remove-Alias cat
    }

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


    if (Get-Command "glg" -ErrorAction SilentlyContinue) {
        Remove-Alias glg
    }

    function glg($param){
        git log $param
    }

    function gs($param) {
        git status $param
    }

    function gcam($param) {
        git commit -am $param
    }

    function gph($param) {
        git push $param
    }

    function grs($param) {
        git restore $param
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
    if ($env:TERM_PROGRAM) {
        Write-Host "$ansi_escape]7;file://$env:COMPUTERNAME/$converted_path$ansi_escape\" -NoNewline
    }
    if ($env:WT_SESSION) {
        Write-Host "$ansi_escape]9;9;$converted_path$ansi_escape\"
    }
}
