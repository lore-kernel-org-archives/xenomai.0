Message-ID: <4739B1DC.4030705@domain.hid>
Date: Tue, 13 Nov 2007 15:17:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0711130556j58141e80yc0bca6b574fad7e9@domain.hid>
In-Reply-To: <2ff1a98a0711130556j58141e80yc0bca6b574fad7e9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> I am chasing a slab corruption bug which happens on a Xenomai+RTnet
> enabled box under heavy non real-time network load (which passes
> through rtnet and rtmac_vnic to Linux which does NAT and resend it to
> another rtmac_vnic). When reading some I-pipe tracer traces, I
> remarked that I forgot to replace a local_irq_save/local_irq_restore
> with local_irq_save_hw/local_irq_restore_hw in a real-time interrupt
> handler. I fixed this bug, and the slab corruption seems to be gone.

Hope you mean rtdm_lock_irqsave/irqrestore instead. Otherwise Xenomai's
domain state would not be updated appropriately - which is at least unclean.

BTW, CONFIG_IPIPE_DEBUG_CONTEXT should have caught this bug as well.

> 
> So, my question is: is it possible ? I mean, if local_irq_restore in
> the real-time interrupt handler calls __ipipe_sync_stage, the root
> domain is not stalled, so there should be no problem Linux-wise
> playing root domain interrupts, I would rather expect the I-pipe state
> to be jammed (after all, we are probably reentering functions that
> should not be reentered), not Linux state.

If I grab it correctly ATM, __ipipe_sync_stage() does not check for the
domain stall bits, it assumes the caller has done so. Thus,

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

