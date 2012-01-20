Message-ID: <4F199E7E.8010101@domain.hid>
Date: Fri, 20 Jan 2012 18:03:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
In-Reply-To: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
To: xenomai@xenomai.org

On 01/20/2012 05:17 PM, Terry Fryar wrote:
> Using xenomai 2.6.0 with 2.6.38 kernel and rtdm. Been working on a rtdm
> driver for awhile and all of a sudden I've lost stability. So, I've
> backed off all code except for registering an empty realtime irq handler
> using rtdm_irq_request(). I'm getting kernel oops, and I don't know why?
> The irq handler simply returns RTDM_IRQ_HANDLED and that's it. I've
> rebuilt my kernel several times, and I'm wondering if I'm missing a
> .config entry for something related to xenomai?? If I take out the irq
> handler registration, all is fine. This driver's been working for about
> 2 weeks, but all of a sudden I'm getting kernel faults. Here's what I'm
> getting from my driver (vme_pd_drv):
> [ 795.986316] Unable to handle kernel paging request at virtual address
> 80b112d6
> [ 795.993905] Unable to handle kernel paging request at virtual address
> e28cca55
> [ 796.001475] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.009045] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.016615] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.044130] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.051696] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.059262] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.106868] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.124353] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.131920] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.139484] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.207081] Unable to handle kernel paging request at virtual address
> e5bcf074
> [ 796.214711] pgd =3D c0004000
> [ 796.217544] [e5bcf074] *pgd=3D00000000
> [ 796.221294] Internal error: Oops: 5 [#1] PREEMPT
> [ 796.266149] last sysfs file: /sys/devices/virtual/irqdrv/irqdrv0/uevent
> [ 796.273082] Modules linked in: vme_pd_drv [last unloaded: vme_pd_drv]
> [ 796.279846] CPU: 0 Not tainted (2.6.38-ipipe-dirty #53)
> [ 796.315847] PC is at show_pte+0x18/0xb0
> [ 796.319868] LR is at __do_kernel_fault+0x54/0x84
> [ 796.384733] pc : [<c0059170>] lr : [<c00592f8>] psr: a0000113
> [ 796.384740] sp : c058f1c8 ip : fb020000 fp : 0000031b
> [ 796.396765] r10: 00000005 r9 : 20000113 r8 : 00000000
> [ 796.402237] r7 : c058f2a8 r6 : e5bcf050 r5 : e5bcf050 r4 : e5bcf074
> [ 796.449104] r3 : c058f1cc r2 : c04fbb6f r1 : e5bcf074 r0 : c04fbac9
> [ 796.455945] Flags: NzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment ker=
nel
> [ 796.463604] Control: 10c5387d Table: 9e52c019 DAC: 00000017
> [ 796.519769] Process =FC (pid: -598785, stack limit =3D 0xc058e2f0)
                 ^^^^^^^^^^^^^^^^^^^^^^^^

UhOh... This very muck looks like stack overflow / corruption.

>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

