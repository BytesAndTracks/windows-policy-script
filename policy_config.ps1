# Habilitar Site to Zone Assignment List no registro
$registryPath = "HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMapKey"
$valueName = Read-Host "Digite o Value Name para o Site to Zone Assignment List"
$value = 2

# Cria ou atualiza a chave do registro
if (!(Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}
Set-ItemProperty -Path $registryPath -Name $valueName -Value $value -Force

Write-Host "Site to Zone Assignment List configurado no registro com sucesso!"

# Aplicar as políticas com gpupdate
Write-Host "Aplicando políticas locais..."
gpupdate /force | Out-Null
Write-Host "Políticas aplicadas com sucesso!"

# Alterar configuração do Microsoft Edge (IE Mode)
$edgePolicyPath = "HKLM:\Software\Policies\Microsoft\Edge"
$edgeSettingName = "InternetExplorerIntegrationReloadInIEModeAllowed"
$edgeSettingValue = 1

# Cria ou atualiza a chave do registro para o Microsoft Edge
if (!(Test-Path -Path $edgePolicyPath)) {
    New-Item -Path $edgePolicyPath -Force | Out-Null
}
Set-ItemProperty -Path $edgePolicyPath -Name $edgeSettingName -Value $edgeSettingValue -Force

Write-Host "Configuração do IE Mode no Microsoft Edge aplicada com sucesso!"

# Abrir o Microsoft Edge para confirmar as alterações
Start-Process "msedge.exe"

Write-Host "Processo concluído. Verifique as configurações no Microsoft Edge."
