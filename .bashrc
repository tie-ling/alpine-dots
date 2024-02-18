export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null
e () { emacsclient --alternate-editor="" --create-frame "${@}"; }
montab4k () { swaymsg input  "9580:109:GAOMON_Gaomon_Tablet_Pen"  map_to_region 512 288 768 432; }
montab3k () { swaymsg input  "9580:109:GAOMON_Gaomon_Tablet_Pen"  map_to_region 428 240 639 360; }
