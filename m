From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46DD59D9.9010003@domain.hid>
References: <46DD59D9.9010003@domain.hid>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 15:54:14 +0200
Message-Id: <1188914054.28092.137.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Make watchdog-timer configurable
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-09-04 at 15:12 +0200, Johan Borkhuis wrote:
> I made the following change to Xenomai (version 2.3.2, but it could also 
> be applied to 2.4 as the watchdog code has not been changed).
> 
> The watchdog timeout is fixed at 4 seconds. For us this is a problem as 
> there are some processes that take more time than this.
> 
> I made the following change to allow this to be changed through the 
> Linux kernel configuration. The value is configurable between 1 and 60 
> seconds.
> 
> Below is a patchfile that implements this change. Please let me know if 
> you have comments on this, or if there are problems with this change.
> 

Looks good. Will merge, thanks.

> ================
> diff -u -r org/xenomai-2.3.2/ksrc/nucleus/Kconfig 
> xenomai-2.3.2/ksrc/nucleus/Kconfig
> --- org/xenomai-2.3.2/ksrc/nucleus/Kconfig      2007-07-06 
> 18:42:14.000000000 +0200
> +++ xenomai-2.3.2/ksrc/nucleus/Kconfig  2007-09-04 14:13:41.000000000 +0200
> @@ -172,6 +172,17 @@
>         behalf of the timer tick handler, thus is only active after
>         the timer has been started.
>  
> +config XENO_OPT_WATCHDOG_PERIOD
> +       depends on XENO_OPT_WATCHDOG
> +       int "Watchdog period (s)"
> +       default 4
> +    range 1 60
> +       help
> +
> +    Nr of seconds of uninterrupted real-time activity after which
> +    the watchdog triggers.
> +
> +
>  menu "Timing"
>  
>  config XENO_OPT_TIMING_PERIODIC
> diff -u -r org/xenomai-2.3.2/ksrc/nucleus/pod.c 
> xenomai-2.3.2/ksrc/nucleus/pod.c
> --- org/xenomai-2.3.2/ksrc/nucleus/pod.c        2007-07-07 
> 10:18:57.000000000 +0200
> +++ xenomai-2.3.2/ksrc/nucleus/pod.c    2007-09-04 14:06:35.000000000 +0200
> @@ -2925,7 +2925,7 @@
>         return nkpod->svctable.faulthandler(fltinfo);
>  }
>  
> -#ifdef CONFIG_XENO_OPT_WATCHDOG
> +#if (defined CONFIG_XENO_OPT_WATCHDOG) && 
> (CONFIG_XENO_OPT_WATCHDOG_PERIOD > 0)
>  
>  /*!
>   * @internal
> @@ -2948,7 +2948,7 @@
>                 return;
>         }
>  
> -       if (unlikely(++sched->wd_count >= 4)) {
> +       if (unlikely(++sched->wd_count >= 
> CONFIG_XENO_OPT_WATCHDOG_PERIOD)) {
>                 xnltt_log_event(xeno_ev_watchdog, thread->name);
>                 xnprintf("watchdog triggered -- killing runaway thread 
> '%s'\n",
>                          thread->name);
> 
> ================
> 
> Kind regards,
>     Johan Borkhuis
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



