Date: Tue, 11 Jan 2011 13:48:15 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <alpine.DEB.1.10.1101111320530.16506@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] blackfin kernel oops under heavy load
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

Hi,

I'd first like to report that I haven't yet been able
to further examine the problems with gdb and pthread_cond_wait, which I asked
about here some days ago. I found the bugs in my program which I was actually
searching for with other tools, but will have another look when there's time.

Now I experience kernel OOPS under heavy load. From the Hardware Trace, it
looks like the problem is somehow Xenomai-related which is why I post about it here.

Details about the situation: In /proc/xenomai/stat the two most busy tasks in my
application consume each around 45 %CPU during stress tests. One of the threads
receives data from a RTDM driver, and, because I have no RT driver for that
channel yet, sometimes writes a few bytes to a non-RT serial port
(/dev/ttyBF1). In other low prio tasks, IP network communication and stdio
output takes place.

The OOPS come as a "Illegal use of supervisor resource" or "NULL pointer
access". In both cases, the Hardware Trace looks very similar - the oldest
entries name _xnpod_schedule_deferred+0x26, followed by
___ipipe_sync_root+0x3a, _systen_call, __common_int_entry, and then either
___ipipe_trigger_irq (NULL pointer access) and _trap or __ipipe_sync_root
(Illegal use of supervisor resource) and _trap.

I use stock Blackfin 2.6.34-7 kernel (from dist 2010R1-RC5) with updated I-Pipe
1.14-02 and Xenomai 2.5.5.2 in kernel and userland on BF537.

Following is the complete OOPS output in case of the NULL pointer access, I
only shortened the stack dump. Then following is the output of gdb attached to
my target via JTAG (this is the first time I used JTAG with that target, I'm
open for tipps where I could set useful breakpoints for debugging this problem
etc.)

If you have any idea about possible causes or reasonable steps to further debug
the problem, I'd be really thankful to know about..

Kolja



NULL pointer access
Kernel OOPS in progress
Deferred Exception context
CURRENT PROCESS:
COMM=gatekeeper/0 PID=117  CPU=0
invalid mm
return address: [0x000067d0]; contents of:
0x000067b0:  6fa6  0037  6001  e3ff  ff53  6200  55c7  0c07 
0x000067c0:  1807  e14a  001d  e10a  35c4  9110  0040  6c66 
0x000067d0: [0127] 6008  0538  0010  0560  0167  6f46  e3ff 
0x000067e0:  dbe3  e14a  001a  e10a  58ac  9310  3008  e140

ADSP-BF537-0.3 533(MHz CCLK) 133(MHz SCLK) (mpu off)
Linux version 2.6.34.7-ADI-2010R1-svn10663 (kawk@domain.hid) (gcc version 4.3.5 (ADI-2010R1-RC4) ) #31 Mon Jan 10 17:32:28 CET 2011

SEQUENCER STATUS:       Not tainted
  SEQSTAT: 00002027  IPEND: 0008  IMASK: ffff  SYSCFG: 0006
   EXCAUSE   : 0x27
   physical IVG3 asserted : <0xffa0076c> { _trap + 0x0 }
  RETE: <0x00000000> /* Maybe null pointer? */
  RETN: <0x010e9f34> /* kernel dynamic memory (maybe user-space) */
  RETX: <0x00000480> /* Maybe fixed code section */
  RETS: <0x000067ba> { _ipipe_trigger_irq + 0xe }
  PC  : <0x000067d0> { _ipipe_trigger_irq + 0x24 }
DCPLB_FAULT_ADDR: <0x0000000c> /* Maybe null pointer? */
ICPLB_FAULT_ADDR: <0x000067d0> { _ipipe_trigger_irq + 0x24 }
PROCESSOR STATE:
  R0 : 0000ffff    R1 : 00000000    R2 : 0118bfbc    R3 : 0000003f
  R4 : 8e000000    R5 : 010e8000    R6 : 00000001    R7 : 0000ffc0
  P0 : 001b4538    P1 : 001d93f4    P2 : 001d35c4    P3 : 001b662c
  P4 : 001b662c    P5 : 0118aa04    FP : 010e9f5c    SP : 010e9e58
  LB0: ffa015e9    LT0: ffa015e6    LC0: 00000000
  LB1: 00a6304b    LT1: 00a6304a    LC1: 00000000
  B0 : 00000137    L0 : 00000000    M0 : fffffffc    I0 : 00ce0bf8
  B1 : 000000c0    L1 : 00000000    M1 : 00000001    I1 : 00000001
  B2 : 7ffff000    L2 : 00000000    M2 : 00001802    I2 : 00000003
  B3 : 00000000    L3 : 00000000    M3 : 0000005b    I3 : 00000006
A0.w: 00000000   A0.x: 00000000   A1.w: 00000000   A1.x: 00000000
USP : 0000000c  ASTAT: 02003044

