#!/bin/bash
set -x
# set -e

# Upmpdcli
wget -c 'http://congxin.org:8360/debuild/packages/libupnp-dev_1.6.20.jfd5-1~ppa1~stretch_all.deb'
wget -c 'http://congxin.org:8360/debuild/packages/libupnp6-dev_1.6.20.jfd5-1~ppa1~stretch_arm64.deb'
wget -c 'http://congxin.org:8360/debuild/packages/libupnp6_1.6.20.jfd5-1~ppa1~stretch_arm64.deb'
wget -c 'http://congxin.org:8360/debuild/packages/libupnpp5-dev_0.17.1-1~ppa1~stretch_arm64.deb'
wget -c 'http://congxin.org:8360/debuild/packages/libupnpp5_0.17.1-1~ppa1~stretch_arm64.deb'
wget -c 'http://congxin.org:8360/debuild/packages/scweb_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://congxin.org:8360/debuild/packages/upmpdcli-gmusic_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://congxin.org:8360/debuild/packages/upmpdcli-qobuz_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://congxin.org:8360/debuild/packages/upmpdcli-tidal_1.4.2-1~ppa1~stretch_all.deb'
wget -c 'http://congxin.org:8360/debuild/packages/upmpdcli_1.4.2-1~ppa1~stretch_arm64.deb'

wget -c  'http://congxin.org:8360/debuild/packages/libmpdclient-dev_2.16-1_arm64.deb'
wget -c  'http://congxin.org:8360/debuild/packages/libmpdclient2_2.16-1_arm64.deb'
wget -c  'http://congxin.org:8360/debuild/packages/mpc_0.31-1_arm64.deb'
wget -c  'http://congxin.org:8360/debuild/packages/mpd_0.21.5-sacd2_arm64.deb'


apt-get update
apt-get install -y  python3-requests python3-urllib3

dpkg -i \
 'libupnp-dev_1.6.20.jfd5-1~ppa1~stretch_all.deb' \
 'libupnp6-dev_1.6.20.jfd5-1~ppa1~stretch_arm64.deb' \
 'libupnp6_1.6.20.jfd5-1~ppa1~stretch_arm64.deb'
dpkg -i \
  'libupnpp5-dev_0.17.1-1~ppa1~stretch_arm64.deb' \
  'libupnpp5_0.17.1-1~ppa1~stretch_arm64.deb'


dpkg -i \
  'libmpdclient-dev_2.16-1_arm64.deb' \
  'libmpdclient2_2.16-1_arm64.deb' \
  'mpc_0.31-1_arm64.deb'

dpkg -i \
  'upmpdcli_1.4.2-1~ppa1~stretch_arm64.deb' \
  'scweb_1.4.2-1~ppa1~stretch_all.deb'
dpkg -i \
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


# mpd
apt-get install -y \
    libavcodec57 libavformat57 libavutil55 libcdio-cdda1 libcdio-paranoia1 \
    libcdio13 libfaad2 libgme0 libid3tag0 libmad0 libmms0 libmp3lame0 \
    libmpcdec6 libmpg123-0 libnfs8 libopus0 libsidplayfp4 libsoxr0 libwildmidi2 libyajl2

dpkg -i 'mpd_0.21.5-sacd2_arm64.deb' || true

apt --fix-broken install -y

rm -fv \
  'libmpdclient-dev_2.16-1_arm64.deb' \
  'libmpdclient2_2.16-1_arm64.deb' \
  'mpc_0.31-1_arm64.deb' \
  'mpd_0.21.5-sacd2_arm64.deb'

apt-get clean

