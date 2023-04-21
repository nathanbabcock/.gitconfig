$Song = New-Object System.Media.SoundPlayer
$Song.SoundLocation = "$PSScriptRoot\angel-choir-ahhhh.wav"
$Song.Play()
Start-Sleep -Seconds 5