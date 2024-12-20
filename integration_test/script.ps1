
$adbPath = "adb"
$emulatorRecordingPath = "/sdcard/test_recording.mp4"
$localRecordingPath = "D:\universaty\senior 2\semester 1\mobile programming\labs\Project\hedieaty\integration_test\test_recording.mp4"
$dartTestFile = "D:\universaty\senior 2\semester 1\mobile programming\labs\Project\hedieaty\integration_test\app_test.dart"
$timeout = 120


Write-Host "Starting screen recording on the emulator..."
Start-Process -NoNewWindow -FilePath $adbPath -ArgumentList "shell screenrecord --time-limit $timeout $emulatorRecordingPath"


Write-Host "Running the Dart integration test..."
Start-Process -NoNewWindow -Wait -FilePath "flutter" -ArgumentList "run $dartTestFile"


Write-Host "Waiting for screen recording to complete..."
Start-Sleep -Seconds ($timeout + 5)


Write-Host "Downloading the screen recording from the emulator..."
Start-Process -NoNewWindow -Wait -FilePath $adbPath -ArgumentList "pull $emulatorRecordingPath $localRecordingPath"


Write-Host "Screen recording downloaded successfully to: $localRecordingPath"


Write-Host "Cleaning up the recording file on the emulator..."
Start-Process -NoNewWindow -FilePath $adbPath -ArgumentList "shell rm $emulatorRecordingPath"

Write-Host "Process completed successfully."
