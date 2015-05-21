Date: Thu, 21 May 2015 22:18:11 +0200
From: Marc =?UTF-8?B?TWFyw60=?= <5.markmb.5@gmail.com>
Message-ID: <20150521221811.1cc69dcd@crunchbang>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Raspberry Pi + Xenomai doesn't compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I'm trying to put Xenomai 2.6.4 on top of a Raspberry Pi model B with
kernel version 3.8.13. In theory, it should be straightforward, but I
don't get it to compile, and I don't know if I'm missing something
vital or something is broken.

This is what I executed:

$ git clone git@github.com:raspberrypi/linux.git
$ mv linux rpi-xenomai
$ git checkout rpi-3.8.y
$ patch -p1 -i \
../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberr=
y-pre-2.patch
$ ../xenomai-2.6.4/scripts/prepare-kernel.sh --arch=3Darm --linux=3D./ \
--adeos=3D../xenomai-2.6.4/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-4.pa=
tch
$ patch -p1 -i \
../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberr=
y-post-2.patch
$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcmrpi_defconfig
$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf-

I get this output:

kernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_read=E2=80=99:
kernel/ipipe/core.c:1748:2: error: implicit declaration of function
=E2=80=98get_fs=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  mm_segment_t old_fs =3D get_fs();
  ^
kernel/ipipe/core.c:1750:2: error: implicit declaration of function
=E2=80=98set_fs=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  set_fs(KERNEL_DS);
  ^
kernel/ipipe/core.c:1750:9: error: =E2=80=98KERNEL_DS=E2=80=99 undeclared (=
first use in
this function)
  set_fs(KERNEL_DS);
         ^
kernel/ipipe/core.c:1750:9: note: each undeclared identifier is
reported only once for each function it appears in
kernel/ipipe/core.c:1753:2: error: implicit declaration of function
=E2=80=98__copy_from_user_inatomic=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
  ret =3D __copy_from_user_inatomic(dst,
  ^
kernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_write=E2=80=99:
kernel/ipipe/core.c:1767:9: error: =E2=80=98KERNEL_DS=E2=80=99 undeclared (=
first use in
this function)
  set_fs(KERNEL_DS);
         ^
kernel/ipipe/core.c:1770:2: error: implicit declaration of function
=E2=80=98__copy_to_user_inatomic=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
  ret =3D __copy_to_user_inatomic((__force void __user *)dst, src, size);
  ^
cc1: some warnings being treated as errors
scripts/Makefile.build:307: recipe for target 'kernel/ipipe/core.o'
failed
make[2]: *** [kernel/ipipe/core.o] Error 1
scripts/Makefile.build:454: recipe for target 'kernel/ipipe' failed
make[1]: *** [kernel/ipipe] Error 2
Makefile:791: recipe for target 'kernel' failed
make: *** [kernel] Error 2


I tried by including asm/uaccess.h, which solved the issue. But the
kernel doesn't boot, and there is no message. It just hangs.

I tried the same kernel without Xenomai patch, and it compiles and
boots without problem.

Thanks in advance
Marc

