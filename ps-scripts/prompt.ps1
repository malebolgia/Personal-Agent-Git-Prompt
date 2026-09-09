function prompt {
    $esc = [char]27
    $reset = "$esc[0m"

    # Hex Colors (RGB)
    $pathBg   = "$esc[48;2;139;16;216m$esc[38;2;255;255;255m" # Purple
    
    # Git Group Colors
    $gitTagBg = "$esc[48;2;26;42;58m$esc[38;2;80;227;194m$esc[1m" # Deep Navy + Cyan Bold [Git]
    $gitBg    = "$esc[48;2;255;251;56m$esc[38;2;25;53;73m"         # Yellow Branch
    $userBg   = "$esc[48;2;46;149;153m$esc[38;2;255;255;255m"       # Teal User
    
    # GitHub CLI Group Colors
    $ghTagBg  = "$esc[48;2;36;41;47m$esc[38;2;255;255;255m$esc[1m" # GitHub Dark [GH]
    $ghBg     = "$esc[48;2;68;76;86m$esc[38;2;255;255;255m"        # Medium Grey @user

    # Prompt Execution Block Color
    $promptBg = "$esc[48;2;216;27;96m$esc[38;2;255;255;255m$esc[1m" # Vibrant Magenta/Pink Block

    # Line 1: Workspace Path
    $path = (Get-Location).Path.Replace($HOME, "~")
    $line1 = "$pathBg 🏠 $path $reset"

    # Line 2: Git & GitHub Metadata Category
    $gitCategory = ""

    # Local Git Check
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $branch = (git branch --show-current 2>$null)
        if ($branch) {
            $username = (git config user.name 2>$null)
            if (-not $username) { $username = "No User" }
            
            # [Git] Label + Branch + Local Identity
            $gitCategory += "$gitTagBg Git $reset$gitBg ⛕ $branch $reset$userBg 👨🏻‍🦲 $username $reset "
        }
    }

    # GitHub CLI Check
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        $ghUser = (gh api user --jq .login 2>$null)
        if ($ghUser) {
            # [GH] Label + GitHub Account
            $gitCategory += "$ghTagBg GH $reset$ghBg 🐙 @$ghUser $reset "
        }
    }

    $promptArrow = "$promptBg 🚀 > $reset "

    # Output
    if ($gitCategory) {
        Write-Host $line1
        return "$gitCategory$promptArrow"
    } else {
        return "$line1$promptArrow"
    }
}