Message-ID: <2ff1a98a0711130634x552683c4ib1c420a859a4d665@domain.hid>
Date: Tue, 13 Nov 2007 15:34:41 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4739B1DC.4030705@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0711130556j58141e80yc0bca6b574fad7e9@domain.hid>
	<4739B1DC.4030705@domain.hid>
Subject: Re: [Xenomai-core] local_irq_save/local_irq_restore in real-time
	interrupt handler and slab corruption.
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
Cc: xenomai-core <xenomai@xenomai.org>

On Nov 13, 2007 3:17 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> > Hi,
> >
> > I am chasing a slab corruption bug which happens on a Xenomai+RTnet
> > enabled box under heavy non real-time network load (which passes
> > through rtnet and rtmac_vnic to Linux which does NAT and resend it to
> > another rtmac_vnic). When reading some I-pipe tracer traces, I
> > remarked that I forgot to replace a local_irq_save/local_irq_restore
> > with local_irq_save_hw/local_irq_restore_hw in a real-time interrupt
> > handler. I fixed this bug, and the slab corruption seems to be gone.
>
> Hope you mean rtdm_lock_irqsave/irqrestore instead. Otherwise Xenomai's
> domain state would not be updated appropriately - which is at least unclean.

It is some low level secondary timer handling code, there is no rtdm
involved. The code protected by the interrupt masking routines is one
or two inline assembly instructions.

>
> BTW, CONFIG_IPIPE_DEBUG_CONTEXT should have caught this bug as well.

I am using an old I-pipe pacth without CONFIG_IPIPE_DEBUG_CONTEXT.
I-pipe patch and Xenomai update is scheduled for when RT applications
and drivers porting will be finished.

Besides the BUG_ON(!ipipe_root_domain_p) in ipipe_restore_root and
ipipe_unstall_root are unconditional.

>
> >
> > So, my question is: is it possible ? I mean, if local_irq_restore in
> > the real-time interrupt handler calls __ipipe_sync_stage, the root
> > domain is not stalled, so there should be no problem Linux-wise
> > playing root domain interrupts, I would rather expect the I-pipe state
> > to be jammed (after all, we are probably reentering functions that
> > should not be reentered), not Linux state.
>
> If I grab it correctly ATM, __ipipe_sync_stage() does not check for the
> domain stall bits, it assumes the caller has done so. Thus,

Yes, but the flags saved by local_irq_save tells if the domain is
stalled, and local_irq_restore calls __ipipe_unstall_root which calls
__ipipe_sync_stage only if the domain was not stalled.


-- 
                                               Gilles Chanteperdrix

