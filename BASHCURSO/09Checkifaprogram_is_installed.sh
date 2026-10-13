#!/bin/bash
if command -v git >/dev/null 2>&1; then
	# Par défaut, si git est trouvé, command -v affiche son chemin dans le terminal.en suite 
	# on redirige ver /dev/null le trou noir quil efface tout ce qu'on lui envoie 
	# 2>&1   1- répresente la sortie d'erreur dans le cas si l'instruction ne marche pas correctement il affiche l'erreur 
	# 1 répresente la sortie standard 
	# &1 signifie "ver la même destination que la sortie"
	# Comme la sortie 1 a été envoyée vers /dev/null juste avant, cela signifie: "Envoyez aussi les messages d'erreur dans le trou noir" 	
	# But: si git n'est pas installé, la command -v aurait affiché une erreur comme "git: command not found". Cette redirection rend le script silencieux, même en cas d'échec 
   
#	Pourquoi l'utiliser ?
#  Si vous avez défini un alias git='mon_script_bogué.sh', taper simplement git exécuterait l'alias.
#   command git ignore l'alias et cherche le vrai binaire.
#    C'est crucial dans les scripts pour éviter les comportements inattendus.


#    Comportement :
#        Succès : Affiche /usr/bin/git (ou autre) et renvoie le code de sortie 0.
#        Échec : N'affiche rien (ou un message d'erreur selon le shell) et renvoie un code de sortie non nul (généralement 1).
#    Note : Dans un if, Bash ne regarde pas le texte affiché, il regarde uniquement le code de sortie (0 = Vrai, autre = Faux).

#     C. >/dev/null (Le silencieux de sortie standard)

#    Concept : /dev/null est un fichier spécial qui agit comme un "trou noir". Tout ce qu'on y écrit disparaît immédiatement.
#    Le problème sans cela : Si git est installé, command -v git afficherait /usr/bin/git dans votre terminal. Vous ne voulez pas voir ce chemin, vous voulez juste voir votre message "Git est installé".
#    L'action : Le symbole > redirige la sortie standard (fd 1) vers ce trou noir.
#     
#    D. 2>&1 (Le silencieux d'erreurs)

#   Concept : Les programmes ont deux canaux de sortie :
#        1 (stdout) : La sortie normale (le chemin du fichier).
#        2 (stderr) : La sortie d'erreur (ex: "git: command not found").
#    Le problème sans cela : Si git n'est pas installé, command -v envoie un message d'erreur sur le canal 2. Ce message s'afficherait quand même dans le terminal, même si la condition est fausse.
#    L'action : 2>&1 signifie "Redirige le canal 2 (erreur) vers la même destination que le canal 1".
#    La combinaison magique : Comme le canal 1 a déjà été envoyé vers /dev/null juste avant, le canal 2 y est envoyé aussi.
#        Résultat : Silence total, que la commande réussisse ou échoue.
#
# E. if ... ; then (Le juge)
#
#    Bash évalue le code de retour de toute la chaîne précédente.
#    Code 0 (Succès) → Exécute le bloc then.
#    Code non-0 (Échec) → Saute au bloc else (s'il existe) ou continue.


	
	echo "le logiciel git est installée"
else 
	echo "le logiciel git n'est pas installé"

fi



