0-avoir les dossier partagées samba données open mediavaultavec des données: 

1- Sur synology créez un oldossier partagé sur filestation avec 

2-allez sur filestation monter un dossier distant \\\\ipdusnas\\partage 

3- panneau de configuration -- planificateur de taches -- nouvelle tache 

4 - definir le script rsync dans la tache 

exemple de script 

\#partage

rsync -avPzh –delete -e ssh root@server.tuv.ch:/srv/samba/serve/partage/ /srv/samba/serve/partage/ > /srv/test/transfert-date +%Y-%m-%d-%H-%M.log 2>&1

\#media

rsync -avPzh –delete -e ssh root@server.tuv.ch:/srv/media/ /srv/samba/serve/media/ > /srv/test/transfert_media-date +%Y-%m-%d-%H-%M.log 2>&1

\#archives

rsync -avPzh –delete -e ssh root@server.tuv.ch:/srv/archives/ /srv/samba/serve/archives/ > /srv/test/transfert_archives-date +%Y-%m-%d-%H-%M.log 2>&1

\#applications

rsync -avPzh –delete -e ssh root@server.tuv.ch:/srv/applications/ /srv/samba/serve/applications/ > /srv/test/transfert_applications-date +%Y-%m-%d-%H-%M.log 2>&1

\#home users

rsync -avPzh –delete -e ssh root@server.tuv.ch:/srv/home/users/ /srv/home/users/ > /srv/test/transfert_homeusers-date +%Y-%m-%d-%H-%M.log 2>&1

deuxième exemple 

PS: cella fonctionne car on fait croire au syno que les dossier montées distants sont en locale 

creer les memes dossiers (dossier partagé) avec les meme nom du nas openmediavault 

allez sur synology panneau de config -- planificateur de taches -- nouvelle tache 

executé par root 

13h du mat

parametres de la tâche: exemples seulement à adapter

envoyer par mail 

rsync -a /volume1/omv/skn*interne /volume1/skn*interne > /volume1/omv/log +%Y-%m-%d-%H-%M.log 2>&1

rsync -a /volume1/omv/backupinterne /volume1/backupinterne > /volume1/omv/log +%Y-%m-%d-%H-%M.log 2>&1

rsync -a /volume1/omv/backupExtern /volume1/backupExtern > /volume1/omv/log +%Y-%m-%d-%H-%M.log 2>&1

inpiration de script .....................

rsync -a /volume1/omv/skninterne /volume1/skn_interne > /volume1/omv/log +%Y-%m-%d-%H-%M.log 2>&1
