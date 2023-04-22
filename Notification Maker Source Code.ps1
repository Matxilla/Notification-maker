Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Notification Creator"
$Form.Width = 250
$Form.Height = 300
$Form.FormBorderStyle = 'FixedSingle'
$Form.StartPosition = "CenterScreen"
$Form.Topmost = $false
$Form.MaximizeBox = $false

$Label1 = New-Object System.Windows.Forms.Label
$Label1.Text = "Header:"
$Label1.AutoSize = $true
$Label1.Location = New-Object System.Drawing.Point(15, 15)

$Textbox1 = New-Object System.Windows.Forms.TextBox
$Textbox1.Location = New-Object System.Drawing.Point(15, 40)
$Textbox1.Size = New-Object System.Drawing.Size(205, 20)

$Label2 = New-Object System.Windows.Forms.Label
$Label2.Text = "Text:"
$Label2.AutoSize = $true
$Label2.Location = New-Object System.Drawing.Point(15, 75)

$Textbox2 = New-Object System.Windows.Forms.TextBox
$Textbox2.Location = New-Object System.Drawing.Point(15, 100)
$Textbox2.Multiline = $true
$Textbox2.Size = New-Object System.Drawing.Size(205, 100)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(15, 215)
$Button.Size = New-Object System.Drawing.Size(205, 25)
$Button.Text = "Create Notification"
$Button.Add_Click({
      $notify = New-Object System.Windows.Forms.NotifyIcon
      $notify.Icon = [System.Drawing.SystemIcons]::Information
      $notify.Visible = $true
      $notify.ShowBalloonTip(0, $Textbox1.Text, $Textbox2.Text, [System.Windows.Forms.ToolTipIcon]::None)
      $notify.Dispose()
})

$Textbox2.Add_KeyDown({
    param($sender, $e)
    if ($e.KeyCode -eq "Enter" -and (-not $e.Shift)) {
        # Only create notification if enter key is pressed and shift key is not also pressed
        $notify = New-Object System.Windows.Forms.NotifyIcon
        $notify.Icon = [System.Drawing.SystemIcons]::Information
        $notify.Visible = $true
        $notify.ShowBalloonTip(0, $Textbox1.Text, $Textbox2.Text, [System.Windows.Forms.ToolTipIcon]::None)
        $notify.Dispose()
        $e.SuppressKeyPress = $true  # Prevents adding new line after notification is created
    }
})

$Form.Controls.Add($Label1)
$Form.Controls.Add($Textbox1)
$Form.Controls.Add($Label2)
$Form.Controls.Add($Textbox2)
$Form.Controls.Add($Button)

$Form.ShowDialog() | Out-Null
