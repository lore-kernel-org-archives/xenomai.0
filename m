Subject: Re: [Xenomai-core] [PATCH 1/3] decouple spinlock stats
	from	XENO_OPT_STATS
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <456332AF.8010106@domain.hid>
References: <456236D2.3050402@domain.hid> <45632BFA.30000@domain.hid>
	<456332AF.8010106@domain.hid>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 18:28:27 +0100
Message-Id: <1164130107.5006.139.camel@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-11-21 at 18:09 +0100, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >>  #ifdef CONFIG_XENO_SPINLOCK_DEBUG
> >> @@ -343,7 +340,7 @@ static inline spl_t __xnlock_get_irqsave
> >>  #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
> >>  static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
> >>  {
> >> -#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
> >> +#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
> > 
> > I prefer the notation:
> > 
> > #if cond
> > #endif /* cond */
> > 
> > and
> > 
> > #if cond
> > #else /* !cond */
> > #endif /* !cond */
> > 
> > to
> > 
> > #if cond
> > #endif /* cond */
> > 
> > and
> > 
> > #if cond
> > #else /* !cond */
> > #endif /* cond */
> > 
> > Because in the first case, when I see a #endif in the middle of a lot of
> > code, I immediately know what predicate is true above the #endif.
> > 
> 
> Ok, I understand the logic. Nevertheless, I had the impression the first
> scheme is used far more often than the second one in Xenomai and I-pipe,
> so I took the chance to consolidate the code.

Basically because I wrote those using the first convention.

> 
> So, what should be the common rule from now on? Is there a kernel-style
> rule for this issue we should follow, or are we free and should convert
> to your preferred scheme?
> 

Let's move to Gilles's convention; it's more readable.

> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



