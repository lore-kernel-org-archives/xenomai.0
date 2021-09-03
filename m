References: <8527a092ed7e2665d92a787e4f3eabf5b0987a55.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: IRQ_PIPELINE: TSC marked as unstable
In-reply-to: <8527a092ed7e2665d92a787e4f3eabf5b0987a55.camel@siemens.com>
Date: Fri, 03 Sep 2021 10:33:07 +0200
Message-ID: <87y28e6ou4.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>


Bezdeka, Florian <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> I'm able to reproduce the following on two different platforms now, so
> I assume it's a IRQ_PIPELINE generic issue:
>
> Platform A):
> Intel(R) Xeon(R) CPU D-1518 @ 2.20GHz
> 1 Socket, 4 Cores, 1 thread per core
>
> Platform B):
> Intel(R) Xeon(R) CPU E5-2620 0 @ 2.00GHz
> 2 Sockets, 6 cores per socket, 2 threads per core
> (2 NUMA nodes)
>
>
> Platform A) reports the TSC being unstable during the boot phase,
> platform B) reports the TSC as unstable when running stress tests:
>
> Taken from a B) based system:
>
> [57615.671114] clocksource: timekeeping watchdog on CPU17: Marking clocksource 'tsc' as unstable because the skew is too large:
> [57615.738269] clocksource:                       'hpet' wd_now: 12f85ed0 wd_last: 2c5eab7b mask: ffffffff
> [57615.794489] clocksource:                       'tsc' cs_now: 68e299c3708c cs_last: 6864c6ea3970 mask: ffffffffffffffff
> [57615.858552] tsc: Marking TSC unstable due to clocksource watchdog
> [57615.858582] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> [57615.910138] sched_clock: Marking unstable (57615104375773, 749891156)<-(57616072553488, -213973554)
> [57615.905983] clocksource: Checking clocksource tsc synchronization from CPU 15.
> [57615.949626] clocksource: Override clocksource tsc is unstable and not HRT compatible - cannot switch while in HRT/NOHZ mode
> [57616.016343] clocksource: Switched to clocksource hpet
>
> The clocksource watchdog is migrated between CPUs to make sure the TSC
> is synchronized between cores. For me it looks like a late delivery of
> the watchdog timer.
>
> Available workaround(s):
> - Add "tsc=reliable" to the kernel cmdline args
> - At least for A) based systems it helped to apply the following diff to the kernel
>   configuration. I do not consider that as "solution" for now.
>
> -CONFIG_HZ_100=y
> +CONFIG_HZ_1000=y
>
>
> As soon as I disable CONFIG_IRQ_PIPELINE the problem is gone.
>
> I already tried testing with CONFIG_DEBUG_IRQ_PIPELINE enabled, but
> that didn't help so far.
>
> Any advise how to debug that?
>
> Best regards,
> Florian

Could this be related [1] (HPET stanza)?

[1] https://evlproject.org/core/caveat/#x86-caveat

-- 
Philippe.

