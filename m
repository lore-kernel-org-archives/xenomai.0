Message-ID: <48A4ECEB.4060206@domain.hid>
Date: Thu, 14 Aug 2008 22:41:47 -0400
From: Steve Shumway <sshumway@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai install problem?
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

Hello;

I'm trying to write a RTDM driver, and I can't seem to get it to 
compile. I suspect that it has something to do with my installation of 
Xenomai, or the kernel patch. Here's what the offending code looks like:

---------------
/*!
  *  @file irqcontrol_driver.c
  *
  *  @brief RTDM IRQ Control Driver
  *  @version 0.1
  *
  *
  *
  *
  *
  *
  *
  *  FPGA Interrupt 7 Control
  *
  *  I/O Address: 0x32D
  *
  *  Bit 3:  Digital Input 7 Interrupt Enable     Read/Write
  *  Bit 2:  Timing Input Interrupt Enable        Read/Write
  *  Bit 1:  Interrupt caused by digital Input 7  Read Only
  *  Bit 0:  Interrupt caused by timing input     Read Only
  */

//#define	DEBUG_IRQCONTROL_DRVR	1

#include <linux/kernel.h>
#include <rtdm/rtdm_driver.h>

#include "xchan_fpga.h"


#define	IRQ7CTL_SUB_CLASS	4711

---------------

There is obviously more to the driver. I will gladly post more of it 
should anyone request, it looks to me like posting more of it would be a 
waste of time though. The problem looks to be with the "#include 
<rtdm/rtdm_driver.h>" line. This is line 26 in the source file that the 
compiler is complaining about.

The error message from the compile step is:

gcc -O2 -Wall -DMODULE -D__KERNEL__ -DLINUX -I/usr/src/linux/include 
-I/usr/src/linux/include/xenomai/compat -I/usr/xenomai/include   -c -o 
irqcontrol_driver.o irqcontrol_driver.c
In file included from /usr/src/linux/include/linux/prefetch.h:14,
                  from /usr/src/linux/include/linux/list.h:8,
                  from /usr/xenomai/include/rtdm/rtdm_driver.h:35,
                  from irqcontrol_driver.c:26:
/usr/src/linux/include/asm/processor.h:102: error: 
'CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)
/usr/src/linux/include/asm/processor.h:102: error: requested alignment 
is not a constant
/usr/src/linux/include/asm/processor.h: In function 'load_cr3':
/usr/src/linux/include/asm/processor.h:162: error: 
'CONFIG_PAGE_OFFSETUL' undeclared (first use in this function)
/usr/src/linux/include/asm/processor.h:162: error: (Each undeclared 
identifier is reported only once
/usr/src/linux/include/asm/processor.h:162: error: for each function it 
appears in.)
/usr/src/linux/include/asm/processor.h: At top level:
/usr/src/linux/include/asm/processor.h:201: error: requested alignment 
is not a constant
In file included from /usr/src/linux/include/asm/thread_info.h:4,
                  from /usr/src/linux/include/linux/thread_info.h:35,
                  from /usr/src/linux/include/linux/preempt.h:9,
                  from /usr/src/linux/include/linux/spinlock.h:49,
                  from /usr/src/linux/include/linux/seqlock.h:29,
                  from /usr/src/linux/include/linux/time.h:8,
                  from /usr/src/linux/include/linux/timex.h:57,
                  from /usr/src/linux/include/linux/sched.h:54,
                  from /usr/src/linux/include/linux/ptrace.h:80,
                  from /usr/src/linux/include/asm/xenomai/system_32.h:28,
                  from /usr/src/linux/include/asm/xenomai/system.h:2,
                  from /usr/xenomai/include/nucleus/types.h:39,
                  from /usr/xenomai/include/nucleus/stat.h:24,
                  from /usr/xenomai/include/nucleus/thread.h:130,
                  from /usr/xenomai/include/nucleus/pod.h:34,
                  from /usr/xenomai/include/nucleus/xenomai.h:23,
                  from /usr/xenomai/include/rtdm/rtdm_driver.h:37,
                  from irqcontrol_driver.c:26:
/usr/src/linux/include/asm/thread_info_64.h: In function 
'current_thread_info':
/usr/src/linux/include/asm/thread_info_64.h:66: error: 'THREAD_SIZE' 
undeclared (first use in this function)
/usr/src/linux/include/asm/thread_info_64.h: In function 
'stack_thread_info':
/usr/src/linux/include/asm/thread_info_64.h:74: error: 'THREAD_SIZE' 
undeclared (first use in this function)
In file included from /usr/src/linux/include/linux/preempt.h:9,

---------------

There's a bunch more to the error listing.

I've done a search of the /usr/source tree, and I can't find any 
definition of the macro: "CONFIG_X86_L1_CACHE_SHIFT". In fact all of the 
other errors in the compiler output are complaints about missing CONFIG_ 
symbols.

I know from my investigations that the kernel source tree does some 
unusual stuff for the "autoconf.h" file which comes out of the "make 
menuconfig" installation step. I just don't seem to be able to convince 
the installation process to give me a properly constructed set of header 
files.


The steps I used to install Xenomai are:


tar -xvzpf linux-2.6.25 tar -C /usr/src

tar -xvjpf xenomai-2.4.4.tar.bz2 -C /usr/src

cd /usr/src/xenomai-2.4.4

./scripts/prepare-kernel.sh \
--linux=/usr/src/linux-2.6.25 \
--arch=i686 \
--adeos=/usr/src/xenomai-2.4.4/ksrc/arch/x86/patches/adeos-ipipe-2.6.25-x86-2.0-08.patch

cd /usr/src/linux-2.6.25

make menuconfig

make bzImage modules

mkdir -p /usr/src/xeno-linux

cd /usr/src/xeno-linux

/usr/src/xenomai-2.4.4/configure

make install

---------------

The above procedure seems to complete without any complaints. I'm out of 
ideas as to what I'm doing wrong. It seems like it must be something 
simple, but I just don't see what that simple thing is.

Thanks in advance for any help you can provide.

Regards

Steve Shumway



