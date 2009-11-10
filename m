From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AF8A181.3050502@domain.hid>
References: <4AF85A5F.2030203@domain.hid> <4AF85B75.40408@domain.hid>
	<4AF85EAD.5020408@domain.hid> <4AF86204.6000700@domain.hid>
	<4AF8646D.1000204@domain.hid>
	<1257807715.2210.482.camel@domain.hid>
	<4AF8A181.3050502@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2009 11:27:47 +0100
Message-ID: <1257848867.2210.486.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Unchecked ipipe_test_pipeline_from
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Tue, 2009-11-10 at 00:10 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2009-11-09 at 19:50 +0100, Jan Kiszka wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Jan Kiszka wrote:
> >>>> Gilles Chanteperdrix wrote:
> >>>>> Jan Kiszka wrote:
> >>>>>> Hi Philippe,
> >>>>>>
> >>>>>> just noticed: The __ipipe_check_percpu_access of __ipipe_get_cpu_var,
> >>>>>> added in 2.6.29, makes ipipe_test_pipeline_from unusable for debugging
> >>>>>> purposes. It now triggers a false positive warning if the caller did not
> >>>>>> disabled interrupts or stalled its pipeline. One such user under Xenomai
> >>>>>> is rthal_local_irq_disabled, and that is used to check RTDM driver
> >>>>>> handlers /wrt leaking IRQ masks.
> >>>>> It does not look like a false positive. If the task issuing the call to
> >>>>> rthal_local_irq_disabled function was migrated at the wrong time, it
> >>>>> could check the stall flag on the wrong cpu.
> >>>> Unless you want to test the migration logic itself, a plain task in
> >>>> whatever domain should never see a CPU-depend rthal_local_irq_disabled -
> >>>> migration should never alter the context in this respect.
> >>>>
> > 
> > A plain task over the root domain which is subject to a migration may
> > end up testing the stall bit on the wrong (dest) CPU, which may execute
> > a different domain than the one running on the source CPU. As soon as
> 
> Yeah, makes sense now (with source and dest swapped, though).

Yes, I got it backward for the src/dst mention. The issue is indeed that
the address of the status word on src gets computed before a migration
is triggered to dst, so the action ends up being wrongly applied to src.

> 
> > the domain is not a context invariant, you do have a serious issue
> > coming up. So this does matter a lot, as the bug fixed some time ago in
> > ipipe_check_context() showed.
> > 
> >>>>> So, it looks like
> >>>>> rthal_local_irq_disabled should be fixed to turn off irqs during the check.
> >>>>>
> >>>> Would work, but would also be more heavy-weighted then needed.
> >>> If it is debug stuff, does the heavy-weight matter that much?
> >>>
> >> Actually, I'm no longer sure that a preemption check for
> >> ipipe_stall_pipeline_from makes sense at all. Am I missing some case?
> >>
> > 
> > Same as above. Albeit there may not be forced CPU migration over the
> > Xenomai domain, this is perfectly possible on the root one.
> 
> OK, will fix the checks in RTDM then.
> 
> Jan
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



