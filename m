MIME-Version: 1.0
Date: Fri, 11 Sep 2009 15:01:05 -0400
Message-ID: <9b3e2dc20909111201m1b553420k5436a2da179e3279@domain.hid>
From: Stephen Sinclair <radarsat1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] CONFIG_NR_CPUS is too large
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

Hello,

I am trying to install Xenomai.  After patching the kernel (I have
tried with 2.6.29.5 and 2.6.30.5), I get the following error message:


$ make
scripts/kconfig/conf -s arch/x86/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-x86
  CC      arch/x86/kernel/asm-offsets.s
In file included from include/linux/sched.h:62,
                 from arch/x86/kernel/asm-offsets_64.c:8,
                 from arch/x86/kernel/asm-offsets.c:4:
include/linux/ipipe.h:76:2: error: #error "CONFIG_NR_CPUS is too
large, please lower it."
make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2


The CONFIG_NR_CPUS config variable is set to the default 64, but I
still get this error if I lower it to 4 or 2.  (This is a dual-core
machine, AMD X2.)

I tried commenting-out this error, just to see what would happen, but
I get an oops on boot.  Setting the boot flag earlyprintk=vga shows a
backtrace, and the crash happens immediately after
__ipipe_enable_irqdesc, which is in ipipe_virtualize_irq.

I don't know how to proceed from here, does anyone know why
CONFIG_NR_CPUS is triggering this error?

Thanks,
Steve

