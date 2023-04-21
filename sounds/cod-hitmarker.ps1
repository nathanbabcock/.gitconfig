$Song = New-Object System.Media.SoundPlayer
$Song.SoundLocation = "$PSScriptRoot\cod-hitmarker.wav"
$Song.Play()
Start-Sleep -Seconds 1