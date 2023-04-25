$Song = New-Object System.Media.SoundPlayer
$Song.SoundLocation = "$PSScriptRoot\warzone-headshot.wav"
$Song.Play()
Start-Sleep -Seconds 5