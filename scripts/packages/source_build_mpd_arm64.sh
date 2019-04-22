#!/bin/bash
set -x
set -e


# Upmpdcli
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/libupnp-dev_1.6.20.jfd5-1~ppa1~stretch_all.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/libupnp6-dev_1.6.20.jfd5-1~ppa1~stretch_arm64.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/libupnp6_1.6.20.jfd5-1~ppa1~stretch_arm64.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/libupnpp5-dev_0.17.1-1~ppa1~stretch_arm64.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/libupnpp5_0.17.1-1~ppa1~stretch_arm64.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/scweb_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/upmpdcli-gmusic_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/upmpdcli-qobuz_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/upmpdcli-tidal_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://45.248.132.27:443/Volumio2/Binaries/upmpdcli/armv8/upmpdcli_1.4.2-1~ppa1~stretch_arm64.deb'

apt install -y  python3-requests python3-urllib3

sudo dpkg -i \
 'libupnp-dev_1.6.20.jfd5-1~ppa1~stretch_all.deb' \
 'libupnp6-dev_1.6.20.jfd5-1~ppa1~stretch_arm64.deb' \
 'libupnp6_1.6.20.jfd5-1~ppa1~stretch_arm64.deb'
sudo dpkg -i \
  'libupnpp5-dev_0.17.1-1~ppa1~stretch_arm64.deb' \
  'libupnpp5_0.17.1-1~ppa1~stretch_arm64.deb'
sudo dpkg -i \
  'upmpdcli_1.4.2-1~ppa1~stretch_arm64.deb' \
  'scweb_1.4.2-1~ppa1~stretch_all.deb'
sudo dpkg -i \
  'upmpdcli-gmusic_1.4.2-1~ppa1~stretch_all.deb' \
  'upmpdcli-qobuz_1.4.2-1~ppa1~stretch_all.deb' \
  'upmpdcli-tidal_1.4.2-1~ppa1~stretch_all.deb'

apt --fix-broken install -y

rm -fv 'libupnp-dev_1.6.20.jfd5-1~ppa1~stretch_all.deb' \
'libupnp6-dev_1.6.20.jfd5-1~ppa1~stretch_arm64.deb' \
'libupnp6_1.6.20.jfd5-1~ppa1~stretch_arm64.deb' \
'libupnpp5-dev_0.17.1-1~ppa1~stretch_arm64.deb' \
'libupnpp5_0.17.1-1~ppa1~stretch_arm64.deb' \
'scweb_1.4.2-1~ppa1~stretch_all.deb' \
'upmpdcli-gmusic_1.4.2-1~ppa1~stretch_all.deb' \
'upmpdcli-qobuz_1.4.2-1~ppa1~stretch_all.deb' \
'upmpdcli-tidal_1.4.2-1~ppa1~stretch_all.deb' \
'upmpdcli_1.4.2-1~ppa1~stretch_arm64.deb'




# MPD ...
sudo apt-get install -y python3-pip
cat <<EOF> /etc/pip.conf
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF
sudo pip3 install meson

sudo apt-get -y purge triggerhappy

sudo apt-get -y install build-essential automake cmake git ninja-build python3-setuptools autoconf libtool \
sysstat ntfs-3g exfat-fuse inotify-tools libav-tools avahi-utils \
libdaemon-dev telnet libpopt-dev libconfig-dev

sudo apt-get -y install libasound2-dev libmad0-dev libmpg123-dev libid3tag0-dev \
  libflac-dev libvorbis-dev libfaad-dev \
  libwavpack-dev \
  libavcodec-dev libavformat-dev \
  libmp3lame-dev \
  libsoxr-dev \
  libcdio-paranoia-dev \
  libcurl4-gnutls-dev \
  libyajl-dev \
  libavahi-client-dev \
  libsystemd-dev \
  libwrap0-dev \
  libboost-dev \
  libicu-dev \
  libglib2.0-dev

