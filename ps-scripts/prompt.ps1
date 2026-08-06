function prompt {
    $esc = [char]27
    $reset = "$esc[0m"

    # Hex Colors (RGB)
    $pathBg = "$esc[48;2;139;16;216m$esc[38;2;255;255;255m" # Purple
    $gitBg  = "$esc[48;2;255;251;56m$esc[38;2;25;53;73m"   # Yellow
    $userBg = "$esc[48;2;46;149;153m$esc[38;2;255;255;255m" # Teal

    # Data
    $path = (Get-Location).Path.Replace($HOME, "~")
    $gitSegment = ""

    if (Get-Command git -ErrorAction SilentlyContinue) {
        $branch = (git branch --show-current 2>$null)
        if ($branch) {
            $username = (git config user.name 2>$null)
            if (-not $username) { $username = "No User" }
            
            # Segment: Git Branch + Git User
            $gitSegment = "$gitBg ⛕ $branch $reset$userBg 👨🏻‍🦲 $username $reset"
        }
    }

    # Output
    $line1 = "$pathBg 🏠 $path $reset$gitSegment"
    $line2 = "🚀 > "

    Write-Host $line1
    return $line2
}