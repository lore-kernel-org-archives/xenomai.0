Message-ID: <4A3CE75D.1050005@domain.hid>
Date: Sat, 20 Jun 2009 15:42:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1245495740.3498.8.camel@domain.hid>
In-Reply-To: <1245495740.3498.8.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Regarding enabling SMP with Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Shashank Bhatia <shashank.bhatia@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

Shashank Bhatia wrote:
> Dear All,
>               I have been trying to install Xenomai on my Dual Core
> Intel Machine. This CPU has 2 cores, so i wanted to enable the SMP flag
> in the kernel configuration.
> 
> I started with downloading kernel ver 2.6.25.11 from kernel.org, and got
> adeos patch as well as xenomai-2.4.7 downloaded. I used the
> prepare-kernel script for patching. 

These are outdated versions. Especially on x86, especially with SMP
configuration. So, please use the latest stable release of Xenomai
(xenomai-2.4.8), using the I-pipe patches it proposes. And we also would
be interested if you could test of the release candidate which has just
been released.

> 
> When i go to the make menuconfig. The real time subsystem section gives
> a meassage that either the HPET_TIMER must be turned off or
> X68_LOCAL_APIC must be turned off. 
> 
> After a lot of trials, i failed to find the options for turning of the
> X86_LOCAL_APIC flag. 

That is because SMP mode needs local APIC, so, if you want to disable
local APIC, you need to disable SMP. But I think you misunderstood the
message, the message is: "NOTE: Xenomai needs either X86_LOCAL_APIC
enabled or HPET_TIMER disabled.", so what you should do is disable
HPET_TIMER.

> 
> Then i went on to fiddle and do some trials. 
> 
> I tried with subarchitecture type PC compatible, and the Processor type
> to be Core2 or newer. The xenomai gets installed, but the latency i get

You should always choose the processor which you really have, this is in
the FAQ too.

> is really high. I am getting a maximum latency of around 30 us and even
> this is not constant. it varies a lot. 

30us is a bit high, but not that high. An SMI induced latency is
something larger than, say, 80us. You should try more recent releases to
see if you get better results.

> 
> After some googling i found that i must have the SMI workaround. 
> I enabled that and recompiled my kernel. But could not get good
> latencies still.

Why using Google? Xenomai documentation is available on Xenomai site.
The SMI option is described in an FAQ. And also in the TROUBLESHOOTING
option which comes with Xenomai sources.

-- 
					    Gilles.

