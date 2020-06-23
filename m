From: "Kristiansen, Morten (INT)" <Morten.Kristiansen@Teledyne.com>
Subject: Migrating code, rt_dev_*() API missing
Date: Tue, 23 Jun 2020 14:04:56 +0000
Message-ID: <DB7PR04MB41555084C23F8CE5E85C5771F3940@DB7PR04MB4155.eurprd04.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm in the process of migrating from Xenomai 2.x to 3.1. Our application wa=
s using rt_dev_* to access an SPI port. According to the migration guide th=
is class of functions seems to be removed and replaced by the rtdm_* equiva=
lent. However, these functions doesn't seem to exist anywhere in the header=
s or libraries installed when building.

Should user space applications use rtdm_* (rtdm_open, rtdm_write) or should=
 they use the native (open, write)

For reference, this is how I built Xenomai:
1.     wget https://xenomai.org/downloads/xenomai/stable/xenomai-3.1.tar.bz=
2
2.     tar -jxf xenomai-3.1.tar.bz2<https://xenomai.org/downloads/xenomai/s=
table/xenomai-3.1.tar.bz2>
3.     mkdir build
4.     cd build
5.     ../xenomai-3.1/configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" LD=
FLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" --build=3Di686-pc-linux-gnu --host=
=3Darm-linux-gnueabihf --with-core=3Dcobalt --enable-smp
6.     make
7.     mkdir ../xenomai-arm-install
8.     make DESTDIR=3D../xenomai-arm-install install

