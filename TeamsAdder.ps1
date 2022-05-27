Import-Module MicrosoftTeams
Connect-MicrosoftTeams

Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Teams Channel Adder'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true

#Marks what the input field is for
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "User Email"
$Label.Location  = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Main Channel"
$Label.Location  = New-Object System.Drawing.Point(0,40)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Sub Channel"
$Label.Location  = New-Object System.Drawing.Point(0,70)
$Label.AutoSize = $true
$main_form.Controls.Add($Label)

#Input Field
$textBoxEmail = New-Object System.Windows.Forms.TextBox
$textBoxEmail.Location = New-Object System.Drawing.Point(80,7)
$textBoxEmail.Size = New-Object System.Drawing.Size(260,20)
$main_form.Controls.Add($textBoxEmail)
$main_form.Add_Shown({$textBoxEmail.Select()})

$textBoxMainChan = New-Object System.Windows.Forms.TextBox
$textBoxMainChan.Location = New-Object System.Drawing.Point(80,37)
$textBoxMainChan.Size = New-Object System.Drawing.Size(260,20)
$main_form.Controls.Add($textBoxMainChan)
$main_form.Add_Shown({$textBoxMainChan.Select()})

$textBoxSubChan = New-Object System.Windows.Forms.TextBox
$textBoxSubChan.Location = New-Object System.Drawing.Point(80,67)
$textBoxSubChan.Size = New-Object System.Drawing.Size(260,20)
$main_form.Controls.Add($textBoxSubChan)
$main_form.Add_Shown({$textBoxSubChan.Select()})

#Accept Button to add user
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(350,7)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
#Log something from form by button $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$okButton.Add_Click($function:okButtonClick)
$main_form.AcceptButton = $okButton
$main_form.Controls.Add($okButton)

$main_form.ShowDialog()

#variables for functions
$teamMainId = ''
$teamSubId = ''

function withSub {
    Add-TeamUser -GroupId $teamMainID -User $textBoxEmail.Text
    Add-TeamChannelUser -GroupId $teamMainID -DisplayName $textBoxSubChan.Text -User $textBoxEmail.Text
}

function withoutSub {
    Add-TeamUser -GroupId $teamMainID -User $textBoxEmail.Text
}


function spacing {
    if ($textBoxSubChan.Text -eq $null -or $textBoxSubChan.Text -eq '') {
        Write-Host 'Trying without Sub'
        withoutSub
    } else {
        Write-Host 'Trying with Sub using '
        Write-Host $textBoxSubChan.Text
        $teamSubObj = Get-Team -DisplayName $textBoxSubChan.Text
        $teamSubId = $teamSubObj.GroupId
        Write-Host $teamSubId
        withSub
    }
    $textBoxEmail.Text = ''
}

function okButtonClick {
    Write-Host "attempting to add users2..."
    Write-Host $textBoxEmail.Text 
    Write-Host $textBoxMainChan.Text 
    $teamMainObj = Get-Team -DisplayName $textBoxMainChan.Text
    $teamMainId = $teamMainObj.GroupId
    Write-Host $teamMainID
    Write-Host $textBoxSubChan.Text
    spacing
}