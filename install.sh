#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

full() {
	flatpak install flathub com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep me.timschneeberger.jdsp4linux org.gnome.Boxes com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive io.github.shiftey.Desktop org.qbittorrent.qBittorrent fr.handbrake.ghb org.musicbrainz.Picard dev.vencord.Vesktop us.zoom.Zoom com.sindresorhus.Caprine app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube io.github.pwr_solaar.solaar org.upscayl.Upscayl \ com.valvesoftware.Steam com.steamdeckrepo.manager net.lutris.Lutris net.davidotek.pupgui2 io.github.limo_app.limo com.github.mtkennerly.ludusavi com.steamgriddb.steam-rom-manager org.prismlauncher.PrismLauncher uk.co.powdertoy.tpt org.azahar_emu.Azahar org.flycast.Flycast com.github.AmatCoder.mednaffe org.DolphinEmu.dolphin-emu io.github.simple64.simple64 ca._0ldsk00l.Nestopia org.ppsspp.PPSSPP org.duckstation.DuckStation net.pcsx2.PCSX2 net.rpcs3.RPCS3 net.shadps4.shadPS4 info.cemu.Cemu com.snes9x.Snes9x
}

basic() {
	flatpak install flathub com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep me.timschneeberger.jdsp4linux org.gnome.Boxes com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive io.github.shiftey.Desktop org.qbittorrent.qBittorrent fr.handbrake.ghb org.musicbrainz.Picard dev.vencord.Vesktop us.zoom.Zoom com.sindresorhus.Caprine app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube io.github.pwr_solaar.solaar org.upscayl.Upscayl
}

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
	while
		read -p "fF for full base - bB for crucial/laptop base" base
	do
		case $base in
			([fF]) full;;
			([bB]) basic;;
			(*) break;;
		esac
	done
}

if ! doTheThing; then
	echo "Couldn't install base preferred flatpaks."
	exit 1
fi