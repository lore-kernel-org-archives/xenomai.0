Message-ID: <b054e88e0711091028v76750ff0jcf3b20aa12317d69@domain.hid>
Date: Fri, 9 Nov 2007 19:28:09 +0100
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <47348393.5030202@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b054e88e0711090616r6376a8a6t81e9bc94b4290dea@domain.hid>
	<473471FB.9010305@domain.hid> <4734736D.7060100@domain.hid>
	<b054e88e0711090652h176ef99dx740a5c0deb333829@domain.hid>
	<4734755F.2010301@domain.hid> <47347593.3040605@domain.hid>
	<b054e88e0711090747m315c1ecdsa998c41653737046@domain.hid>
	<47348393.5030202@domain.hid>
Subject: Re: [Xenomai-help] Kernel oops while trying first boot w/ Xenomai
	2.4rc5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-help <xenomai@xenomai.org>

Ok, I hope this is what you asked for...

I added printk in mask_ack_irq. Look at mask_ack_irq--> in the text
below, those are the addresses of the function pointers.
the printk related to mask_ack is printed once at the first pass in
the function, otherwise the kernel would be choked by the output.

Hope this helps. :-)

Giammarco



Linux version 2.6.22.12 (root@domain.hid) (gcc version 4.1.2 (Gentoo
4.1.2 p1.0.1)) #13 PREEMPT Fri Nov 9 19:16:49 CET 2007
Command line: root=/dev/sda6 console=ttyS0,38400
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
 BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cffc6300 (usable)
 BIOS-e820: 00000000cffc6300 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed40000 (reserved)
 BIOS-e820: 00000000fed45000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
end_pfn_map = 1245184
DMI 2.4 present.
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1245184
early_node_map[3] active PFN ranges
    0:        0 ->      153
    0:      256 ->   851910
    0:  1048576 ->  1245184
Intel MultiProcessor Specification v1.4
MPTABLE: OEM ID: COMPAQ   MPTABLE: Product ID: Workstation  MPTABLE:
APIC at: 0xFEE00000
Processor #0 (Bootup-CPU)
Processor #1
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
Processor #2
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
Processor #3
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
I/O APIC #1 at 0xFEC00000.
Setting APIC routing to flat
Processors: 1
Allocating PCI resources starting at d2000000 (gap: d0000000:20000000)
Built 1 zonelists.  Total pages: 1029547
Kernel command line: root=/dev/sda6 console=ttyS0,38400
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 2666.804 MHz processor.
I-pipe 1.2-05: pipeline enabled.
mask_ack_irq-->irq = 0x0, mask_ack = 0xffffffff8020e2ea
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x58e2000 - 0x98e2000
Memory: 4045456k/4980736k available (2500k kernel code, 147932k
reserved, 3791k data, 192k init)
Calibrating delay using timer specific routine.. 5334.91 BogoMIPS (lpj=2667457)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
using mwait in idle threads.
CPU: Intel(R) Core(TM)2 Quad CPU           @ 2.66GHz stepping 07
mask_ack_irq-->irq = 0x0, mask = 0x0
mask_ack_irq-->irq = 0x0, ack = 0xffffffff802142b9
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<0000000000000000>]
PGD 0
Oops: 0010 [1] PREEMPT
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.22.12 #13
RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
RSP: 0000:ffffffff80863f40  EFLAGS: 00010286
RAX: ffffffff80827f60 RBX: 0000000000000000 RCX: ffffffff80873280
RDX: 0000000000000064 RSI: 0000000000000d81 RDI: 0000000000000000
RBP: ffffffff80863f58 R08: 0000000000000000 R09: 0000000000000020
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff805702c0
R13: 0000000000000000 R14: ffff81012fc41ce8 R15: ffffffff808f9a08
FS:  0000000000000000(0000) GS:ffffffff80826000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff81012fc40000, task ffff81012fc3f480)
Stack:  ffffffff8024d001 0000000000000000 ffffffff808f9a00 ffffffff80863f68
 ffffffff8021302a ffffffff80863fa8 ffffffff802131eb 0000000000000000
 0000000000000246 0000000000000246 0000000000001b00 0000000000000018
Call Trace:
 <IRQ>  [<ffffffff8024d001>] __ipipe_ack_level_irq+0x80/0x8f
 [<ffffffff8021302a>] __ipipe_ack_irq+0x1c/0x23
 [<ffffffff802131eb>] __ipipe_handle_irq+0xfc/0x1af
 [<ffffffff80209c7a>] common_interrupt+0x7a/0x9b
 <EOI>  [<ffffffff8024eed7>] __ipipe_spin_unlock_irqrestore+0x4c/0x51
 [<ffffffff8020e2e5>] enable_8259A_irq+0x6a/0x6f
 [<ffffffff80839c52>] setup_IO_APIC+0x8be/0xb84
 [<ffffffff802209cf>] sub_preempt_count+0x9/0x96
 [<ffffffff804686bf>] preempt_schedule+0x6d/0x85
 [<ffffffff80221af3>] try_to_wake_up+0x18c/0x19d
 [<ffffffff80330a99>] debug_smp_processor_id+0x9/0xe0
 [<ffffffff80838844>] APIC_init_uniprocessor+0xb6/0xd0
 [<ffffffff8082f586>] kernel_init+0x72/0x276
 [<ffffffff8024eb20>] ipipe_check_context+0xe/0x82
 [<ffffffff8020a268>] child_rip+0xa/0x12
 [<ffffffff80209824>] int_ret_from_sys_call+0x6/0x19
 [<ffffffff8082f514>] kernel_init+0x0/0x276
 [<ffffffff8020a25e>] child_rip+0x0/0x12


Code:  Bad RIP value.
RIP  [<0000000000000000>]
 RSP <ffffffff80863f40>
CR2: 0000000000000000
Kernel panic - not syncing: Attempted to kill init!


On Nov 9, 2007 4:58 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Giammarco Zacheo wrote:
> > Ok, i enabled the tracer and the IRQs-off tracing, but it seems that
> > nothing changed (I also chopped away hw monitoring and MCE features),
> > don't know if I did something wrong.
>
> Ah, uhm, could be that the tracer is not yet armed at this point of the
> boot process. Sigh.
>
> >
> > Is there anything else I can do, o Elders? :)
>
> Do you already feel like a kernel hacker? If not, let's change this: We
> need information about the number of the IRQ that pops up below and the
> state if its descriptor (irq, desc->irq->ack_mask, desc->irq->mask,
> desc->irq->ack). Could you put some printk outputs in mask_ack_irq
> (kernel/irq/chip.c)? Then report to the list again.
>
> TiA!
>
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

