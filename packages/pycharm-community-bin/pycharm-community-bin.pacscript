name="pycharm-community-bin"
version="2022.1.2"
pkgname="pycharm-community"
gives="pycharm-community"
maintainer="Obsidian <emil-aarestrup@outlook.dk>"
description="Python IDE for professional developers aimed at productivity with a keyboard-centric focus."
url="https://download.jetbrains.com/python/pycharm-community-${version}.tar.gz"
hash="34b9038b0d5fc7fa43ad8b7023b4622d2efe5dd64174539f5d50fc64e23c395d"
desktop_file_sum="0367fc67c51d5d99fd64a5184b8acb2dbed4a56bb26eecdcf25a2414f2233c04"
repology=("project: pycharm")

prepare() {
  wget -qO "pycharm.desktop" "https://raw.githubusercontent.com/pacstall/pacstall-programs/master/packages/${name}/pycharm.desktop"
  if [[ "$(sha256sum pycharm.desktop | cut -d' ' -f 1)" != "${desktop_file_sum}" ]]; then
    fancy_message error "Checksum for pycharm.desktop failed"
    return 1
  fi
}

build() {
  true
}

install() {
  sudo mkdir -p "${STOWDIR}/${name}/usr/share/licenses/pycharm"
  sudo mkdir -p "${STOWDIR}/${name}/usr/share/pycharm"
  sudo mkdir -p "${STOWDIR}/${name}/usr/share/pixmaps"
  sudo cp -dr --no-preserve='ownership' bin jbr lib plugins "${STOWDIR}/${name}/usr/share/pycharm/"
  sudo cp -dr --no-preserve='ownership' license "${STOWDIR}/${name}/usr/share/licenses/pycharm/"
  sudo cp -dr "${STOWDIR}/${name}/usr/share/pycharm/bin/pycharm.png" "${STOWDIR}/${name}/usr/share/pixmaps/"
  if ! command -v pycharm >/dev/null; then #pycharm is already symlinked
    sudo ln -s "/usr/share/pycharm/bin/pycharm.sh" "/usr/bin/pycharm"
  fi
  sudo install -Dm 644 pycharm.desktop -t "${STOWDIR}/${name}"/usr/share/applications/
}

removescript() {
  sudo rm -f /usr/bin/pycharm
}
