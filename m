Message-ID: <43B3C5D9.50802@domain.hid>
Date: Thu, 29 Dec 2005 12:17:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.4.32 compilation error + old timer
	example	problem
References: <43B1F5CE.7030407@domain.hid> <43B27936.2000108@domain.hid>
	<43B303A8.7010903@domain.hid> <43B30DB0.3080104@domain.hid>
	<43B30F30.9000603@domain.hid> <43B31E6C.9040906@domain.hid>
In-Reply-To: <43B31E6C.9040906@domain.hid>
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Hannes Mayer wrote:
> Jan Kiszka wrote:
> [...]
> 
>> Yea, maybe that periodic timer mode is not compiled in and
>> rt_timer_start fails in your original example. I think it's off by
>> default now.
> 
> 
> Yeah, got it! Sorry for not supplying error code earlier!
> 
> In Xeno source:
> int xnpod_start_timer (u_long nstick, xnisr_t tickhandler)
> [...]
> #ifndef CONFIG_XENO_HW_PERIODIC_TIMER
>     if (nstick != XN_APERIODIC_TICK)
>         return -ENODEV; /* No periodic support */
> #endif /* CONFIG_XENO_HW_PERIODIC_TIMER */
> 
> ..and guess what: I got -ENODEV back on rt_timer_start!
> 
> In .config I have
> # CONFIG_XENO_HW_PERIODIC_TIMER is not set
> 
> So the puzzle is solved!
> 
> Just one question: what's the reason why the periodic mode
> is disabled by default ?
>

Because AFAICT, most people would rather use the aperiodic timing mode 
in usual configurations for a much better accuracy. Since the periodic 
mode uses the available hw PIT and programs it once (or even some 
decrementer but without handling the time drift when reprogramming it 
after each shot), it suffers from cumulated rounding errors of the 
period. If you look at the jitter results of a trivial periodic loop 
over a broad timescale, you will see the wakeup time irremediably drift, 
whilst the average interval between shots remains stable and reasonably 
accurate. The periodic timer should be used for configurations that only 
need to enforce delays or timeouts, and not, well, precise timings.

> Thanks & best regards,
> Hannes.
> 


-- 

Philippe.

