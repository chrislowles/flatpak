#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi
doTheThing() {
    . /etc/os-release
    case "$ID" in
        linuxmint)
            echo "Running on Linux Mint."
            sudo apt update
            sudo apt install flatpak
            ;;
        *)
            echo "Unsupported Linux distro: $ID"
            exit 1
            ;;
    esac
    flatpak remote-delete fedora
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub \
    com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep \
    me.timschneeberger.jdsp4linux org.gnome.Boxes \
    com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive org.kde.subtitlecomposer \
    com.visualstudio.code io.github.shiftey.Desktop \
    org.qbittorrent.qBittorrent \
    org.upscayl.Upscayl com.github.huluti.Curtail com.github.qarmin.czkawka \
    fr.handbrake.ghb com.yacreader.YACReader org.musicbrainz.Picard \
    dev.vencord.Vesktop us.zoom.Zoom com.sindresorhus.Caprine \
    app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube \
    com.feaneron.Boatswain io.github.pwr_solaar.solaar org.openrgb.OpenRGB \
    com.valvesoftware.Steam io.itch.itch com.heroicgameslauncher.hgl net.davidotek.pupgui2 io.github.limo_app.limo com.github.mtkennerly.ludusavi com.steamgriddb.steam-rom-manager org.prismlauncher.PrismLauncher uk.co.powdertoy.tpt \
    org.azahar_emu.Azahar org.flycast.Flycast com.github.AmatCoder.mednaffe org.DolphinEmu.dolphin-emu io.github.simple64.simple64 ca._0ldsk00l.Nestopia org.duckstation.DuckStation net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.ppsspp.PPSSPP info.cemu.Cemu com.snes9x.Snes9x
}
if ! doTheThing; then
    echo "Couldn't do the thing."
    exit 1
fi
while
	read -p "Install other preferred flatpaks such as Libreoffice and Celluloid? These are usually preinstalled on distros. (y/N)" moar
do
	case $moar in
		([yY][eE][sS] | [yY]) flatpak install flathub org.libreoffice.LibreOffice io.github.celluloid_player.Celluloid;;
		(*) break;;
	esac
done