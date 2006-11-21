Message-ID: <45632BFA.30000@domain.hid>
Date: Tue, 21 Nov 2006 17:40:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 1/3] decouple spinlock stats
	from	XENO_OPT_STATS
References: <456236D2.3050402@domain.hid>
In-Reply-To: <456236D2.3050402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
>  #ifdef CONFIG_XENO_SPINLOCK_DEBUG
> @@ -343,7 +340,7 @@ static inline spl_t __xnlock_get_irqsave
>  #else /* !CONFIG_XENO_SPINLOCK_DEBUG */
>  static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
>  {
> -#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
> +#endif /* CONFIG_XENO_SPINLOCK_DEBUG */

I prefer the notation:

#if cond
#endif /* cond */

and

#if cond
#else /* !cond */
#endif /* !cond */

to

#if cond
#endif /* cond */

and

#if cond
#else /* !cond */
#endif /* cond */

Because in the first case, when I see a #endif in the middle of a lot of
code, I immediately know what predicate is true above the #endif.

-- 
                                                 Gilles Chanteperdrix

