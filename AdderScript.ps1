Import-Module MicrosoftTeams

Connect-MicrosoftTeams

$userToAdd = Read-Host "Enter username first.last"
$userToAdd = $userToAdd + "@ticketnetwork.com"

$channelName = Read-Host "Enter channel name ie ITHD365"
$channelName = Get-Team -DisplayName $channelName

Add-TeamUser -GroupId $channelName.GroupId -User $userToAdd

$subName = Read-Host "Enter sub \ private channel name"
Write-Host $channelName.GroupId " this id is for " $channelName.DisplayName
Write-Host $subName
Write-Host $userToAdd
Add-TeamChannelUser -GroupId $channelName.GroupId -DisplayName $subName -User $userToAdd