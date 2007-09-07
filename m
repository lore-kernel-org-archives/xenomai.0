From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46D66DA5.9030100@domain.hid>
References: <46D66DA5.9030100@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:22:14 +0200
Message-Id: <1189149734.26986.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 1/2] Introduce xntbase_ns2ticks_ceil
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
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>, xenomai-core <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

On Thu, 2007-08-30 at 09:11 +0200, Jan Kiszka wrote:
> This introduces a round-up-variant of xntbase_ns2ticks. It is uninlined
> for the non-trivial case due to its text size. Its only user will be
> RTDM for now, but maybe the POSIX skin can use it as well.
> 
> Philippe, if you accept this one, I'll handle the RTDM side myself.
> 

Merged, thanks.

> Jan
> plain text document attachment (xntbase_ns2ticks_ceil.patch)
> ---
>  include/nucleus/timebase.h |    7 +++++++
>  ksrc/nucleus/timebase.c    |    7 +++++++
>  2 files changed, 14 insertions(+)
> 
> Index: xenomai/include/nucleus/timebase.h
> ===================================================================
> --- xenomai.orig/include/nucleus/timebase.h
> +++ xenomai/include/nucleus/timebase.h
> @@ -148,6 +148,8 @@ static inline xnticks_t xntbase_ns2ticks
>  	return xnarch_ulldiv(t, xntbase_get_tickval(base), NULL);
>  }
>  
> +xnticks_t xntbase_ns2ticks_ceil(xntbase_t *base, xntime_t t);
> +
>  static inline int xntbase_master_p(xntbase_t *base)
>  {
>  	return base == &nktbase;
> @@ -247,6 +249,11 @@ static inline xnticks_t xntbase_ns2ticks
>  	return t;
>  }
>  
> +static inline xnticks_t xntbase_ns2ticks_ceil(xntbase_t *base, xntime_t t)
> +{
> +	return t;
> +}
> +
>  static inline int xntbase_master_p(xntbase_t *base)
>  {
>  	return 1;
> Index: xenomai/ksrc/nucleus/timebase.c
> ===================================================================
> --- xenomai.orig/ksrc/nucleus/timebase.c
> +++ xenomai/ksrc/nucleus/timebase.c
> @@ -483,6 +483,12 @@ void xntbase_tick(xntbase_t *base)
>  	xnlock_put_irqrestore(&nklock, s);
>  }
>  
> +xnticks_t xntbase_ns2ticks_ceil(xntbase_t *base, xntime_t t)
> +{
> +	return xnarch_ulldiv(t + xntbase_get_tickval(base) - 1,
> +			     xntbase_get_tickval(base), NULL);
> +}
> +
>  EXPORT_SYMBOL(xntbase_alloc);
>  EXPORT_SYMBOL(xntbase_free);
>  EXPORT_SYMBOL(xntbase_update);
> @@ -490,6 +496,7 @@ EXPORT_SYMBOL(xntbase_switch);
>  EXPORT_SYMBOL(xntbase_start);
>  EXPORT_SYMBOL(xntbase_stop);
>  EXPORT_SYMBOL(xntbase_tick);
> +EXPORT_SYMBOL(xntbase_ns2ticks_ceil);
>  
>  #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
>  
-- 
Philippe.



