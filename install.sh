#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi
doTheThing() {
    flatpak remote-delete fedora
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub \
com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep \
me.timschneeberger.jdsp4linux org.gnome.Boxes \
com.valvesoftware.Steam io.github.limo_app.limo \
com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive org.kde.subtitlecomposer \
com.visualstudio.code io.github.shiftey.Desktop \
org.qbittorrent.qBittorrent \
org.upscayl.Upscayl com.github.huluti.Curtail com.github.qarmin.czkawka fr.handbrake.ghb \
com.yacreader.YACReader org.musicbrainz.Picard \
dev.vencord.Vesktop us.zoom.Zoom \
app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube \
com.github.mtkennerly.ludusavi com.steamgriddb.steam-rom-manager io.itch.itch org.prismlauncher.PrismLauncher uk.co.powdertoy.tpt \
com.feaneron.Boatswain io.github.pwr_solaar.solaar \
org.azahar_emu.Azahar org.flycast.Flycast com.github.AmatCoder.mednaffe org.DolphinEmu.dolphin-emu io.github.simple64.simple64 ca._0ldsk00l.Nestopia org.duckstation.DuckStation net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.ppsspp.PPSSPP info.cemu.Cemu com.snes9x.Snes9x
}
if ! doTheThing; then
    echo "Couldn't do the thing."
    exit 1
fi