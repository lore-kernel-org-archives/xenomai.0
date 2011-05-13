Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 May 2011 14:46:59 +0200
Message-ID: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>
From: "Koenig, Florian" <F.Koenig@domain.hid>
Subject: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
i have a powerpc 405GP without FPU and want to build a xenomai =
application. I
installed and setup eldk-4.2 for ppc_4xx,  to have a cross toolchain on =
my
x86 computer. After that, i patched the linux-2.6.36 kernel with

scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.36/
--adeos=3Dksrc/arch/powerpc/patches/adeos-ipipe-2.6.36-powerpc-2.12-03.pa=
tch

Then i configured and build the kernel. I tested the kernel on the cpu, =
and
it runs well.
Now i switched into the xenomai directory and to build the user-space
support, i called:

./configure --host=3Dppc-linux =
CFLAGS=3D"-msoft-float"=A0LDFLAGS=3D"-msoft-float"
;make;make install

This builds without any errors. Now i simply try to build the =
hello_world
example from =
http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html
with:

powerpc-linux-gcc -msoft-float -L/usr/xenomai/lib -lnative -lxenomai
-lpthread_rt -lrtdk -I/usr/xenomai/include -o test test.c

The build of the test app is without any errors, but when i run it on =
the
405GP cpu (which has no FPU) it returns: ILLEGAL INSTRUCTION. If i look =
at
/proc/xenomai/faults there are only zero=B4s.

I know i need soft-float for this cpu, but i think a got everything =
correctly
setup/build, or?

After reading and doing, i found in the xenomai directory a file called
scripts/defconfig.frag, where the last line is:

CONFIG_XENO_HW_FPU=3Dy

Now i dont know, what the file defconfig.frag is for, and why is there
hardware fpu set to yes?

Thanks for help

florian


-------------------------------------------------------------------------=
---------------------------------------------------
Omicron NanoTechnology GmbH
Limburger Str. 75
65232 Taunusstein, GERMANY=20
Registration: HRB Nr.: 16116, Amtsgericht Wiesbaden, VAT no. DE111361420
Gesch=E4ftsf=FChrer / Managing Director: Norbert Nold               =
www.omicron.de=20


