# Importation du module Active Directory
Import-Module ActiveDirectory

# Paramètres
$csvPathUsers = "C:\Script\importUSERS.csv"
$csvPathAdmins = "C:\Script\importADMIN.csv"
$ouPathUsers = "OU=USER,DC=test,DC=lan"
$ouPathAdmins = "OU=ADMIN,DC=test,DC=lan"

# Fonction pour créer des utilisateurs
function New-UtilisateursAD {
    param (
        [string]$csvPath,
        [string]$ouPath
    )

    try {
        $users = Import-Csv -Path $csvPath -Delimiter ","
    } catch {
        Write-Error "Erreur lors de l'importation du fichier CSV : $($_.Exception.Message)"
        return
    }

    foreach ($user in $users) {
        try {
            $nom = $user.Nom
            $prenom = $user.Prénom
            $nomComplet = "$prenom $nom"
            $samAccountName = "$($prenom.Substring(0, 1))$nom"
            $userPrincipalName = "$samAccountName@test.lan"
            $securePassword = ConvertTo-SecureString -String $user.MotDePasse -AsPlainText -Force

            New-ADUser -Name $samAccountName -DisplayName $nomComplet -GivenName $prenom -Surname $nom -UserPrincipalName $userPrincipalName -AccountPassword $securePassword -Path $ouPath -Enabled $true -ChangePasswordAtLogon $true

            Write-Host "Utilisateur $samAccountName créé avec succès dans $ouPath."
        } catch {
            Write-Error "Erreur lors de la création de l'utilisateur $($user.Nom) : $($_.Exception.Message)"
        }
    }
}

# Création des utilisateurs et des administrateurs
New-UtilisateursAD -csvPath $csvPathUsers -ouPath $ouPathUsers
New-UtilisateursAD -csvPath $csvPathAdmins -ouPath $ouPathAdmins