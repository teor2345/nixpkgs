{ stdenv
, lib
, fetchFromGitLab
, gitUpdater
, appstream-glib
, desktop-file-utils
, fwupd
, gettext
, glib
, gtk4
, libadwaita
, libxmlb
, meson
, ninja
, pkg-config
, systemd
, help2man
, wrapGAppsHook4
}:

stdenv.mkDerivation rec {
  pname = "gnome-firmware";
  version = "43.1";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "World";
    repo = "gnome-firmware";
    rev = version;
    sha256 = "9QS6X1Cm9/wToQ8hnGNn3VytSCpZI8StZ3+vf0/wbAw=";
  };

  nativeBuildInputs = [
    appstream-glib # for ITS rules
    desktop-file-utils
    gettext
    help2man
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    fwupd
    glib
    gtk4
    libadwaita
    libxmlb
    systemd
  ];

  mesonFlags = [
    "-Dconsolekit=false"
  ];

  passthru.updateScript = gitUpdater {
    ignoredVersions = "(alpha|beta|rc).*";
  };

  meta = with lib; {
    homepage = "https://gitlab.gnome.org/World/gnome-firmware";
    description = "Tool for installing firmware on devices";
    license = licenses.gpl2Plus;
    maintainers = teams.gnome.members;
    platforms = platforms.linux;
  };
}
