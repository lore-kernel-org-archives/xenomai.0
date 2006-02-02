Message-ID: <43E28EE8.3020103@domain.hid>
Date: Thu, 02 Feb 2006 23:59:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>
In-Reply-To: <43E288AA.3050203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org


Hi Jim,

Jim Cromie wrote:
> 
> some random sucesses ..
> 
> Ive been running an ipipe kernel as the default since shortly after 1/7.
> Since then, Ive had a couple of freezes on boot,
> and sometimes bash's auto-complete takes longer to complete,

Eh? Maybe the CONFIG_PCI_MSI syndrom again?

> but other than that, things have been solid.
>
> But that kernel wasnt configured using scripts/prepare-kernel.sh,
> so was missing the xeno_* modules.
> 

<snip>

> RTS|       -4814|       -4583|       -2582|       0|    00:02:00/00:02:00
> 
> 
> This was run on a pentium-M laptop,
> with cpu-clock running at 600 MHz, (capable of 1.7 GHz)
> I presume this might explain the negative latancies.
> Im aware this is un-supported ..
> 

The negative values are just there because even at 600Mhz, the timing anticipation 
applied by the nucleus to compensate for the intrinsic latency of the box is too 
high; i.e. the nucleus performs a bit too well latency-wise, so the anticipated 
timer ticks end up being a bit early on schedule. IOW, all is fine. Given the 
figures above, you could probably reduce the anticipation factor by setting the 
CONFIG_XENO_HW_SCHED_LATENCY (Machine menu) parameter to, say, 2500 nanoseconds 
(the default null value tells the nucleus to use the pre-calibrated value, which 
might be higher than this for your setup).

Btw, I'm not sure if you enabled the local APIC in your kernel config; if you did 
not, you should: there is no reason to keep using the braindamage 8254 PIT when a 
LAPIC is available with your CPU.

> The only thing that looks wrong is the test-duration.
> I asked for 120 sec, it gave me 40 samples.
> The test did take 120 to run.
> 

You should disable the ACPI support if enabled, and especially everything related 
to the CPUfreq scaling and power suspend.

-- 

Philippe.

