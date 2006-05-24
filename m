Message-ID: <34641.155.98.4.39.1148488917.squirrel@domain.hid>
Date: Wed, 24 May 2006 10:41:57 -0600 (MDT)
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] installing Xenomai on an AMD64
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

Hey all,
I'm trying to install xenomai-2.1.2 on a system running ubuntu configured
for AMD64.  Since xenomai doesn't currently support x86_64, I patched it
for i386.  Unfortunately, when I go to compile the kernel, I get an error,

  CHK     include/linux/version.h
  CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/linux/sched.h:7,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/ipipe.h:28:23: error: asm/ipipe.h: No such file or directory
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

could anyone fill me in on how to setup and compile xenomai on an x86_64
system?  I could overwrite the OS with a generic x86 version of ubuntu,
but that would preferably be a last resort.  Thanks.
-Brandt