## libmpdclient
wget -c https://www.musicpd.org/download/libmpdclient/2/libmpdclient-2.16.tar.xz
tar xf libmpdclient-2.16.tar.xz
pushd libmpdclient-2.16
  CXXFLAGS=" -O3" meson --buildtype=release -Db_ndebug=true --prefix=/usr  . output/release
  ninja -C output/release
  ninja -C output/release install
popd
rm -rf libmpdclient-2.16*

## mpc
wget -c https://www.musicpd.org/download/mpc/0/mpc-0.31.tar.xz
tar xf mpc-0.31.tar.xz
pushd mpc-0.31
  CXXFLAGS=" -O3" meson --buildtype=release -Db_ndebug=true --prefix=/usr  . output/release
  ninja -C output/release
  ninja -C output/release install
popd
rm -rf mpc-0.31*

## mpd
wget http://www.musicpd.org/download/mpd/0.21/mpd-0.21.7.tar.xz
tar xf mpd-0.21.7.tar.xz
pushd mpd-0.21.7
CXXFLAGS=" -O3" meson --buildtype=release -Db_ndebug=true . output/release
# meson configure output/release
meson configure \
-Dalsa=enabled \
-Dcurl=enabled \
-Ddatabase=true \
-Ddsd=true \
-Dffmpeg=enabled \
-Dfaad=enabled \
-Dflac=enabled \
-Did3tag=enabled \
-Dlame=enabled \
-Dlibmpdclient=enabled \
-Dmad=enabled \
-Dmpg123=enabled \
-Dpipe=true \
-Drecorder=false \
-Dshout=disabled \
-Dsoundcloud=enabled \
-Dsoxr=enabled \
-Dvorbis=enabled \
-Dwave_encoder=true \
-Dwavpack=enabled \
-Dzeroconf=avahi \
-Dao=disabled \
-Daudiofile=disabled \
-Dbzip2=disabled \
-Dfluidsynth=disabled \
-Dgme=disabled \
-Djack=disabled \
-Dlibsamplerate=disabled \
-Dnfs=disabled \
-Doss=disabled \
-Dpulse=disabled \
-Dsidplay=disabled \
-Dsmbclient=disabled \
-Dsndfile=disabled \
-Dsqlite=disabled \
-Dupnp=disabled \
-Dwildmidi=disabled \
-Dzzip=disabled \
output/release

ninja -C output/release
ninja -C output/release install
# install -sv output/release/mpd /usr/local/bin/mpd
popd
rm -rf mpd-0.21.7*

# add the mpd user
if ! getent passwd mpd >/dev/null; then
    adduser --quiet --ingroup audio --system --no-create-home \
        --home /var/lib/mpd mpd
fi

# set ownership and permissions on directories
for i in /var/log/mpd /var/lib/mpd /var/lib/mpd/playlists; do
    if ! test -e "$i"; then
      mkdir -pv --mode 0755 "$i"
      chown mpd:audio "$i"
    fi
done

# Automatically added by dh_installinit
# In case this system is running systemd, we need to ensure that all
# necessary tmpfiles (if any) are created before starting.
if [ -d /run/systemd/system ] ; then
	systemd-tmpfiles --create /usr/lib/tmpfiles.d/mpd.conf >/dev/null || true
fi







# Cleanup
sudo apt-get clean
# sudo apt-get -y purge build-essential automake cmake git ninja-build python3-setuptools autoconf libtool
apt-get -y purge build-essential automake cmake git ninja-build cpp cpp-6 fakeroot python3-setuptools autoconf libtool libdaemon-dev libpopt-dev libconfig-dev  python3-dev libpython3.5-dev python3.5-dev dpkg-dev libboost-dev libgcc-6-dev libicu-dev libpython3-dev libstdc++-6-dev libsystemd-dev manpages-dev
sudo apt-get -y autoremove
