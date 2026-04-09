# Oscillate

Open executable file on timer, then close, on repeat.

## Instructions

1) Clone or download the repo.

```powershell
git clone https://github.com/spiritualhost/oscillate.git
```

2) Run the oscillate.ps1 script in an elevated PowerShell Window. Either watch or minimize, but don't close the window.

3) Some users may need to temporarily enable PowerShell scripts by running the following in the same window:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## Configuration

To edit the time the program runs for and the time the program waits to launch again, edit the values in [the config file](.\config.ps1). Values there are measured in seconds.
