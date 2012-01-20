From: "Terry Fryar" <terry.fryar@domain.hid>
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
	<4F199E7E.8010101@domain.hid>
In-Reply-To: <4F199E7E.8010101@domain.hid>
Date: Fri, 20 Jan 2012 11:42:39 -0600
Message-ID: <DC2EA4D32D3F461E99F4A5FB8CFA84A2@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rtdm difficulties
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>, xenomai@xenomai.org

Now I'm seeing this.  I have lost complete control at this =
point....argh....

[  149.017562] WARNING: at kernel/softirq.c:137
__local_bh_enable+0x44/0xac()
[  149.024765] Modules linked in: vme_pd_drv
[  149.029014] [<c00566fc>] (unwind_backtrace+0x0/0xe0) from =
[<c007db0c>]
(warn_slowpath_common+0x4c/0x64)
[  149.038892] [<c007db0c>] (warn_slowpath_common+0x4c/0x64) from
[<c007db3c>] (warn_slowpath_null+0x18/0x1c)
[  149.049019] [<c007db3c>] (warn_slowpath_null+0x18/0x1c) from =
[<c0083138>]
(__local_bh_enable+0x44/0xac)
[  149.118865] [<c0083138>] (__local_bh_enable+0x44/0xac) from =
[<c008481c>]
(irq_enter+0x44/0x60)
[  149.127899] [<c008481c>] (irq_enter+0x44/0x60) from [<c0046018>]
(asm_do_IRQ+0x18/0x98)
[  149.136302] [<c0046018>] (asm_do_IRQ+0x18/0x98) from [<c00b9af0>]
(__ipipe_sync_stage+0x154/0x188)

=20

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: Friday, January 20, 2012 11:04 AM
To: xenomai@xenomai.org
Cc: Terry Fryar
Subject: Re: [Xenomai-help] rtdm difficulties

On 01/20/2012 05:17 PM, Terry Fryar wrote:
> Using xenomai 2.6.0 with 2.6.38 kernel and rtdm. Been working on a=20
> rtdm driver for awhile and all of a sudden I've lost stability. So,=20
> I've backed off all code except for registering an empty realtime irq=20
> handler using rtdm_irq_request(). I'm getting kernel oops, and I don't
know why?
> The irq handler simply returns RTDM_IRQ_HANDLED and that's it. I've=20
> rebuilt my kernel several times, and I'm wondering if I'm missing a=20
> .config entry for something related to xenomai?? If I take out the irq =

> handler registration, all is fine. This driver's been working for=20
> about
> 2 weeks, but all of a sudden I'm getting kernel faults. Here's what=20
> I'm getting from my driver (vme_pd_drv):
> [ 795.986316] Unable to handle kernel paging request at virtual=20
> address
> 80b112d6
> [ 795.993905] Unable to handle kernel paging request at virtual=20
> address
> e28cca55
> [ 796.001475] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.009045] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.016615] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.044130] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.051696] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.059262] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.106868] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.124353] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.131920] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.139484] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.207081] Unable to handle kernel paging request at virtual=20
> address
> e5bcf074
> [ 796.214711] pgd =3D c0004000
> [ 796.217544] [e5bcf074] *pgd=3D00000000 [ 796.221294] Internal error: =

> Oops: 5 [#1] PREEMPT [ 796.266149] last sysfs file:=20
> /sys/devices/virtual/irqdrv/irqdrv0/uevent
> [ 796.273082] Modules linked in: vme_pd_drv [last unloaded:=20
> vme_pd_drv] [ 796.279846] CPU: 0 Not tainted (2.6.38-ipipe-dirty #53)=20
> [ 796.315847] PC is at show_pte+0x18/0xb0 [ 796.319868] LR is at=20
> __do_kernel_fault+0x54/0x84 [ 796.384733] pc : [<c0059170>] lr :=20
> [<c00592f8>] psr: a0000113 [ 796.384740] sp : c058f1c8 ip : fb020000=20
> fp : 0000031b [ 796.396765] r10: 00000005 r9 : 20000113 r8 : 00000000=20
> [ 796.402237] r7 : c058f2a8 r6 : e5bcf050 r5 : e5bcf050 r4 : e5bcf074=20
> [ 796.449104] r3 : c058f1cc r2 : c04fbb6f r1 : e5bcf074 r0 : c04fbac9=20
> [ 796.455945] Flags: NzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment=20
> kernel [ 796.463604] Control: 10c5387d Table: 9e52c019 DAC: 00000017 [ =

> 796.519769] Process =FC (pid: -598785, stack limit =3D 0xc058e2f0)
                 ^^^^^^^^^^^^^^^^^^^^^^^^

UhOh... This very muck looks like stack overflow / corruption.

>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--
Philippe.


