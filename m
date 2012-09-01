Date: Sat, 1 Sep 2012 15:50:11 +0200
From: "gwenhael.goavec" <gwenj@trabucayre.com>
Message-ID: <20120901155011.70dcc825@dell>
In-Reply-To: <504210A3.2080402@xenomai.org>
References: <20120901153825.3f232f97@dell>
	<504210A3.2080402@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx1 and imx27 boot problem with __ipipe_tsc_get()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Sat, 01 Sep 2012 15:41:55 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> On 09/01/2012 03:38 PM, gwenhael.goavec wrote:
> 
> > Hi,
> > 
> > I have 2 boards, the first is based on imx1 and the second on imx27.
> > With this 2 boards, I'm unable to boot a 2.6.38.8 kernel.
> > For the imx1 with 3.2.21 the result is the same.
> > 
> > I have enabled early_printk. On every boards the boot stop with a kernel panic.
> > The message start with : "Unable to handle kernel paging request at virtual
> > address 10003010" on imx27.
> > 
> > This is due to the call of __ipipe_tsc_get() in __ipipe_tsc_update()
> > 
> > To verify my toolchain I have tested 2.6.38.8 with at91 successfully.
> > 
> > If someone has a idea?
> 
> 
> Not enough information, to understand what happens we need the kernel
> oops (at least the register values).
> 
> -- 
>                                                                 Gilles.

Sorry,

Unable to handle kernel paging request at virtual address 10003010
pgd = c0004000
[10003010] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
last sysfs file: 
Modules linked in:
CPU: 0    Not tainted  (2.6.38.8-ipipe #34)
PC is at 0xffff0f48
LR is at __ipipe_tsc_update+0xfc/0x1c0
pc : [<ffff0f48>]    lr : [<c0032cd4>]    psr: 600000d3
sp : c049fe80  ip : c04af0b0  fp : c04af040
r10: c04af0b0  r9 : c04d5300  r8 : c04d5300
r7 : 0000001a  r6 : c04c99f8  r5 : ffff0f40  r4 : ffff0f20
r3 : 00000000  r2 : 00000000  r1 : c04d5300  r0 : 10003010
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: a0004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc049e270)
Stack: (0xc049fe80 to 0xc04a0000)
fe80: c04a5a78 00000000 00000000 c0039710 c00396fc c0075188 00000000 c04a878c
fea0: c049e000 0000001a c04a5a78 c007750c 0000001a c04b545c 00000000 00000002
fec0: c04d5300 c002b044 0000001d c04af0e8 0000001a c007bdf0 c049e000 c0043dd8
fee0: 00000001 c049e000 c04a60ec 0000000c 00000001 c04a60ec 00000034 c049ffb4
ff00: 00000000 c007c4dc c04d5300 c0044248 c049e000 00000000 00000000 c0044250
ff20: c3801470 00000000 00000001 00000000 c3801460 c3801470 c3803200 00000000
ff40: c04d5300 c00b2a20 c055a020 c38014c0 c38014c0 c00b1c04 c38025a0 00000000
ff60: c04b1290 c04af0e8 00000000 ffffffff 00000000 c0022578 00000001 c0442f50
ff80: 41069264 a0021148 00000000 c0399d78 41069264 c049ffb4 c04c98c0 c04c98c0
ffa0: c0022578 c056a360 a002117c c0015ff4 c0442f50 c04d5300 00000002 00000000
ffc0: c04c98c0 c04c98c0 c0022578 c0008c34 c0008464 00000000 00000000 c0022578
ffe0: 00000000 00053175 c04a0010 c0022574 c04a35cc a0008034 00000000 00000000
[<c0032cd4>] (__ipipe_tsc_update+0xfc/0x1c0) from [<c0039710>] (mxc_timer_interrupt+0x14/0x34)
[<c0039710>] (mxc_timer_interrupt+0x14/0x34) from [<c0075188>] (handle_IRQ_event+0x40/0x130)
[<c0075188>] (handle_IRQ_event+0x40/0x130) from [<c007750c>] (handle_level_irq+0x94/0x140)
[<c007750c>] (handle_level_irq+0x94/0x140) from [<c002b044>] (asm_do_IRQ+0x44/0x9c)
[<c002b044>] (asm_do_IRQ+0x44/0x9c) from [<c007bdf0>] (__ipipe_sync_stage+0x1a0/0x1bc)
Exception stack(0xc049fed8 to 0xc049ff20)
fec0:                                                       c049e000 c0043dd8
fee0: 00000001 c049e000 c04a60ec 0000000c 00000001 c04a60ec 00000034 c049ffb4
ff00: 00000000 c007c4dc c04d5300 c0044248 c049e000 00000000 00000000 c0044250
[<c007bdf0>] (__ipipe_sync_stage+0x1a0/0x1bc) from [<c007c4dc>] (__ipipe_unstall_root+0x48/0x54)
[<c007c4dc>] (__ipipe_unstall_root+0x48/0x54) from [<c0044248>] (vprintk+0x2d0/0x480)
[<c0044248>] (vprintk+0x2d0/0x480) from [<c0399d78>] (printk+0xf4/0x1a0)
[<c0399d78>] (printk+0xf4/0x1a0) from [<c0015ff4>] (console_init+0xc/0x60)
[<c0015ff4>] (console_init+0xc/0x60) from [<c0008c34>] (start_kernel+0x4a4/0x638)
[<c0008c34>] (start_kernel+0x4a4/0x638) from [<a0008034>] (0xa0008034)
Code: 00000000 10003010 e51f000c e14f22dc (e5900000) 
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<c0031e2c>] (unwind_backtrace+0x0/0xf0) from [<c0399b64>] (panic+0x60/0x180)
[<c0399b64>] (panic+0x60/0x180) from [<c0030050>] (die+0x1c4/0x1f8)
[<c0030050>] (die+0x1c4/0x1f8) from [<c0033b84>] (__do_kernel_fault+0x64/0x84)
[<c0033b84>] (__do_kernel_fault+0x64/0x84) from [<c0033da4>] (do_page_fault+0x200/0x390)
[<c0033da4>] (do_page_fault+0x200/0x390) from [<c002b2b8>] (do_DataAbort+0x30/0x134)
[<c002b2b8>] (do_DataAbort+0x30/0x134) from [<c002bc6c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc049fe38 to 0xc049fe80)
fe20:                                                       10003010 c04d5300
fe40: 00000000 00000000 ffff0f20 ffff0f40 c04c99f8 0000001a c04d5300 c04d5300
fe60: c04af0b0 c04af040 c04af0b0 c049fe80 c0032cd4 ffff0f48 600000d3 ffffffff
[<c002bc6c>] (__dabt_svc+0x4c/0x60) from [<ffff0f48>] (0xffff0f48)

Gwenhael

