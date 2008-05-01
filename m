MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18457.59929.12465.572294@domain.hid>
Date: Thu, 1 May 2008 18:04:41 +0200
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
References: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
	<2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
	<2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai on AT91SAM9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hans S=F8ndergaard (HSO) wrote:
 > Hi,
 >=20
 > Thanks for the answer.
 > We are now trying to install Xenomai 2.4.3 using Linux 2.6.24 on AT91SAM=
9260,
 > but have a problem:
 >=20
 > Is it possible to disable the building of the posix skin when
 > configuring the user space libraries for Xenomai?
 >=20
 > I have tried --disable-posix-skin, but this had no effect.
 >=20
 > The reason why I ask is that the building of src/skins/posix/init.c
 > fails like this:
 >=20
 > [stk@domain.hid posix]$ arm-linux-uclibc-gcc -DHAVE_CONFIG_H -I. -I../..=
/../src/inc
 > lude -I../../../../xenomai-2.4.3/src/skins/posix -O2 -D_GNU_SOURCE -D_RE=
ENTRANT
 > -Wall -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes =
-I../../..
 > /../xenomai-2.4.3/include -I../../../../xenomai-2.4.3/include/posix -MT =
libpthre
 > ad_rt_la-init.lo -MD -MP -MF .deps/libpthread_rt_la-init.Tpo -c ../../..=
/../xeno
 > mai-2.4.3/src/skins/posix/init.c  -fPIC -DPIC -o .libs/libpthread_rt_la-=
init.o
 > In file included from ../../../src/include/asm/xenomai/atomic.h:78,
 >                  from ../../../../xenomai-2.4.3/include/nucleus/system.h=
:27,
 >                  from ../../../src/include/asm/xenomai/system.h:135,
 >                  from ../../../../xenomai-2.4.3/include/nucleus/types.h:=
40,
 >                  from ../../../../xenomai-2.4.3/include/nucleus/queue.h:=
25,
 >                  from ../../../../xenomai-2.4.3/include/nucleus/timebase=
.h:30,
 >                  from ../../../../xenomai-2.4.3/include/nucleus/timer.h:=
27,
 >                  from ../../../../xenomai-2.4.3/include/nucleus/thread.h=
:26,
 >                  from ../../../../xenomai-2.4.3/include/posix/pthread.h:=
150,
 >                  from /home/stk/brick/mb9200/buildroot/build_arm/staging=
_dir/bin
 > -ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc/s=
ys-inclu
 > de/bits/uClibc_mutex.h:16,
 >                  from /home/stk/brick/mb9200/buildroot/build_arm/staging=
_dir/bin
 > -ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc/s=
ys-inclu
 > de/bits/uClibc_stdio.h:120,
 >                  from /home/stk/brick/mb9200/buildroot/build_arm/staging=
_dir/bin
 > -ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc/s=
ys-inclu
 > de/stdio.h:73,
 >                  from ../../../../xenomai-2.4.3/src/skins/posix/init.c:2=
0:
 > ../../../src/include/asm/xenomai/syscall.h: In function 'xeno_arm_featur=
es_check
 > ':
 > ../../../src/include/asm/xenomai/syscall.h:295: error: 'stderr' undeclar=
ed (firs
 > t use in this function)
 > ../../../src/include/asm/xenomai/syscall.h:295: error: (Each undeclared =
identifi
 > er is reported only once
 > ../../../src/include/asm/xenomai/syscall.h:295: error: for each function=
 it appe
 > ars in.)
 >=20
 > Obviously there is something wrong with the include path used:
 > uClibc_mutex.h should not include 'pthread.h' in the Xenomai
 > distribution but rather the version in uClibc itself.
 >=20
 > Why this happens I'm trying to discover.
 >=20
 > The complete configure I'm using is:
 >=20
 > ../xenomai-2.4.3/configure --build=3Di686-pc-linux-gnu --host=3Darm-linu=
x-uclibc --enable-arm-mach=3Dat91sam926x --enable-arm-tsc
 >=20
 > Thanks in advance.

Well, I understand that it may not be important to you if you do not
intend to use the posix skin, but we should try and solve this issue
(which seems to be a uclibc issue). Including posix skin pthread.h
instead of libc pthread.h should be no problem, since posix skin
pthread.h include the libc pthread.h. The problem here is due to the
fact that asm-arm/syscall.h is trying to use stderr whereas we are at
the very beginning of stdio.h where stderr is not defined yet.

I have to admit that I have no idea here other than defining a function
in init.c which calls fprintf and to call this function instead of
fprintf in asm-arm/syscall.h

Philippe, any better idea ?

--=20


					    Gilles.

