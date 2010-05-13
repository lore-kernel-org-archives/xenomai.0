MIME-Version: 1.0
Date: Thu, 13 May 2010 11:11:32 +0800
Message-ID: <AANLkTim0-aSjHrITyQDnXdYSOf8pUl3ya1gtLgTLd1CC@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] help needed to cross compile examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I am trying to compile xenomai examples using CodeSourcery 's cross
compiler. I have
already compiled and installed xenomai on my SD card for beagleboard.

This is what I did for compiling examples

cd ~/BB/xenomai-2.5.3/examples/rtdm/profiles/serial$
make XENO=/media/Angstrom/usr/xenomai/bin ARCH=arm
KSRC=/home/everett/BB/xenomai-2.5.3/ksrc

where /media/Angstrom/ is the root file system for my beagleboard SD
card. The make finds my cross compiler
file. But it can't find some included files:

make XENO=/media/Angstrom/usr/xenomai/bin ARCH=arm
KSRC=/home/everett/BB/xenomai-2.5.3/ksrc
--xeno-cflags is deprecated, use --skin=name --cflags instead
--xeno-ldflags is deprecated, use --skin=name --ldflags instead
arm-none-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   -L/usr/xenomai/lib -lxenomai
-lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker /usr/xenomai/lib
cross-link.c   -o cross-link
In file included from /usr/xenomai/include/nucleus/thread.h:25,
                 from /usr/xenomai/include/nucleus/sched.h:31,
                 from /usr/xenomai/include/native/task.h:25,
                 from cross-link.c:28:
/usr/xenomai/include/nucleus/types.h:40: fatal error:
asm/xenomai/system.h: No such file or directory
compilation terminated.
make: *** [cross-link] Error 1

What is the correct way to compile examples?

Thanks a lot in advance,

Everett

