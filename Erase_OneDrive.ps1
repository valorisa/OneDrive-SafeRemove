# Variables
$source = "$env:UserProfile\OneDrive"
$backupDestination = "C:\Sauvegarde contenu OneDrive"
$onedriveProcessName = "OneDrive"

# Fonction pour calculer la taille totale d'un dossier (en octets)
function Get-FolderSize($folderPath) {
    if (Test-Path $folderPath) {
        $files = Get-ChildItem -Path $folderPath -Recurse -File -ErrorAction SilentlyContinue
        $totalSize = ($files | Measure-Object -Property Length -Sum).Sum
        return $totalSize
    }
    else {
        return 0
    }
}

# Fonction de sauvegarde
function Backup-OneDrive {
    Write-Output "Arrêt de OneDrive..."
    Stop-Process -Name $onedriveProcessName -ErrorAction SilentlyContinue

    Write-Output "Création du dossier de sauvegarde : $backupDestination"
    New-Item -ItemType Directory -Path $backupDestination -Force

    Write-Output "Copie du contenu de OneDrive vers la sauvegarde..."
    Robocopy "$source" "$backupDestination" /E /Z /XA:H /W:5 /R:3
    Write-Output "Sauvegarde terminée."
}

# Fonction de désinstallation + blocage
function Uninstall-OneDrive {
    Write-Output "Désinstallation de OneDrive..."
    winget uninstall Microsoft.OneDrive -h

    Write-Output "Modification du profil par défaut pour bloquer OneDrive à la création de nouveaux profils..."
    reg load HKLM\Default_User "C:\Users\Default\NTUSER.DAT"
    reg delete "HKLM\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f
    reg unload HKLM\Default_User

    Write-Output "Désinstallation et blocage terminés."
}

# Fonction pour vérifier la sauvegarde
function Verify-Backup {
    Write-Output "Vérification de la sauvegarde..."
    $sourceSize = Get-FolderSize $source
    $backupSize = Get-FolderSize $backupDestination
    Write-Output "Taille totale source : $sourceSize octets"
    Write-Output "Taille totale sauvegardée : $backupSize octets"

    if ($sourceSize -eq $backupSize -and $sourceSize -ne 0) {
        Write-Output "Sauvegarde complète confirmée."
        return $true
    }
    else {
        Write-Output "Erreur : la sauvegarde ne semble pas complète."
        return $false
    }
}

# Menu principal
function Show-Menu {
    Clear-Host
    Write-Output "==== MENU OneDrive ===="
    Write-Output "1. Vérification de la sauvegarde"
    Write-Output "2. Sauvegarde du contenu OneDrive"
    Write-Output "3. Désinstallation de OneDrive et blocage"
    Write-Output "0. Quitter"
    Write-Output "======================="
}

# Exécution du menu
do {
    Show-Menu
    $choice = Read-Host "Choisissez une option (0-3)"
    switch ($choice) {
        '1' { Verify-Backup | Out-Null; Pause }
        '2' { Backup-OneDrive; Pause }
        '3' { Uninstall-OneDrive; Pause }
        '0' { Write-Output "Sortie du script." }
        default { Write-Output "Option invalide. Veuillez choisir entre 0 et 3."; Pause }
    }
} while ($choice -ne '0')
