From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 12 Jun 2017 13:39:50 +0000
Message-ID: <DB6PR0701MB2456F9C5D3B3A89285CC99F4B5CD0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <5da37596d984e6be5c74ed5102688c0a@tiscali.it>
In-Reply-To: <5da37596d984e6be5c74ed5102688c0a@tiscali.it>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai-3 installation problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "raffaelemariotti@tiscali.it" <raffaelemariotti@tiscali.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Not sure if this helps, but I have Xenomai 3.0.5 running on the BeagleBone =
Black.

We build the image (kernel + rootfs) using this script github.com/BelaPlatf=
orm/bela-image-builder/, in particular the defconfig file for the kernel is=
 https://github.com/BelaPlatform/bela-image-builder/blob/master/kernel/bela=
_defconfig=20
and the xenomai userspace li is built like this https://github.com/BelaPlat=
form/bela-image-builder/blob/master/scripts/build_xenomai.sh and then insta=
lled via chroot. Alternatively you can build it on the board in less than 1=
5minutes:
```
xenomai_root=3D/root/xenomai-3
build_root=3D/root/xenomai-3-no-smp
build_root_smp=3D/root/xenomai-3-smp
LDFLAGS=3D"-no-pie -fno-pie -march=3Darmv7-a -mfpu=3Dvfp3"
CFLAGS=3D"-no-pie -fno-pie -march=3Darmv7-a -mfpu=3Dvfp3"

mkdir -p $build_root
cd $build_root
$xenomai_root/configure --with-core=3Dcobalt --enable-pshared --host=3Darm-=
linux-gnueabihf --build=3Darm CFLAGS=3D"$CFLAGS" LDFLAGS=3D"$LDFLAGS"
make install
```

Here is what I get on my board on boot (and this has nothing to do with the=
 userspace library, it is kernel stuff only):
sudo dmesg | grep -i xenomai
[    0.000000] Linux version 4.4.68-ti-xenomai-r106 (root@giulio-VirtualBox=
) (gcc version 5.4.1 20170404 (Linaro GCC 5.4-2017.05) ) #1 Thu Jun 1 02:45=
:44 BST 2017
[    1.599916] [Xenomai] scheduling class idle registered.
[    1.599928] [Xenomai] scheduling class rt registered.
[    1.600075] I-pipe: head domain Xenomai registered.
[    1.608034] [Xenomai] Cobalt v3.0.5 (Sisyphus's Boulder)
[    1.719447] usb usb1: Manufacturer: Linux 4.4.68-ti-xenomai-r106 musb-hc=
d

Hope this helps
Giulio