Hardware Trace:
    0 Target : <0x00003bf8> { _trap_c + 0x0 }
      Source : <0xffa00700> { _exception_to_level5 + 0xa4 } JUMP.L
    1 Target : <0xffa0065c> { _exception_to_level5 + 0x0 }
      Source : <0xffa00510> { _bfin_return_from_exception + 0x18 } RTX
    2 Target : <0xffa004f8> { _bfin_return_from_exception + 0x0 }
      Source : <0xffa005b4> { _ex_trap_c + 0x74 } JUMP.S
    3 Target : <0xffa00540> { _ex_trap_c + 0x0 }
      Source : <0xffa007c4> { _trap + 0x58 } JUMP (P4)
    4 Target : <0xffa0076c> { _trap + 0x0 }
       FAULT : <0x000067d0> { _ipipe_trigger_irq + 0x24 } 0x0127
      Source : <0x000067ce> { _ipipe_trigger_irq + 0x22 } 0x6c66
    5 Target : <0x000067ce> { _ipipe_trigger_irq + 0x22 }
      Source : <0xffa00d12> { __common_int_entry + 0xce } RTI
    6 Target : <0xffa00cb0> { __common_int_entry + 0x6c }
      Source : <0xffa00982> { _system_call + 0xee } RTS
    7 Target : <0xffa0097e> { _system_call + 0xea }
      Source : <0xffa0096e> { _system_call + 0xda } IF !CC JUMP pcrel
    8 Target : <0xffa00964> { _system_call + 0xd0 }
      Source : <0xffa00954> { _system_call + 0xc0 } IF !CC JUMP pcrel
    9 Target : <0xffa00952> { _system_call + 0xbe }
      Source : <0xffa00942> { _system_call + 0xae } IF !CC JUMP pcrel
   10 Target : <0xffa00930> { _system_call + 0x9c }
      Source : <0xffa00950> { _system_call + 0xbc } JUMP.S
   11 Target : <0xffa0094e> { _system_call + 0xba }
      Source : <0x0000644e> { ___ipipe_sync_root + 0x8a } RTS
   12 Target : <0x00006434> { ___ipipe_sync_root + 0x70 }
      Source : <0x0000642e> { ___ipipe_sync_root + 0x6a } IF CC JUMP pcrel (BP)
   13 Target : <0x00006422> { ___ipipe_sync_root + 0x5e }
      Source : <0x00006414> { ___ipipe_sync_root + 0x50 } IF CC JUMP pcrel (BP)
   14 Target : <0x000063fe> { ___ipipe_sync_root + 0x3a }
      Source : <0x00037686> { _xnpod_schedule_deferred + 0x26 } RTS
   15 Target : <0x00037686> { _xnpod_schedule_deferred + 0x26 }
      Source : <0x0003767c> { _xnpod_schedule_deferred + 0x1c } IF !CC JUMP pcrel (BP)
Kernel Stack
Stack info:
  SP: [0x010e9c34] <0x010e9c34> /* kernel dynamic memory (maybe user-space) */
  FP: (0x010e9fa4)
  Memory from 0x010e9c30 to 010ea000
010e9c30: 00010f56 [00010f56] 00008db4  65666564  010e9cdc  00000034  0000ffff  00000001 
010e9c50: 00000001  017b1008  00000002  00000215  0001000c  ffa0076c  0011013a  e10e3e6e 
...
010e9ff0: 00000000  00000000  ffffffff  00000006 
Return addresses in stack:
     address : <0x0000d759> { _schedule_tail + 0x65 }
    frame  1 : <0x0001e8b8> { _kthread + 0x58 }
     address : <0x00001466> { _kernel_thread_helper + 0x6 }
Modules linked in: rmiisport
Kernel panic - not syncing: Kernel exception
Hardware Trace:
Stack info:
  SP: [0x010e9d78] <0x010e9d78> /* kernel dynamic memory (maybe user-space) */
  FP: (0x010e9fa4)
  Memory from 0x010e9d70 to 010ea000
010e9d70: 010e9d78  010e9e58 [0016cfb0] 0013c536  001a7000  0016cfb0  001a93be  001a93be 
010e9d90: 001a93be  010e9da8  00003f70  001a7000  00000008  00000003  0000001f  00000001 
...
010e9ff0: 00000000  00000000  ffffffff  00000006 
Return addresses in stack:
    frame  1 : <0x0001e8b8> { _kthread + 0x58 }
     address : <0x00001466> { _kernel_thread_helper + 0x6 }


Here's the gdb backtrace:

in panic_blink_one_second ()
     at /opt/uClinux-2010R1-RC5_tools-RC4/blackfin-linux-dist/linux-2.6.x/arch/blackfin/include/asm/delay.h:16
16  __asm__ __volatile__ (
(gdb) bt
#0  0x0001005c in panic_blink_one_second ()
     at /opt/uClinux-2010R1-RC5_tools-RC4/blackfin-linux-dist/linux-2.6.x/arch/blackfin/include/asm/delay.h:16
#1  0x0013c596 in panic (fmt=0x16cfb0 "Kernel exception") at kernel/panic.c:157
#2  0x00003f70 in trap_c (fp=0x10e9e58) at arch/blackfin/kernel/traps.c:459
#3  0xffa00704 in exception_to_level5 () at include/linux/thread_info.h:86
#4  0x0003d924 in gatekeeper_thread (data=<value optimized out>) at include/xenomai/nucleus/pod.h:288
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

















