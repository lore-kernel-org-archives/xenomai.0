Message-ID: <b647ffbd0706220517j693a736bk5cd3a46fc2635200@domain.hid>
Date: Fri, 22 Jun 2007 14:17:06 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <467BB833.1030401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46782305.4080501@domain.hid>
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
	<4679A302.2060403@domain.hid>
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>
	<467A42F6.8080706@domain.hid>
	<b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>
	<467A7593.4040402@domain.hid>
	<b647ffbd0706210614ib24568bq6f5bc149c2bbc423@domain.hid>
	<467A7FCA.40708@domain.hid> <467BB833.1030401@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
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

On 22/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> [ ... ]
>
> Only compile-tested under various .configs. Any comment welcome.
>

> @@ -76,7 +102,7 @@ static inline void xnintr_stat_counter_d
>  static void xnintr_irq_handler(unsigned irq, void *cookie)
>  {
>         xnsched_t *sched = xnpod_current_sched();
> -       xnintr_t *intr = (xnintr_t *)cookie;
> +       xnintr_t *intr;
>         xnstat_runtime_t *prev;
>         xnticks_t start;
>         int s;
> @@ -86,6 +112,16 @@ static void xnintr_irq_handler(unsigned
>         xnltt_log_event(xeno_ev_ienter, irq);
>
>         ++sched->inesting;
> +
> +       xnlock_get(&xnirqs[irq].lock);
> +
> +#ifdef CONFIG_SMP
> +       /* In SMP case, we have to reload the cookie under the per-IRQ lock
> +          to avoid racing with xnintr_detach. */
> +       intr = rthal_irq_cookie(&rthal_domain, irq);
> +#else
> +       intr = cookie;
> +#endif
>         s = intr->isr(intr);

I guess, 'intr' can be NULL here.

Could you please send me attached (non-inlined) a combo patch on top
of the trunk version (as I see this one seems to be on top of your
previous one)? I'll try to come up with some solution during this
weekend.


-- 
Best regards,
Dmitry Adamushko

