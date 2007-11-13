Message-ID: <2ff1a98a0711131033o2e46eaeeua2bc9adf846af7b1@domain.hid>
Date: Tue, 13 Nov 2007 19:33:40 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4739E4E5.2030507@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0711130556j58141e80yc0bca6b574fad7e9@domain.hid>
	<4739B1DC.4030705@domain.hid>
	<2ff1a98a0711130634x552683c4ib1c420a859a4d665@domain.hid>
	<4739DA74.7040409@domain.hid>
	<2ff1a98a0711130924k3a81a5b8jf11982437308876e@domain.hid>
	<4739E2D5.7010105@domain.hid>
	<2ff1a98a0711130951h5ff16415kb6b1c2ebb6f7abed@domain.hid>
	<4739E4E5.2030507@domain.hid>
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

On Nov 13, 2007 6:54 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > On Nov 13, 2007 6:45 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >> Gilles Chanteperdrix wrote:
> >>> On Nov 13, 2007 6:10 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> On Nov 13, 2007 3:17 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>>>>> Gilles Chanteperdrix wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I am chasing a slab corruption bug which happens on a Xenomai+RTnet
> >>>>>>> enabled box under heavy non real-time network load (which passes
> >>>>>>> through rtnet and rtmac_vnic to Linux which does NAT and resend it to
> >>>>>>> another rtmac_vnic). When reading some I-pipe tracer traces, I
> >>>>>>> remarked that I forgot to replace a local_irq_save/local_irq_restore
> >>>>>>> with local_irq_save_hw/local_irq_restore_hw in a real-time interrupt
> >>>>>>> handler. I fixed this bug, and the slab corruption seems to be gone.
> >>>>>> Hope you mean rtdm_lock_irqsave/irqrestore instead. Otherwise Xenomai's
> >>>>>> domain state would not be updated appropriately - which is at least unclean.
> >>>>> It is some low level secondary timer handling code, there is no rtdm
> >>>>> involved. The code protected by the interrupt masking routines is one
> >>>>> or two inline assembly instructions.
> >>>>>
> >>>>>> BTW, CONFIG_IPIPE_DEBUG_CONTEXT should have caught this bug as well.
> >>>>> I am using an old I-pipe pacth without CONFIG_IPIPE_DEBUG_CONTEXT.
> >>>>> I-pipe patch and Xenomai update is scheduled for when RT applications
> >>>>> and drivers porting will be finished.
> >>>>>
> >>>>> Besides the BUG_ON(!ipipe_root_domain_p) in ipipe_restore_root and
> >>>>> ipipe_unstall_root are unconditional.
> >>>>>
> >>>> What bothers me, is that even looking at the old 1.3 series here and on,
> >>>> the code should exhibit a call chain like
> >>>> local_irq_restore -> raw_local_irq_restore() -> __ipipe_restore_root ->
> >>>> __ipipe_unstall_root -> __ipipe_sync_stage, without touching the current
> >>>> domain pointer, which is ok, since well, it has to be right in the first
> >>>> place. If we were running over a real-time handler, then I assume the
> >>>> Xenomai domain was active. So BUG_ON() should have triggered if present
> >>>> in __ipipe_unstall_root.
> >>> I am using an I-pipe arm 1.5-04 (now that I have done cat
> >>> /proc/ipipe/version, I really feel ashamed). And it has no BUG_ON in
> >>> __ipipe_unstall_root or __ipipe_restore_root. I promise, one day, I
> >>> will switch to Xenomai 2.4.
> >>>
> >>>> Additionally, calling __ipipe_sync_pipeline() would sync the current
> >>>> stage, i.e. Xenomai, and run the real-time ISRs, not the Linux handlers.
> >>>>
> >>>> Mm, ok, in short: I have no clue.
> >>> The system runs stably, so I have to assume that calling
> >>> local_irq_restore in a real-time interrupt handler can cause slab
> >>> corruption. Strange.
> >> What about instrumenting the involved I-pipe code path with
> >> ipipe_trace_specials and then restoring the buggy code. You may even
> >> ipipe_trace_freeze on that spot so that you can watch in pre/post trace
> >> what happens. May help to understand if this was the only issue, or if
> >> we may need some further measures for future versions.
> >
> > I have used the tracer, but the "slab corruption" message triggers a
> > long time after the bug. At least, with a 128K backtrace, I could not
> > find the place where the bug happened.
>
> Well, IF this local_irq fiddling here is supposed to be the reason, you
> should already be able to spot unexpected code paths around its usage.
> That was my idea. If there is nothing, you are probably only pushing
> around some still existing race window.

That is what I fear.


-- 
                                               Gilles Chanteperdrix

