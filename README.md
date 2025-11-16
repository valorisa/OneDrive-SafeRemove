# OneDrive-SafeRemove

OneDrive-SafeRemove est un script PowerShell interactif permettant de sauvegarder le contenu local de OneDrive, vérifier l'intégrité de cette sauvegarde, puis désinstaller proprement OneDrive tout en empêchant sa réinstallation automatique sur Windows 10/11.

## Fonctionnalités

- Sauvegarde complète du dossier OneDrive vers un dossier local (modifiable).
- Vérification que la sauvegarde est complète avant toute suppression.
- Désinstallation propre de OneDrive via WinGet.
- Blocage de la réinstallation automatique de OneDrive pour les nouveaux profils utilisateurs.
- Interface en mode console avec menu interactif permettant d'exécuter étape par étape ou de manière autonome chaque fonction.

## Prérequis

- Windows 10 ou Windows 11.
- PowerShell exécuté en mode Administrateur.
- `WinGet` installé et disponible dans le système.
- Permissions pour modifier le registre (pour bloquer la réinstallation).

## Utilisation

1. Exécutez le script dans une console PowerShell élevée (mode Administrateur).
2. Choisissez l'une des options du menu :
   - Vérifier la sauvegarde existante.
   - Sauvegarder le contenu de OneDrive.
   - Désinstaller OneDrive et bloquer sa réinstallation.
3. Le chemin de sauvegarde par défaut est `C:Sauvegarde contenu OneDrive`, modifiable dans le script.

## Sécurité et précautions

- Assurez-vous que la sauvegarde est complète avant de lancer la désinstallation.
- Le script arrête temporairement le processus OneDrive pour éviter les conflits lors de la sauvegarde.
- La modification du registre empêche l'installation automatique pour les futurs utilisateurs, pas pour les utilisateurs déjà existants.

## Contribution

Les contributions sont bienvenues : n'hésitez pas à proposer des améliorations, des corrections ou des extensions sous forme de pull requests.

## Licence

Ce projet est distribué sous licence MIT. Voir le fichier LICENSE pour plus de détails.

---

**Auteur** : valorisa
**Date** : Novembre 2025
