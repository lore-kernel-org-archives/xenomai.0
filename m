From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 12:52:25 -0500
Message-ID: <20151105175225.GR21923@csclub.uwaterloo.ca>
References: <20151105145725.GL21923@csclub.uwaterloo.ca>
 <20151105150226.GM21923@csclub.uwaterloo.ca>
 <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
 <20151105165750.GP21923@csclub.uwaterloo.ca>
 <20151105171419.GG16314@hermes.click-hack.org>
 <20151105172452.GQ21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105172452.GQ21923@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 12:24:52PM -0500, Lennart Sorensen wrote:
> On Thu, Nov 05, 2015 at 06:14:19PM +0100, Gilles Chanteperdrix wrote:
> > On Thu, Nov 05, 2015 at 11:57:50AM -0500, Lennart Sorensen wrote:
> > > On Thu, Nov 05, 2015 at 05:25:14PM +0100, Gilles Chanteperdrix wrote:
> > > > I am sure. Xenomai does not use H_DMA on armv7, so, it is not used
> > > > if your code, it is not used at all.
> > > 
> > > Well we are using it for one allocation for talking to a network port.
> > > 
> > > If I remove it, I get a NULL pointer dereference, so it clearly matters
> > > to something in our code.
> > > 
> > > > > It does appear that when LPAE is enabled H_DMA does do something on arm,
> > > > > but only when LPAE is enabled since that enables ZONE_DMA.
> > > > 
> > > > I never said that H_DMA did nothing.
> > > 
> > > OK I misunderstood then.
> > > 
> > > Setting /proc/cpu/alignment to 0 gives the kernel message:
> > > alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.
> > > 
> > > Apparently armv6+ with CR_U set is not allowed to turn off fixups.
> > 
> > If you have an armv7, you want to turn off all armv6 processors in
> > the kernel configuration so that the kernel does not try to be
> > compatible with these obsolete processors.
> 
> I thought I had.  Maybe not quite:
> 
> # CONFIG_ARCH_MULTI_V6 is not set
> CONFIG_ARCH_MULTI_V7=y
> CONFIG_ARCH_MULTI_V6_V7=y
> 
> I wonder if I can turn off CONFIG_ARCH_MULTI_V6_V7 somehow, not that I
> see anything in the kernel code that would change beecause of it.
> Of course LPAE being on pretty much also excludes ARMv6 support.
> 
> Certainly as far as I can tell, on any armv6+ with CR_U set (which all
> armv7 have hardwired), CR_A appears to always be cleared by the kernel, so I don't think it is causing the issue.
> 
> I think our problem is that we have allocated some memory that isn't
> considered normal and hence isn't allowed unaligned accesses and with
> gcc-4.6 that wasn't a problem, but with 4.9 it is (since it now does
> generate unaligned accesses by default)
> 
> I just have to figure out why there was any reason to allocate 'weird'
> memory.  I can't figure out why that would have been neccesary, but I
> didn't write that code.  I am just trying to fix it.

So when I change the one allocation from H_DMA to H_NONCACHED I get:

