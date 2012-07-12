From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Date: Thu, 12 Jul 2012 21:54:27 +0200
Message-Id: <B8BB1834-3B77-49F2-8F40-C4801E858698@kabelmail.de>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai 2.6.1 on beaglebone (TI AM3359 SoC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to use Xenomai 2.6.1 on a beaglebone (AM3359 Cortex A8 SoC) =
running Linux 3.2.21. As the TI AM3359 is not supported in 3.2.21 =
mainline kernel, I am using the slightly patched kernel from linux-omap. =
The adeos patch applied without errors after minor fixups.=20
Building the kernel with or without Xenomai enabled succeeds.

Now the adeos patched kernel boots fine when disabling Xenomai & ipipe =
in the Kconfig configuration.

However, after enabling Xenomai & ipipe it hangs in an endless loop =
right after starting the Interrupt pipeline. Here's the bootlog:

Uncompressing Linux... done, booting the kernel.
Linux version 3.2.21 (stephan@ubuntu) (gcc version 4.6.2 (Buildroot =
2011.11) ) #12 PREEMPT Thu Jul 12 21:08:26 CEST 22
CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: am335xevm
Ignoring tag cmdline (using the default kernel command line)
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
AM335X ES1.0 (sgx neon )
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
65024
Kernel command line: console=3DttyO0,115200n8 mem=3D256M =
earlyprintk=3DttyO0 lpj=3D2494464
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 250944k/250944k available, 11200k reserved, 0K highmem
Virtual kernel memory layout:
   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
   fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
   vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
   lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
   modules : 0xbf000000 - 0xc0000000   (  16 MB)
     .text : 0xc0008000 - 0xc03e3000   (3948 kB)
     .init : 0xc03e3000 - 0xc083b000   (4448 kB)
     .data : 0xc083c000 - 0xc087e440   ( 266 kB)
      .bss : 0xc087e464 - 0xc08b3270   ( 212 kB)
NR_IRQS:396
IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
Total of 128 interrupts on 1 active controller
OMAP clockevent source: GPTIMER2 at 24000000 Hz
OMAP clocksource: GPTIMER1 at 32768 Hz
I-pipe, 0.032 MHz clocksource
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every =
131071999ms
Interrupt pipeline (release #1)
------------[ cut here ]------------

This is the last console output line. The cut here part comes from a =
WARN_ON_ONCE in kernel/softirq.c. This warning does not show up with =
ipipe disabled:

static void __local_bh_enable(unsigned int cnt)
{
	WARN_ON_ONCE(in_irq());=20
	WARN_ON_ONCE(!irqs_disabled()); <--- This warning asserts

	if (softirq_count() =3D=3D cnt)
		trace_softirqs_on((unsigned =
long)__builtin_return_address(0));
	sub_preempt_count(cnt);
}

Using a JTAG interface and gdb I see that the kernel didn't crash but =
the timer IRQ is constantly firing and the timer .ack handler is never =
called. When I CTRL^C break into the kernel, I always end up in one of =
the following functions:

handle_level_irq ()
omap3_intc_handle_irq ()
generic_handle_irq ()
irq_enter ()
irq_exit ()

And with less probability:

idle_cpu ()
irq_check_poll ()
rcu_enter_nohz ()

So far I found two things the AM3359 handles different compared to the =
Igepv2 board:

1) MACHINE_START has .handle_irq =3D omap3_intc_handle_irq while it is =
not defined in the ipipe-2.6 kernel repository

2) The AM3359 uses a different timer for system clock (not the default =
omap3 timer)

Any idea how I can dive into this issue? I have no clear understanding =
of the core-3.2 implementation so I'm not sure where to start.

Thanks a lot,
Stephan=
