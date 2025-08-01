#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

doTheThing() {
	#sudo flatpak remote-add --if-not-exists flatpaks-beeper https://flatpaks.github.io/beeper/beeper.flatpakrepo
	#sudo flatpak install flatpaks-beeper com.beeper.beeper
	flatpak install flathub org.audacityteam.Audacity com.github.huluti.Curtail io.github.ungoogled_software.ungoogled_chromium com.github.qarmin.czkawka io.freetubeapp.FreeTube io.github.ellie_commons.jorts org.kde.kdenlive org.kde.krita org.kde.kate org.libreoffice.LibreOffice com.modrinth.ModrinthApp org.nicotine_plus.Nicotine com.obsproject.Studio org.qbittorrent.qBittorrent dev.geopjr.Tuba org.upscayl.Upscayl dev.vencord.Vesktop app.ytmdesktop.ytmdesktop us.zoom.Zoom
}

while
	read -p "Install preferred flatpaks (y/N)" yn
do
	case $yn in
		([yY]) doTheThing;;
		(*) break;;
	esac
done