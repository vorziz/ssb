# Quick Commit Script - Manual Control
# Run this script multiple times throughout the day

param(
    [int]$Stage = 1
)

$commits = @{
    1  = @{
        Files   = @("lib/features/services/*", "lib/features/booking/*")
        Message = "feat: implement service booking interface with date/time picker"
    }
    2  = @{
        Files   = @("lib/features/wallet/*")
        Message = "feat: add dual wallet system with transaction history"
    }
    3  = @{
        Files   = @("lib/features/rewards/*")
        Message = "feat: create rewards center with claim/redeem functionality"
    }
    4  = @{
        Files   = @("lib/features/home/*", "lib/navigation/*")
        Message = "feat: setup navigation and home dashboard"
    }
    5  = @{
        Files   = @("lib/features/car_locator/controllers/*", "lib/features/car_locator/models/*")
        Message = "feat: add car locator with compass direction"
    }
    6  = @{
        Files   = @("lib/features/car_locator/ui/map_view_page.dart")
        Message = "feat: integrate OpenStreetMap for retail discovery"
    }
    7  = @{
        Files   = @("lib/features/car_locator/ui/qr_scanner_page.dart", "android/app/src/main/AndroidManifest.xml")
        Message = "feat: implement real QR scanner with camera permissions"
    }
    8  = @{
        Files   = @("lib/features/car_locator/ui/grocery_list_page.dart", "lib/features/car_locator/ui/campaign_detail_page.dart")
        Message = "feat: add grocery list and campaign details"
    }
    9  = @{
        Files   = @("lib/features/booking/controllers/booking_controller.dart")
        Message = "feat: add live polling for booking status updates"
    }
    10 = @{
        Files   = @("lib/features/services/ui/service_list_page.dart")
        Message = "feat: add shimmer loading effect for better UX"
    }
    11 = @{
        Files   = @("pubspec.yaml")
        Message = "chore: update dependencies to latest versions"
    }
    12 = @{
        Files   = @("README.md")
        Message = "docs: create comprehensive README with features and setup"
    }
    13 = @{
        Files   = @("COMPLIANCE_CHECK.md")
        Message = "docs: add technical challenge compliance documentation"
    }
    14 = @{
        Files   = @("feedback.md")
        Message = "docs: add feedback and future improvements documentation"
    }
}

if ($Stage -gt $commits.Count) {
    Write-Host "❌ Stage $Stage does not exist. Max stage is $($commits.Count)" -ForegroundColor Red
    exit 1
}

$commit = $commits[$Stage]
Write-Host "📝 Stage $Stage/$($commits.Count): $($commit.Message)" -ForegroundColor Green

# Stage files
foreach ($filePattern in $commit.Files) {
    git add $filePattern 2>$null
}
git add -A 2>$null

# Commit
git commit -m $commit.Message

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Committed successfully" -ForegroundColor Green
    
    # Push
    Write-Host "📤 Pushing to remote..." -ForegroundColor Cyan
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Pushed successfully" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next: Run './quick_commit.ps1 -Stage $($Stage + 1)' in ~20 minutes" -ForegroundColor Yellow
    }
}
else {
    Write-Host "⚠️  No changes to commit" -ForegroundColor Yellow
}
