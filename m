Message-ID: <43B31E6C.9040906@domain.hid>
Date: Thu, 29 Dec 2005 00:23:24 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.4.32 compilation error + old timer
	example	problem
References: <43B1F5CE.7030407@domain.hid> <43B27936.2000108@domain.hid>
	<43B303A8.7010903@domain.hid> <43B30DB0.3080104@domain.hid>
	<43B30F30.9000603@domain.hid>
In-Reply-To: <43B30F30.9000603@domain.hid>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
[...]
> Yea, maybe that periodic timer mode is not compiled in and
> rt_timer_start fails in your original example. I think it's off by
> default now.

Yeah, got it! Sorry for not supplying error code earlier!

In Xeno source:
int xnpod_start_timer (u_long nstick, xnisr_t tickhandler)
[...]
#ifndef CONFIG_XENO_HW_PERIODIC_TIMER
     if (nstick != XN_APERIODIC_TICK)
         return -ENODEV; /* No periodic support */
#endif /* CONFIG_XENO_HW_PERIODIC_TIMER */

..and guess what: I got -ENODEV back on rt_timer_start!

In .config I have
# CONFIG_XENO_HW_PERIODIC_TIMER is not set

So the puzzle is solved!

Just one question: what's the reason why the periodic mode
is disabled by default ?

Thanks & best regards,
Hannes.

