
<# 
.NAME
    Fortnite_Settings (@TheTulantro)
#>

# Function to update Fortnite settings in the INI file
function UpdateFortniteSetting {
    param (
        [string]$SettingName,
        [string]$NewValue
    )

    $FortniteIniPath = Join-Path $env:LOCALAPPDATA "FortniteGame\Saved\Config\WindowsClient"
    $FortniteIniFile = Get-ChildItem -Path $FortniteIniPath -Filter "GameUserSettings.ini" -Recurse

    if ($null -ne $FortniteIniFile) {
        # Loop through each INI file found (there might be multiple)
        foreach ($file in $FortniteIniFile) {
            $iniFilePath = $file.FullName

            # Update the INI file with the new setting value
            $content = (Get-Content -Path $iniFilePath) -replace "$SettingName=\S+", "$SettingName=$NewValue"
            $content | Set-Content -Path $iniFilePath
        }
    } else {
        # Handle the case where the INI file is not found
        Write-Host "Fortnite INI file not found."
    }
}


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


# title bar and size of window 
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(440,408)
$Form.text                       = "Fortnite_Settings (@TheTulantro)"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#282828")
# start in the centre of the screen
$form.StartPosition = "CenterScreen"

# Set the form to not allow resizing
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

# Disable maximize and minimize buttons
$Form.MaximizeBox = $false


    # Panel1 is for rendering mode background

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 109
$Panel1.width                    = 210
$Panel1.location                 = New-Object System.Drawing.Point(7,13)
$Panel1.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#404040")


    # Panel2 is for  resolution and FPS switch background
$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 109
$Panel2.width                    = 210
$Panel2.location                 = New-Object System.Drawing.Point(221,13)
$Panel2.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#404040")

    # Panel3 is for Audio Quality switch background
$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 109
$Panel3.width                    = 210
$Panel3.location                 = New-Object System.Drawing.Point(221,129)
$Panel3.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#404040")

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Audio Quality"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(14,16)
$Label3.Font                     = New-Object System.Drawing.Font('Arial Rounded MT',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Underline))
$Label3.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")


    # Panel4 is for Nvidia low latency effect setting switch background
$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 109
$Panel4.width                    = 210
$Panel4.location                 = New-Object System.Drawing.Point(7,129)
$Panel4.BackColor                = [System.Drawing.ColorTranslator]::FromHtml("#404040")

# Apply button
$applyButton = New-Object System.Windows.Forms.Button
$applyButton.Text = "Apply"
$applyButton.Width = 424
$applyButton.Height = 46
$applyButton.Location = New-Object System.Drawing.Point(7, 244)
$applyButton.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)
$applyButton.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$applyButton.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#404040")
$form.Controls.Add($applyButton)

# Add an event handler for the button's click event
$Button1.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Success! Settings applied.", "Notification")
})
if ($FortniteIniFile) {
    $FortniteIniFilePath = $FortniteIniFile.FullName
    Write-Host "Fortnite config found at $($FortniteIniFilePath)"
    
    # Create a label for indicating that Fortnite is found
    $fortniteFoundLabel = New-Object System.Windows.Forms.Label
    $fortniteFoundLabel.Text = "Fortnite Found!"
    $fortniteFoundLabel.AutoSize = $true
    $fortniteFoundLabel.Width = 25
    $fortniteFoundLabel.Height = 11
    $fortniteFoundLabel.Location = New-Object System.Drawing.Point(7, 300)
    $fortniteFoundLabel.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)
    $fortniteFoundLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#f1f1b6")
    
    $Form.Controls.Add($fortniteFoundLabel)
} else {
    Write-Host "Fortnite not found."
    
    # "Fortnite Not Found!" label
    $iffortnite = New-Object System.Windows.Forms.Label
    $iffortnite.Text = "Fortnite Not Found!"
    $iffortnite.AutoSize = $true
    $iffortnite.Width = 25
    $iffortnite.Height = 11
    $iffortnite.Location = New-Object System.Drawing.Point(7, 300)
    $iffortnite.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)
    $iffortnite.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#f1f1b6")
    
    $Form.Controls.Add($iffortnite)
}


# Run as Administrator By Default checkbox
$Runasadministratorbydefault = New-Object System.Windows.Forms.CheckBox
$Runasadministratorbydefault.Text = "Run as Administrator By Default"
$Runasadministratorbydefault.AutoSize = $false
$Runasadministratorbydefault.Width = 219
$Runasadministratorbydefault.Height = 20
$Runasadministratorbydefault.Location = New-Object System.Drawing.Point(7, 325)  # Adjusted the Y position
$Runasadministratorbydefault.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)
$Runasadministratorbydefault.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

