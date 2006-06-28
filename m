Subject: Re: [Xenomai-core] [PATCH 2/6] Improve fault report
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44A24308.70703@domain.hid>
References: <20060626172116.019532000@domain.hid>
	<20060626172118.347530000@domain.hid> <1151480559.5154.2.camel@domain.hid>
	<44A234F9.9010705@domain.hid> <1151481889.5154.14.camel@domain.hid>
	<44A23B66.7070202@domain.hid> <1151483788.5154.22.camel@domain.hid>
	<44A24308.70703@domain.hid>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 11:00:07 +0200
Message-Id: <1151485207.5154.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Wed, 2006-06-28 at 10:51 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-06-28 at 10:18 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Wed, 2006-06-28 at 09:51 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Mon, 2006-06-26 at 19:21 +0200, jan.kiszka@domain.hid wrote:
> >>>>>> plain text document attachment (enhance-kernel-fault-report.patch)
> >>>>>> Introduce xnarch_fault_um() to test if a fault happened in user-mode and applies the new feature to report core and driver crashes more verbosely. 
> >>>>>> 	if (xnpod_shadow_p()) {
> >>>>>>  #ifdef CONFIG_XENO_OPT_DEBUG
> >>>>>> -		if (xnarch_fault_notify(fltinfo))	/* Don't report debug traps */
> >>>>>> +		if (!xnarch_fault_um(fltinfo)) {
> >>>>>> +			xnarch_trace_panic_freeze();
> >>>>> KGDB breakpoint issue?
> >>>> Sorry, please switch on verbose mode, didn't get yet what you mean.
> >>> Oops, sorry. I meant: what if a KGDB breakpoint is hit from kernel space
> >>> while running a shadow thread? The way I read the modified test sequence
> >>> above, such bp trap is going to trigger a panic, instead of being
> >>> silently passed to Linux.
> >> I would say: KGDB will not come along here with a breakpoint. It should
> >> already got involved in __ipipe_divert_exception().
> > 
> > Ok, so the only problem that remains would be inlined asm("int 1/3") in
> > kernel space not handled by KGDB (whether the KGDB patch is in or not).
> > I'm still scratching my head pondering if we can live with this or not.
> 
> But this is perfectly one of the situations my patch tries to catch: a
> fatal bug in the kernel! Such a hand-coded kernel breakpoint without a
> debugger caring is a bug to me.

Not that sure: passive debug code may exist. Only the presence of the
debugger should activate it.

> 
> Jan
> 
-- 
Philippe.



