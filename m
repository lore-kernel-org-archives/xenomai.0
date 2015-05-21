Date: Thu, 21 May 2015 22:53:51 +0200
From: Marc =?UTF-8?B?TWFyw60=?= <5.markmb.5@gmail.com>
Message-ID: <20150521225351.712910c6@crunchbang>
In-Reply-To: <20150521204856.GV6169@csclub.uwaterloo.ca>
References: <20150521221811.1cc69dcd@crunchbang>
 <20150521204856.GV6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Raspberry Pi + Xenomai doesn't compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

El Thu, 21 May 2015 16:48:56 -0400
"Lennart Sorensen" <lsorense@csclub.uwaterloo.ca> escribi=C3=B3:
> On Thu, May 21, 2015 at 10:18:11PM +0200, Marc Mar=C3=AD wrote:
> > Hello
> >=20
> > I'm trying to put Xenomai 2.6.4 on top of a Raspberry Pi model B
> > with kernel version 3.8.13. In theory, it should be
> > straightforward, but I don't get it to compile, and I don't know if
> > I'm missing something vital or something is broken.
> >=20
> > This is what I executed:
> >=20
> > $ git clone git@github.com:raspberrypi/linux.git
> > $ mv linux rpi-xenomai
> > $ git checkout rpi-3.8.y
> > $ patch -p1 -i \
> > ../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-rasp=
berry-pre-2.patch
> > $ ../xenomai-2.6.4/scripts/prepare-kernel.sh --arch=3Darm --linux=3D./ \
> > --adeos=3D../xenomai-2.6.4/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-=
4.patch
> > $ patch -p1 -i \
> > ../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-rasp=
berry-post-2.patch
> > $ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcmrpi_defconfig
> > $ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf-
> >=20
> > I get this output:
> >=20
> > kernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_read=E2=80=
=99:
> > kernel/ipipe/core.c:1748:2: error: implicit declaration of function
> > =E2=80=98get_fs=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> >   mm_segment_t old_fs =3D get_fs();
> >   ^
> > kernel/ipipe/core.c:1750:2: error: implicit declaration of function
> > =E2=80=98set_fs=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> >   set_fs(KERNEL_DS);
> >   ^
> > kernel/ipipe/core.c:1750:9: error: =E2=80=98KERNEL_DS=E2=80=99 undeclar=
ed (first
> > use in this function)
> >   set_fs(KERNEL_DS);
> >          ^
> > kernel/ipipe/core.c:1750:9: note: each undeclared identifier is
> > reported only once for each function it appears in
> > kernel/ipipe/core.c:1753:2: error: implicit declaration of function
> > =E2=80=98__copy_from_user_inatomic=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
> >   ret =3D __copy_from_user_inatomic(dst,
> >   ^
> > kernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_write=E2=
=80=99:
> > kernel/ipipe/core.c:1767:9: error: =E2=80=98KERNEL_DS=E2=80=99 undeclar=
ed (first
> > use in this function)
> >   set_fs(KERNEL_DS);
> >          ^
> > kernel/ipipe/core.c:1770:2: error: implicit declaration of function
> > =E2=80=98__copy_to_user_inatomic=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> >   ret =3D __copy_to_user_inatomic((__force void __user *)dst, src,
> > size); ^
> > cc1: some warnings being treated as errors
> > scripts/Makefile.build:307: recipe for target 'kernel/ipipe/core.o'
> > failed
> > make[2]: *** [kernel/ipipe/core.o] Error 1
> > scripts/Makefile.build:454: recipe for target 'kernel/ipipe' failed
> > make[1]: *** [kernel/ipipe] Error 2
> > Makefile:791: recipe for target 'kernel' failed
> > make: *** [kernel] Error 2
> >=20
> >=20
> > I tried by including asm/uaccess.h, which solved the issue. But the
> > kernel doesn't boot, and there is no message. It just hangs.
> >=20
> > I tried the same kernel without Xenomai patch, and it compiles and
> > boots without problem.
>=20
> Did you enable IPIPE in the config?  After all bcmrpi_defconfig
> probably does NOT include IPIPE config, and most releases of ipipe
> don't compile if you disable IPIPE support.  I have only ever seen
> recent versions actually be able to compile with CONFIG_IPIPE=3Dn.
>=20

Enabled by default:

$ grep -r IPIPE .config
CONFIG_IPIPE_WANT_ACTIVE_MM=3Dy
CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=3Dy
CONFIG_IPIPE_ARM_KUSER_TSC=3Dy
CONFIG_IPIPE=3Dy
CONFIG_IPIPE_LEGACY=3Dy
CONFIG_IPIPE_CORE=3Dy
CONFIG_IPIPE_CORE_APIREV=3D2
CONFIG_IPIPE_WANT_APIREV_2=3Dy
CONFIG_IPIPE_TARGET_APIREV=3D2
CONFIG_IPIPE_HAVE_HOSTRT=3Dy
CONFIG_IPIPE_DELAYED_ATOMICSW=3Dy
# CONFIG_IPIPE_DEBUG is not set

$ grep -r XENOMAI .config
CONFIG_XENOMAI=3Dy

