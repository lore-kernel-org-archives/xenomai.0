Message-ID: <48203.128.93.12.158.1133975357.squirrel@domain.hid>
Date: Wed, 7 Dec 2005 18:09:17 +0100 (CET)
Subject: Re: [Xenomai-help] Xenomai-PPC: One problem: data
From: <smannori@domain.hid>
In-Reply-To: <4397067A.9010206@domain.hid>
References: <38086.128.93.12.158.1133967095.squirrel@domain.hid>
	<4397067A.9010206@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Heikki :

> - compiler version,

simone@domain.hid:~$ gcc -v
Reading specs from /usr/lib/gcc/powerpc-linux-gnu/3.4.5/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,f77,pascal,objc,ada --prefix=/usr
--libexecdir=/usr/lib --with-gxx-include-dir=/usr/include/c++/3.4
--enable-shared --with-system-zlib --enable-nls --without-included-gettext
--program-suffix=-3.4 --enable-__cxa_atexit --enable-libstdcxx-allocator=mt
--enable-clocale=gnu --enable-libstdcxx-debug --disable-softfloat
--enable-targets=powerpc-linux,powerpc64-linux --with-cpu=default32
--disable-softfloat powerpc-linux-gnu
Thread model: posix
gcc version 3.4.5 20050809 (prerelease) (Ubuntu 3.4.4-6ubuntu8)
simone@domain.hid:~$

> - kernel version,

simone@domain.hid:~$ uname -a
Linux xeno 2.6.14.3-ipipe #4 PREEMPT Wed Dec 7 15:20:25 CET 2005 ppc
GNU/Linuxsimone@domain.hid:~$

> - i-pipe version,
-rw-r--r--  1 nobody nogroup 122733 2005-11-29 15:16
adeos-ipipe-2.6.14-ppc-1.0-07.patch

> - xenomai version,
 cat /proc/xenomai/version
2.1

> - environment where the bug happens (what else is running, like
> X11/glQuake...)

1) Patch the kernel : OK
2) kernel compiling : OK
3) Boot OK
4) Xenomai config, make and make install: OK
5) Without xenomai process all is OK
6) launch /usr/xenomai/testsuite/latency (run)
7) the program start OK and runs
8) after few seconds the machine become instable... then freeze :(

Disabling FPU Xenomai support the machine is perfect (I have 2:30 uptime
without a single glitch).

Unfortunately the Radeon R350 (M10) inside the Powerbook is not officially
sopported by X a/o in the the kernel. There is a project

http://r300.sourceforge.net/R300.php

that I tried to compile and install BUT without success (working BUT NOT DRI
support :( ). Then I reinstalled from scratch a brand new Ubuntu 5.10.

> I could take a look at this, if I can reproduce it.

I think that you need an Apple machine similar to my Powerbook or something
with a G4 processor.

Many tanks in advance for your help.

Simone Mannori - www.inria.fr - Paris - Rocquencourt





