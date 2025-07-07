#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

doTheThing() {
	. /etc/os-release
	case "$ID" in
		linuxmint)
			apt update
			apt install steam-devices
			flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
			;;
		fedora)
			dnf update
			dnf upgrade
			dnf install steam-devices
			flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
			flatpak install --reinstall flathub $(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1)
			flatpak remote-delete fedora
			;;
		*)
			exit 1
			;;
	esac
	flatpak install flathub \
	com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep \
	me.timschneeberger.jdsp4linux org.gnome.Boxes \
	com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive org.kde.subtitlecomposer \
	io.github.shiftey.Desktop \
	org.qbittorrent.qBittorrent \
	fr.handbrake.ghb com.yacreader.YACReader org.musicbrainz.Picard \
	dev.vencord.Vesktop us.zoom.Zoom com.sindresorhus.Caprine \
	app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube \
	io.github.pwr_solaar.solaar \
	org.upscayl.Upscayl
}

if ! doTheThing; then
	echo "Couldn't install base preferred flatpaks."
	exit 1
fi

while
	read -p "Install preferred gaming-related flatpaks? (y/N)" gaming
do
	case $gaming in
		([yY]) flatpak install flathub com.valvesoftware.Steam com.steamdeckrepo.manager net.lutris.Lutris net.davidotek.pupgui2 io.github.limo_app.limo com.github.mtkennerly.ludusavi com.steamgriddb.steam-rom-manager org.prismlauncher.PrismLauncher uk.co.powdertoy.tpt \ org.azahar_emu.Azahar org.flycast.Flycast com.github.AmatCoder.mednaffe org.DolphinEmu.dolphin-emu io.github.simple64.simple64 ca._0ldsk00l.Nestopia org.ppsspp.PPSSPP org.duckstation.DuckStation net.pcsx2.PCSX2 net.rpcs3.RPCS3 net.shadps4.shadPS4 info.cemu.Cemu com.snes9x.Snes9x;;
		(*) break;;
	esac
done

while
	read -p "Install other preferred flatpaks such as LibreOffice and Celluloid? These are usually preinstalled on distros. (y/N)" etc
do
	case $etc in
		([yY]) flatpak install flathub org.libreoffice.LibreOffice io.github.celluloid_player.Celluloid;;
		(*) break;;
	esac
done