Message-ID: <447188F9.60905@domain.hid>
Date: Mon, 22 May 2006 11:48:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] timer optimisations
References: <44717FBA.1030207@domain.hid>
In-Reply-To: <44717FBA.1030207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
> Hi,
> 
> while I originally only wanted to add timer abstraction to RTDM, I now
> have patch series for xntimer pending on my box pushing this layer
> closer to hrtimer.
> 
> But before posting it for discussion (needs further testing anyway), I
> have two questions regarding some minor though not totally uninteresting
> optimisation possibilities:
> 
> 1. Is calling xntimer_start() with value=XN_INFINITE a real use case?
>    It's not documented explicitly. The effect of such an invocation
>    looks a bit like xntimer_stop(), but I didn't find a real caller so
>    far to asses it's relevance.

xnpod_start_timer() uses this property to start the host tick relay 
timer. If XNARCH_HOST_TICK is zero, then no relay is required, and the 
timer should remain passive.

> 
>    If it is not used and could rather be declared illegal, we could safe
>    the related code in the do_timer_start handlers.
> 

Dunno. To do that, we would need to carefully inspect each and every 
caller, especially for the various skins, which implies to analyze the 
requirements of the mimicked API too.

> 2. rthal_timer_program_shot() uses explicit rthal_local_irq_save_hw on
>    ia64 and i386. Given the head optimisation, IRQs should already be
>    disabled when calling this service. So, can this IRQ masking be made
>    depending on !CONFIG_XENO_OPT_PIPELINE_HEAD?
> 

Yes.

>    ARM uses an additional lock as well, but it's hidden inside the ipipe
>    patch and is likely required to remain independent of the caller's
>    properties.
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