# Disable Full Screen Optimizations checkbox
$disablefullscreenoptimisations = New-Object System.Windows.Forms.CheckBox
$disablefullscreenoptimisations.Text = "Disable Full Screen Optimizations"
$disablefullscreenoptimisations.AutoSize = $false
$disablefullscreenoptimisations.Width = 230  # Increase Width to prevent text from being cut off
$disablefullscreenoptimisations.Height = 20  # Increased height for better visibility
$disablefullscreenoptimisations.Location = New-Object System.Drawing.Point(7, 350)  # Adjusted the Y position
$disablefullscreenoptimisations.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)
$disablefullscreenoptimisations.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")


# Check if the INI file exists
$FortniteIniPath = Join-Path $env:LOCALAPPDATA "FortniteGame\Saved\Config\WindowsClient"
$FortniteIniFile = Get-ChildItem -Path $FortniteIniPath -Filter "GameUserSettings.ini" -Recurse



# Add controls to the form
$Form.Controls.AddRange(@($Panel1, $Panel2, $Panel3, $Panel4, $Button1, $Runasadministratorbydefault, $disablefullscreenoptimisations))
# Add panels to the form # Add the Panel2 to the form's controls
$Panel3.controls.AddRange(@($Label3))

# Show the form
[void]$Form.ShowDialog()

# Read the values from the INI file and set them as initial values
$iniPath = "C:\Path\To\Your\File.ini"  # Replace with your INI file path
$iniContent = Get-Content -Path $iniPath -Raw
$iniSettings = ConvertFrom-INI $iniContent

if ($iniSettings.RenderingMode) {
    $comboRendering.SelectedItem = $iniSettings.RenderingMode
}

if ($iniSettings.Resolution) {
    $resolution = $iniSettings.Resolution -split '\*'
    $textResolution1.Text = $resolution[0]
    $textResolution2.Text = $resolution[1]
}

if ($iniSettings.FPS) {
    $textFPS.Text = $iniSettings.FPS
}

if ($iniSettings.NvidiaLowLatencyMode) {
    $comboNvidiaLatency.SelectedItem = $iniSettings.NvidiaLowLatencyMode
}

if ($iniSettings.AudioQuality) {
    $comboAudioQuality.SelectedItem = $iniSettings.AudioQuality
}

# Event handler for the Apply button
$applyButton.Add_Click({
    # Read the INI file and compare with the selected values
    $iniContent = Get-Content -Path $iniPath -Raw
    $iniContent = $iniContent -replace 'RenderingMode\s*=\s*\w*', "RenderingMode = $($comboRendering.SelectedItem)"
    $iniContent = $iniContent -replace 'Resolution\s*=\s*\d*\s*\*\s*\d*', "Resolution = $($textResolution1.Text) * $($textResolution2.Text)"
    $iniContent = $iniContent -replace 'FPS\s*=\s*\d*', "FPS = $($textFPS.Text)"
    $iniContent = $iniContent -replace 'NvidiaLowLatencyMode\s*=\s*\w*', "NvidiaLowLatencyMode = $($comboNvidiaLatency.SelectedItem)"
    $iniContent = $iniContent -replace 'AudioQuality\s*=\s*\w*', "AudioQuality = $($comboAudioQuality.SelectedItem)"
    
    Set-Content -Path $iniPath -Value $iniContent

    [System.Windows.Forms.MessageBox]::Show("Success! Settings applied.", "Notification", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})



# Function to convert INI content to a hashtable
function ConvertFrom-INI ($iniContent) {
    $iniData = @{}
    $iniSections = $iniContent -split "\[(.*?)\]" | Where-Object { $_ -match '\w' }
    $currentSection = $null
    foreach ($section in $iniSections) {
        if ($section -match '^\s*(.*?)\s*$') {
            $currentSection = $matches[1]
            $iniData[$currentSection] = @{}
        } else {
            $keyValuePairs = $section -split "`n" | Where-Object { $_ -match '^\s*(.*?)\s*=\s*(.*?)\s*$' }
            foreach ($pair in $keyValuePairs) {
                $key = $matches[1]
                $value = $matches[2]
                $iniData[$currentSection][$key] = $value
            }
        }
    }
    return $iniData
}
