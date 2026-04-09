# Make config variables available
. .\config.ps1

# Load required Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create file dialog object
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = [Environment]::GetFolderPath('Desktop')
    Filter = 'All Files (*.*)|*.*'
}

# Show the dialog and capture the result
$null = $FileBrowser.ShowDialog()

# Return the selected file path
$FileBrowser.FileName

# User confirmation that correct file was selected
Write-Host "Press enter to confirm that you want to run $($FileBrowser.FileName). Press Ctrl+C to exit and select again."
Pause

# Loop the process indefinitely
while ($true) {

    # Start the application and use the -PassThru parameter to store the process object in a variable
    $app = Start-Process $FileBrowser.FileName -PassThru

    Write-Host "Running program. Press Ctrl+C to stop."

    # Wait for a specified period of runtime
    Start-Sleep -Seconds $timeRun

    # Close the application window
    Stop-Process -Id $app.Id

    Write-Host "Program waiting for next cycle, please wait or press Ctrl+C to stop."

    # Wait for a specified period before starting again
    Start-Sleep -Seconds $timeStop
}
