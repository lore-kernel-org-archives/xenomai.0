Date: Mon, 3 Aug 2009 12:42:11 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1249287753.4803.10.camel@domain.hid>
Message-ID: <Pine.LNX.4.62.0908031224170.29519@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid> 
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
	<Pine.LNX.4.62.0907291210470.20869@domain.hid>
	<Pine.LNX.4.62.0907291226390.20869@domain.hid>
	<1248883517.3532.7.camel@domain.hid>
	<alpine.DEB.2.00.0907292209410.5958@domain.hid>
	<1249287753.4803.10.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> You seem to be using flat binaries, not ELF, at least if you did not
> change anything to the stock Blackfin Makefiles for 2009R1-RC2.

I tried both settings for userland in parallel, each time building 
in an absolutely clean (just untarred) uclinux-dist directory.

> I have just rebuilt your exact setup, i.e. everything from a stock
> 2009R1-RC2 which includes Xenomai 2.4.7, with the 09r1-rc10 toolchain.
> So far, everything looks fine when running the testsuite.

The smallest example that I can make that exhibits at least some of the
strange behaviour also doesn't make any problems when it is just run.
Let me describe the steps to reproduce, leaving as much at default as
possible. I first untar the uClinux-dist-2009R1-RC2.tar.bz2 and make
AnalogDevices/BF537-STAMP_default. When finished, I add Xenomai, using
"make menuconfig" and [X]ing Xenomai under Miscellaneous Applications,
and rebuild. All questions regarding Xenomai configuration when building
the kernel are answered with [Enter] and thus left at their default
value. Finally, I build an example and try to debug it.

The example is built from this source try.c:

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>

int main ()
{
   int r;
   RT_TASK maintask;
   mlockall(MCL_CURRENT|MCL_FUTURE);
   r = rt_task_shadow(&maintask, "maintask", 3, 0);
   printf("main:shadow:%d\n", r);
   return 0;
}

Using this command:

bfin-uclinux-gcc -I/opt/uClinux/uClinux-dist/staging/usr/include
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ -o try try.c -Wl,-elf2flt
-L/opt/uClinux/uClinux-dist.flat/staging/usr/lib -lnative -lpthread -lrt

I start it on the BF537-STAMP using "gdbserver localhost:2222 /mnt/try"
and debug from my PC with bfin-uclinux-gdb and this .gdbinit:

file try.gdb
target remote bfin:2222
break main
cont
next

The result is  (on the PC)

> 0x008e0044 in _stext ()
> Breakpoint 1 at 0x8e0188
> [New Thread 252]
> [Switching to Thread 252]
> 
> Breakpoint 1, 0x008e0188 in main ()
> Single stepping until exit from function main, 
> which has no line number information.
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0x008e71ae in __libc_write (fd=<value optimized out>, buf=0x8f4edc,
> count=20) at libc/sysdeps/linux/common/write.c:15
> 15	libc/sysdeps/linux/common/write.c: No such file or directory.
> 	in libc/sysdeps/linux/common/write.c

And on the BF537-STAMP the displayed result value is incorrect:

> Process /mnt/try created; pid = 252
> ...
> main:shadow:9343576
> Child exited with retcode = 0

Now, I enable Debug support for Xenomai in the Kernel, with Nucleus
Debugging support, but everything else (including Watchdog) disabled.
Without changes in try.c or .gdbinit, the same steps now produce the
error:

Xenomai: fatal: xnshadow_relax() failed for thread maintask[219]
  CPU  PID    PRI      TIMEOUT  STAT      NAME
    0  0        3      0        00400088  ROOT
>  0  219      3      0        00300380  maintask


Next I'll try with stock 2.4.7 Xenomai as you described. Thanks for the
concise guideline!

Greetings from Hamburg
Kolja

