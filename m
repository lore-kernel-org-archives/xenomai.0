Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 May 2011 12:23:17 +0200
Message-ID: <89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>
In-Reply-To: <4DCD2EE8.2010904@domain.hid>
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>
	<4DCD2EE8.2010904@domain.hid>
From: "Koenig, Florian" <F.Koenig@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Hi,

i installed eldk into /opt/eldk-4.2, then i installed (make install) =
xenomai
user-space into /opt/eldk-4.2/ppc_4xx .

Now when i try to build the xenomai examples with

$ make XENO=3D/opt/eldk-4.2/usr/xenomai-2.5.6/bin

It uses /lib/modules/2.6.32-5-686 from the local kernel, so i used

$ make XENO=3D/opt/eldk-4.2/usr/xenomai-2.5.6/bin =
KSRC=3D/usr/src/linux-2.6.36

But then it returns:
make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/native'
powerpc-linux-gcc -I/usr/xenomai-2.5.6/include -D_GNU_SOURCE =
-D_REENTRANT
-Wall -pipe -D__XENO__   -L/usr/xenomai-2.5.6/lib -lxenomai -lpthread
-lnative -Xlinker -rpath -Xlinker /usr/xenomai-2.5.6/lib  =
trivial-periodic.c
-o trivial-periodic
trivial-periodic.c: In function 'main':
trivial-periodic.c:72: warning: control reaches end of non-void function

When i now use trivial-periodic on the 405GP cpu, it also returns: =
illegal
instruction

When i try to build the hello_world app with your command it returns:

powerpc-linux-gcc -o test test.c
'XENO=3D/opt/eldk-4.2/ppc_4xx/usr/xenomai-2.5.6/bin/xeno-config --skin =
native
--cflags --ldflags' -lrtdk
powerpc-linux-gcc:
XENO=3D/opt/eldk-4.2/ppc_4xx/usr/xenomai-2.5.6/bin/xeno-config --skin =
native
--cflags --ldflags: No such file or directory

Why is xenomai using local /lib/modules/2.6.32-5-686 directory ? what do =
i
wrong with xenomai userspace part ?


Thanks for help
Florian





> This builds without any errors. Now i simply try to build the =
hello_world
> example from =
http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html
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

> The build of the test app is without any errors, but when i run it on =
the
> 405GP cpu (which has no FPU) it returns: ILLEGAL INSTRUCTION. If i =
look at
> /proc/xenomai/faults there are only zero=B4s.
>=20
> I know i need soft-float for this cpu, but i think a got everything
correctly
> setup/build, or?

See above.

> After reading and doing, i found in the xenomai directory a file =
called
> scripts/defconfig.frag, where the last line is:
>=20
> CONFIG_XENO_HW_FPU=3Dy
>=20
> Now i dont know, what the file defconfig.frag is for, and why is there
> hardware fpu set to yes?

I think you can switch that option off.

Wolfgang.

-------------------------------------------------------------------------=
---------------------------------------------------
Omicron NanoTechnology GmbH
Limburger Str. 75
65232 Taunusstein, GERMANY=20
Registration: HRB Nr.: 16116, Amtsgericht Wiesbaden, VAT no. DE111361420
Gesch=E4ftsf=FChrer / Managing Director: Norbert Nold               =
www.omicron.de=20


