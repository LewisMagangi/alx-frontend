# PowerShell Git Push Script
# Usage: .\push.ps1 [files...]
# If no files specified, adds all changes

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Files
)

# Check if any arguments are provided
if ($Files.Count -eq 0) {
    Write-Host "Adding all changes..." -ForegroundColor Green
    git add -A .
} else {
    Write-Host "Adding specified files..." -ForegroundColor Green
    foreach ($file in $Files) {
        Write-Host "Adding: $file" -ForegroundColor Yellow
        git add $file
    }
}

# Get commit message from user
$commitMessage = Read-Host "Enter the commit message"

# Check if commit message is not empty
if ([string]::IsNullOrWhiteSpace($commitMessage)) {
    Write-Host "Commit message cannot be empty!" -ForegroundColor Red
    exit 1
}

# Commit changes
Write-Host "Committing changes..." -ForegroundColor Green
git commit -m $commitMessage

# Check if commit was successful
if ($LASTEXITCODE -eq 0) {
    Write-Host "Pushing to remote..." -ForegroundColor Green
    git push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully pushed to remote!" -ForegroundColor Green
    } else {
        Write-Host "Failed to push to remote!" -ForegroundColor Red
    }
} else {
    Write-Host "Commit failed!" -ForegroundColor Red
}
