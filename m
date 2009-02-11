Message-ID: <49935B0A.7050706@domain.hid>
Date: Thu, 12 Feb 2009 00:11:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B3F8896E1733D4787DDB0EA1C7FF91F704A7F@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4B3F8896E1733D4787DDB0EA1C7FF91F704A7F@ukmail.uk.wirelessworld.airvananet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Massive improvement when Xenomai patched
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mike McTernan <mmcternan@domain.hid>
Cc: xenomai@xenomai.org

Mike McTernan wrote:
> Hi,
> 
> I've patched Blackfin uClinux 2008R1.5 with Adeos and Xenomai 2.4.6.1
> and started benchmarking our system.  At this point the apps are
> unmodified and I only change between a Xenomai enabled kernel and an
> unmodified kernel.  This is verified by checking the boot messages and
> the process list under /proc/xenomai/stats.
>

<snip>

> I made measurements over ~2000 sweeps on a scope with the unpatched and
> patched kernel, both when otherwise idle and then when under load.  To
> create load I execute the following line on a telnet session:
> 
>   $ while true; do ls -l /mnt; done
>   
> The results:
> 
>   Configuration                    Duration (uS)
>                            Min       Mean      Max
>   Vanilla                  9.9       16.8     30.8
>   Xenomai Kernel          19.0       27.5     50.4
>   Vanilla + load          10.9    11017.4  19619.7
>   Xenomai Kernel + load   59.4      215.5   1849.8
> 
> Clearly Xenomai appears to add some overhead to the interrupt handling
> and acknowledgement.  That's to be expected as the apps are executing in
> the secondary and the drivers are not RTDM, and the overhead is very
> small in anycase.
> 

As a matter of fact, on the Blackfin with I-pipe series <= 1.8, the IRQs are
threaded, which causes such overhead. This is no more the case since 1.9-00.

> But I don't understand why under load the scheduling of the non-Xenomai
> task is so much improved.  The worst case is more than x10 better, the
> average case x50.  It's incredible!
>

Beyond that, it's a clear violation of Murphy's law.

> Is this to be expected?
> 

I suspect the IRQ latency figures look better because the I-pipe lowers the
current interrupt priority much earlier than the original code does. Moving the
interrupt handlers over threads reflecting the interrupt priorities used to be
the way the I-pipe did this on Blackfin at the expense of more overhead.
Additionally, the I-pipe for 2.6.22/blackfin makes the kernel tick on TMR0
instead of the core timer (the latter is then dedicated to Xenomai), which may
have some impact depending on the priority value set for CONFIG_IRQ_TMR0.

Once your driver is RTDM-based and the IRQ hooked via rtdm_irq_request(), you
should see the worst-case latency drop below 60 us on a bf537, likely less than
45 us on a bf561. The extra bonus will then likely be due to the changes in
arch/blackfin/lib/ins.S. These PIO helpers are responsible for huge latency
spots in the vanilla implementation, particularly under significant network
load, and the I-pipe makes them preemptible by real-time IRQs, even if Linux
IRQs are still masked.

-- 
Philippe.

