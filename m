Message-ID: <44361D46.9080003@domain.hid>
Date: Fri, 07 Apr 2006 10:05:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] nkpod->watchdog_trigger per CPU?
References: <44361837.9080206@domain.hid>
In-Reply-To: <44361837.9080206@domain.hid>
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
> analysing the watchdog characteristics in our scenarios, I just wondered
> if it is SMP-aware (we have no SMP in use, it's a pure analytical concern).
> 
> The watchdog timeout is stored system-wide in nkpod->watchdog_trigger,
> but it is based on a per-CPU clock (TSC). Is the tick IRQ bound to a
> specific CPU in SMP scenarios so that this doesn't matter? Or am I just
> overseeing some detail?
> 

Good catch. This code was written before per-CPU ticking became the 
"official" implementation, so it needs to be updated.

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

