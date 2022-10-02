# Redream Flatpak

## Building (Ubuntu)

Install Flatpak dependencies:

```sh
sudo add-apt-repository ppa:flatpak/stable
sudo apt install flatpak flatpak-builder gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Install runtime:

```sh
flatpak install flathub org.freedesktop.Platform//22.08 org.freedesktop.Sdk//22.08
```

Build Flatpak:

```sh
flatpak-builder --default-branch=beta --force-clean build-dir io.recompiled.redream.yml
```

Install Flatpak:

```sh
flatpak install --user redream.flatpak
```

Run Flatpak:

```sh
flatpak run io.recompiled.redream
```

Delete Flatpak:

```sh
flatpak remove --user io.recompiled.redream
```