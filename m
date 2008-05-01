From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Thu, 1 May 2008 07:46:04 +0200
Message-ID: <2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
References: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
	<2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
In-Reply-To: <2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Thanks for the answer.
We are now trying to install Xenomai 2.4.3 using Linux 2.6.24 on AT91SAM926=
0,
but have a problem:

Is it possible to disable the building of the posix skin when
configuring the user space libraries for Xenomai?

I have tried --disable-posix-skin, but this had no effect.

The reason why I ask is that the building of src/skins/posix/init.c
fails like this:

[stk@domain.hid posix]$ arm-linux-uclibc-gcc -DHAVE_CONFIG_H -I. -I../../../sr=
c/inc
lude -I../../../../xenomai-2.4.3/src/skins/posix -O2 -D_GNU_SOURCE -D_REENT=
RANT
-Wall -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I.=
./../..
/../xenomai-2.4.3/include -I../../../../xenomai-2.4.3/include/posix -MT lib=
pthre
ad_rt_la-init.lo -MD -MP -MF .deps/libpthread_rt_la-init.Tpo -c ../../../..=
/xeno
mai-2.4.3/src/skins/posix/init.c  -fPIC -DPIC -o .libs/libpthread_rt_la-ini=
t.o
In file included from ../../../src/include/asm/xenomai/atomic.h:78,
                 from ../../../../xenomai-2.4.3/include/nucleus/system.h:27=
,
                 from ../../../src/include/asm/xenomai/system.h:135,
                 from ../../../../xenomai-2.4.3/include/nucleus/types.h:40,
                 from ../../../../xenomai-2.4.3/include/nucleus/queue.h:25,
                 from ../../../../xenomai-2.4.3/include/nucleus/timebase.h:=
30,
                 from ../../../../xenomai-2.4.3/include/nucleus/timer.h:27,
                 from ../../../../xenomai-2.4.3/include/nucleus/thread.h:26=
,
                 from ../../../../xenomai-2.4.3/include/posix/pthread.h:150=
,
                 from /home/stk/brick/mb9200/buildroot/build_arm/staging_di=
r/bin
-ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc/sys-=
inclu
de/bits/uClibc_mutex.h:16,
                 from /home/stk/brick/mb9200/buildroot/build_arm/staging_di=
r/bin
-ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc/sys-=
inclu
de/bits/uClibc_stdio.h:120,
                 from /home/stk/brick/mb9200/buildroot/build_arm/staging_di=
r/bin
-ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc/sys-=
inclu
de/stdio.h:73,
                 from ../../../../xenomai-2.4.3/src/skins/posix/init.c:20:
../../../src/include/asm/xenomai/syscall.h: In function 'xeno_arm_features_=
check
':
../../../src/include/asm/xenomai/syscall.h:295: error: 'stderr' undeclared =
(firs
t use in this function)
../../../src/include/asm/xenomai/syscall.h:295: error: (Each undeclared ide=
ntifi
er is reported only once
../../../src/include/asm/xenomai/syscall.h:295: error: for each function it=
 appe
ars in.)

Obviously there is something wrong with the include path used:
uClibc_mutex.h should not include 'pthread.h' in the Xenomai
distribution but rather the version in uClibc itself.

Why this happens I'm trying to discover.

The complete configure I'm using is:

../xenomai-2.4.3/configure --build=3Di686-pc-linux-gnu --host=3Darm-linux-u=
clibc --enable-arm-mach=3Dat91sam926x --enable-arm-tsc

Thanks in advance.

Hans

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: 29. april 2008 14:18
To: Hans S=F8ndergaard (HSO)
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai on AT91SAM9260

On Tue, Apr 29, 2008 at 1:37 PM, Hans S=F8ndergaard (HSO) <HSO@viauc.dk> wr=
ote:
>
>
>
>
> Is it possible to install Xenomai 2.4.3 together with Linux 2.6.23 on
> AT91SAM9260?
>
> If the answer is no, which combination of Xenomai and Linux would you
> recommend?

Xenomai 2.4.3 ships with two versions of the Adeos I-pipe patch: one
for Linux 2.6.20, the other for Linux 2.6.24. So, I would recommend
using one of these two versions. Of course, you can probably adapt one
of the patches to Linux 2.6.23, but that may not be obvious.

Note that you may decide to apply the AT91 patch, the I-pipe patch
should apply cleanly with or without the AT91 patch.

--
 Gilles


