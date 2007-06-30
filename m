From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46860AC9.8080907@domain.hid>
References: <1183144465.6574.99.camel@domain.hid>  <46860AC9.8080907@domain.hid>
Content-Type: text/plain
Date: Sat, 30 Jun 2007 12:42:56 +0200
Message-Id: <1183200176.14520.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Support for 2.6.22/x86
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2007-06-30 at 09:48 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > Our development trunk now contains the necessary support for running
> > Xenomai over 2.6.22/x86. This work boils down to enabling Xenomai to use
> > the generic clock event device abstraction that comes with newest
> > kernels. Other archs / kernel versions still work the older way, until
> > all archs eventually catch up with clockevents upstream.
> > 
> > This support won't be backported to 2.3.x, because it has some
> > significant impact on the nucleus. Tested as thoroughly as possible here
> > on low-end and mid-range x86 boxen, including SMP.
> > 
> > Please give this hell.
> > 
> > http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
> > 
> 
> Running some tests, the gate to hell just opened:
> 
> [  210.247006] BUG: sleeping function called from invalid context at
> kernel/sched.c:3941
> [  210.248171] in_atomic():1, irqs_disabled():1
> [  210.248828] no locks held by frag-ip/881.
> [  210.249494]  [<c01040e9>] show_trace_log_lvl+0x1f/0x34
> [  210.250523]  [<c0104d6c>] show_trace+0x17/0x19
> [  210.257778]  [<c0104e6a>] dump_stack+0x1b/0x1d
> [  210.258070]  [<c0112030>] __might_sleep+0xda/0xe1
> [  210.258365]  [<c028bacf>] wait_for_completion+0x1f/0xc3
> [  210.258688]  [<c01143d8>] set_cpus_allowed+0x77/0x95
> [  210.258992]  [<c89cc202>] lostage_handler+0x75/0x201 [xeno_nucleus]
> [  210.259551]  [<c0146fe2>] rthal_apc_handler+0x5c/0x89
> [  210.259869]  [<c0143ba9>] __ipipe_sync_stage+0x13a/0x147
> [  210.260204]  [<c010e6b6>] __ipipe_syscall_root+0x1a6/0x1c8
> [  210.260536]  [<c0102809>] system_call+0x29/0x41
> 
> Setup is latest SVN + a "few" patches (the well-known ones), CONFIG_SMP,
> qemu -smp 2, RTnet in loopback mode, just terminating the frag-ip example.
> 
> However, this gremlin looks like it is /far/ older than 2.6.22 support.
> Calling set_cpus_allowed() from atomic lostage_handler is simply bogus,
> I'm afraid. :-/

Btw, you should have a look at a critical change in the way raw I-pipe
spinlocks are now manipulated (include/linux/spinlock.h wrappers).
In short, to solve a deadly bug in all previous implementations, a set
of dedicated helpers is now used to stall/unstall the current stage for
the spin_lock_irq* forms, the way it has to be, i.e. touching both the
real and virtual IRQ masks.

Such bug would accidentally clear the hardware IRQ mask, which would
lead to a recursive lock attempt whenever an interrupt is caught at the
wrong time on the same CPU, e.g.:

mask_and_ack_8259A
	local_irq_save_hw()+spinlock
	printk("spurious IRQ #...")
		printk() ->vprintk()
		...
		spin_lock_irqsave()
		spin_unlock_irqrestore()
			local_irq_enable_hw()
				<IRQ> -> mask_and_ack_8259A

The way to solve this is to make sure that the stall bit for the current
domain always reflects the state of the hardware mask when operating raw
I-pipe locks.

As a consequence of this, you may not assume anymore that calling
spin_unlock() + local_irq_restore_hw() in sequence would have the same
effect than calling spin_unlock_irqrestore() on any ipipe_spinlock_t
locks. This would have the very undesirable side-effect of leaving the
virtual IRQ mask in stalled mode. I fixed an issue of this kind in the
tracer code (__ipipe_global_path_unlock) already, precisely caught after
getting a might_sleep() warning when reading /proc/ipe/trace/{max,
frozen}.

So you may want to double-check whether some constructs of this kind
might exist in any of your local patches. I did not find any in the
vanilla code, but another round of verifications may be useful.

-- 
Philippe.



