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

    Write-Host "Running program with PID ($($app.Id)). Press Ctrl+C to stop."

    # Wait for a specified period of runtime (WaitForExit in ms), wait for runtime or early exit
    $app.WaitForExit($timeRun * 1000) | Out-Null

    # Close the application window forcefully
    if (-not $app.HasExited) {
        Get-CimInstance Win32_Process | 
            Where-Object { $_.ParentProcessId -eq $app.Id -or $_.ProcessId -eq $app.Id } |
            ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
        $app.WaitForExit(2000) | Out-Null
    }

    $app.Dispose()

    Write-Host "Program waiting for next cycle, please wait or press Ctrl+C to stop."

    # Wait for a specified period before starting again
    Start-Sleep -Seconds $timeStop
}