[   55.340237] rcksapi: DTB node=int_sm_sw, physical slot number=0, virtual IRQ=245
[   55.395419] Unable to handle kernel NULL pointer dereference at virtual address 00000002
[   55.411662] pgd = eded4ec0, hw pgd = eded4ec0
[   55.420397] [00000002] *pgd=adde8003, *pmd=add49003, *pte=00000000
[   55.432824] Internal error: Oops: 207 [#1] SMP ARM
[   55.442431] Modules linked in: ebtable_filter ebtables ip6table_filter ip6_tables 8021q garp stp mrp llc l2tp_ip6 l2tp_ip l2tp_eth l2tp_netlink ip_gre ip_tunnel gre l2tp_core macvlan mpls ti_pru_eth rcksapi_layer2(O) xhci_plat_hcd xhci_hcd iptable_nat nf_conntrack_ipv4
 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack dummy xeno_posix xeno_rtdm xeno_native dwc3 max6369_wdt phy_ti_pipe3 phy_omap_usb2 omap_aes_driver dwc3_omap at24 omap_des lm75 iptable_filter ip_tables x_tables
[   55.527108] CPU: 0 PID: 2944 Comm: StartTask Tainted: G           O 3.14-2-am5726 #1 Debian 3.14.56-0.1RR1
[   55.546483] task: ee9a3200 ti: edece000 task.ti: edece000
[   55.557325] PC is at get_free_range+0x60/0x1a8
[   55.566234] LR is at xnheap_alloc+0x4a4/0x538
[   55.574971] pc : [<c00f2d78>]    lr : [<c00f47ec>]    psr: 200d0093
[   55.574971] sp : edecfdd8  ip : 00000002  fp : 00000002
[   55.598008] r10: ef4a9d00  r9 : 00000ffe  r8 : 00000000
[   55.608485] r7 : 00001000  r6 : 00000002  r5 : f2051e30  r4 : ffff0f00
[   55.621578] r3 : 00001002  r2 : 00000002  r1 : 0004c000  r0 : f2051e30
[   55.634675] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   55.649163] Control: 30c5387d  Table: aded4ec0  DAC: fffffffd
[   55.660687] Process StartTask (pid: 2944, stack limit = 0xedece240)
[   55.673258] Stack: (0xedecfdd8 to 0xeded0000)
[   55.681992] fdc0:                                                       f2051e54 00000000
[   55.698402] fde0: ffff0f00 f2051e30 c0793cc0 c073eb1c 00000001 f2051e60 15e6a4da 00000000
[   55.714812] fe00: eeb1e000 00000002 ee259c00 c04ae6fc 00000000 0000119c 0004c000 c0730cd8
[   55.731223] fe20: 15e6a4da 00000000 eefb5b38 eeb14500 c073eb1c c0756160 c0793cc0 c073eb1c
[   55.747633] fe40: 00000003 00000000 f2051e00 0004b900 00000000 bf099660 00000001 eefb9a80
[   55.764043] fe60: c010b03c c0733a80 e5d24aa6 0000000c c0733a80 c0731ecc c073e5d4 c0793cc0
[   55.780453] fe80: ffffffff ffffffff 00208040 f2051e00 00000000 00000000 edecffb0 edece030
[   55.796864] fea0: c0793cc0 c0756160 00000000 bf084d90 edecfeec c04ac3a8 000099ca c007b794
[   55.813274] fec0: 00000000 2e886000 00000135 00000000 ffff0f00 c073eb1c ee9a3200 c08121fc
[   55.829683] fee0: 00000001 00000000 00000000 00000000 ffffffff ffffffff ee259c38 00000083
[   55.846093] ff00: f2051e30 b56e4000 00095000 f0abb000 b56e4000 00000022 00000001 edecffb0
[   55.862504] ff20: 00000218 c0812220 c08121fc f2041a10 edece038 c010b318 c010b268 00001198
[   55.878912] ff40: 00000000 c07bbcc0 c072fb38 c0793cc0 c0731e78 c07bbcc0 c073eb1c c00c857c
[   55.895323] ff60: c073eb1c eefb5b38 0000119c c00c7428 000f0abb e5a56840 c073eb1c c0793cc0
[   55.911733] ff80: c07bbcc0 edecffb0 e5a56840 b6a6ecbc 00000000 000000c0 000f0042 c0020d68
[   55.928144] ffa0: edece000 00000002 b68036d8 c0020cbc 4301022b b68e8250 0004b900 b6a6ec80
[   55.944553] ffc0: b6a6ecbc 00000000 000000c0 000f0042 000000c0 b68036e4 b68037bc b68036d8
[   55.960964] ffe0: b6f8c221 b6a6ec80 0007b98f b6f8c264 000d0030 4301022b 403ac0c4 e34a4d10
[   55.977383] [<c00f2d78>] (get_free_range) from [<eeb1e000>] (0xeeb1e000)
[   55.990829] Code: e1a02003 9a000016 e1a0c002 e0823007 (e69c4009) 
[   56.003053] ---[ end trace 1dcd48b94aa9e4b5 ]---

So clearly that is upsetting xenomai.  Or at least making it look like
it is upsetting xenomai given the xnheap_alloc+0x4a4/0x538.

I wish I could figure out why the backtraces aren't working, since they
are such a nice debug feature to have.

-- 
Len Sorensen

