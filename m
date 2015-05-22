Date: Fri, 22 May 2015 18:59:17 +0200
From: Marc =?UTF-8?B?TWFyw60=?= <5.markmb.5@gmail.com>
Message-ID: <20150522185917.66944cf1@crunchbang>
In-Reply-To: <20150521212732.GR10686@hermes.click-hack.org>
References: <20150521221811.1cc69dcd@crunchbang>
 <20150521204856.GV6169@csclub.uwaterloo.ca>
 <20150521212732.GR10686@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

El Thu, 21 May 2015 23:27:32 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> escribi=C3=B3:
> On Thu, May 21, 2015 at 04:48:56PM -0400, Lennart Sorensen wrote:
> > On Thu, May 21, 2015 at 10:18:11PM +0200, Marc Mar=C3=AD wrote:
> > > Hello
> > >=20
> > > I'm trying to put Xenomai 2.6.4 on top of a Raspberry Pi model B
> > > with kernel version 3.8.13. In theory, it should be
> > > straightforward, but I don't get it to compile, and I don't know
> > > if I'm missing something vital or something is broken.
> > >=20
> > > This is what I executed:
> > >=20
> > > $ git clone git@github.com:raspberrypi/linux.git
> > > $ mv linux rpi-xenomai
> > > $ git checkout rpi-3.8.y
> > > $ patch -p1 -i \
> > > ../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-ra=
spberry-pre-2.patch
> > > $ ../xenomai-2.6.4/scripts/prepare-kernel.sh --arch=3Darm
> > > --linux=3D./ \
> > > --adeos=3D../xenomai-2.6.4/ksrc/arch/arm/patches/ipipe-core-3.8.13-ar=
m-4.patch
> > > $ patch -p1 -i
> > > \ ../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-=
raspberry-post-2.patch
> > > $ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf-
> > > bcmrpi_defconfig $ make ARCH=3Darm
> > > CROSS_COMPILE=3Darm-linux-gnueabihf-
> > >=20
> > > I get this output:
> > >=20
> > > kernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_read=E2=
=80=99:
> > > kernel/ipipe/core.c:1748:2: error: implicit declaration of
> > > function =E2=80=98get_fs=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
> > >   mm_segment_t old_fs =3D get_fs();
> > >   ^
> > > kernel/ipipe/core.c:1750:2: error: implicit declaration of
> > > function =E2=80=98set_fs=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
> > >   set_fs(KERNEL_DS);
> > >   ^
> > > kernel/ipipe/core.c:1750:9: error: =E2=80=98KERNEL_DS=E2=80=99 undecl=
ared (first
> > > use in this function)
> > >   set_fs(KERNEL_DS);
> > >          ^
> > > kernel/ipipe/core.c:1750:9: note: each undeclared identifier is
> > > reported only once for each function it appears in
> > > kernel/ipipe/core.c:1753:2: error: implicit declaration of
> > > function
> > > =E2=80=98__copy_from_user_inatomic=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
> > > ret =3D __copy_from_user_inatomic(dst, ^
> > > kernel/ipipe/core.c: In function =E2=80=98ipipe_probe_kernel_write=E2=
=80=99:
> > > kernel/ipipe/core.c:1767:9: error: =E2=80=98KERNEL_DS=E2=80=99 undecl=
ared (first
> > > use in this function)
> > >   set_fs(KERNEL_DS);
> > >          ^
> > > kernel/ipipe/core.c:1770:2: error: implicit declaration of
> > > function
> > > =E2=80=98__copy_to_user_inatomic=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
> > > ret =3D __copy_to_user_inatomic((__force void __user *)dst, src,
> > > size); ^ cc1: some warnings being treated as errors
> > > scripts/Makefile.build:307: recipe for target
> > > 'kernel/ipipe/core.o' failed
> > > make[2]: *** [kernel/ipipe/core.o] Error 1
> > > scripts/Makefile.build:454: recipe for target 'kernel/ipipe'
> > > failed make[1]: *** [kernel/ipipe] Error 2
> > > Makefile:791: recipe for target 'kernel' failed
> > > make: *** [kernel] Error 2
> > >=20
> > >=20
> > > I tried by including asm/uaccess.h, which solved the issue. But
> > > the kernel doesn't boot, and there is no message. It just hangs.
> > >=20
> > > I tried the same kernel without Xenomai patch, and it compiles and
> > > boots without problem.
> >=20
> > Did you enable IPIPE in the config?  After all bcmrpi_defconfig
> > probably does NOT include IPIPE config, and most releases of ipipe
> > don't compile if you disable IPIPE support.  I have only ever seen
> > recent versions actually be able to compile with CONFIG_IPIPE=3Dn.
>=20
> That statement is simply not true. Most I-pipe patched kernel
> compile with IPIPE off, but you happened to find one that did not.
> Please stop spreading this misconception.
>=20

Thanks. I had to disable a few config options, including the DWC OTG
driver in order to boot. It now works.

Thanks
Marc

