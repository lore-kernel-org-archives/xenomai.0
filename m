Message-ID: <4DCD2EE8.2010904@domain.hid>
Date: Fri, 13 May 2011 15:15:20 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>
In-Reply-To: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Koenig, Florian" <F.Koenig@domain.hid>
Cc: xenomai@xenomai.org

On 05/13/2011 02:46 PM, Koenig, Florian wrote:
> Hi,
> i have a powerpc 405GP without FPU and want to build a xenomai applicat=
ion. I
> installed and setup eldk-4.2 for ppc_4xx,  to have a cross toolchain on=
 my
> x86 computer. After that, i patched the linux-2.6.36 kernel with
>=20
> scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.36/
> --adeos=3Dksrc/arch/powerpc/patches/adeos-ipipe-2.6.36-powerpc-2.12-03.=
patch
>=20
> Then i configured and build the kernel. I tested the kernel on the cpu,=
 and
> it runs well.
> Now i switched into the xenomai directory and to build the user-space
> support, i called:
>=20
> ./configure --host=3Dppc-linux CFLAGS=3D"-msoft-float" LDFLAGS=3D"-msof=
t-float"
> ;make;make install

Please just use:

 $ ./configure --host=3Dpowerpc-linux --prefix=3D/usr/xenomai-2.5

The toolchain knows that it has to use -msoft-float. Next you need to
build and *install* the user-space libs, tools, etc.:

  $ make
  $ export DESTDIR=3D/opt/eldk-4.2/ppc_4xx
  $ make install

> This builds without any errors. Now i simply try to build the hello_wor=
ld
> example from http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.=
html
> with:
>=20
> powerpc-linux-gcc -msoft-float -L/usr/xenomai/lib -lnative -lxenomai
> -lpthread_rt -lrtdk -I/usr/xenomai/include -o test test.c

Then you should be able to compile that program with

  $ ${CROSS_COMPILE}gcc -o test test.c
`$DESTDIR//usr/xenomai-2.5/bin/xeno-config --skin native --cflags
--ldflags` -lrtdk

Can't tell if that example is OK, though. The one coming with the
Xenomai tree in "examples" are known to work.

> The build of the test app is without any errors, but when i run it on t=
he
> 405GP cpu (which has no FPU) it returns: ILLEGAL INSTRUCTION. If i look=
 at
> /proc/xenomai/faults there are only zero=B4s.
>=20
> I know i need soft-float for this cpu, but i think a got everything cor=
rectly
> setup/build, or?

See above.

> After reading and doing, i found in the xenomai directory a file called
> scripts/defconfig.frag, where the last line is:
>=20
> CONFIG_XENO_HW_FPU=3Dy
>=20
> Now i dont know, what the file defconfig.frag is for, and why is there
> hardware fpu set to yes?

I think you can switch that option off.

Wolfgang.

