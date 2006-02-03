Message-ID: <43E31EE0.8020808@domain.hid>
Date: Fri, 03 Feb 2006 10:14:08 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>	<43E30B8D.6030507@domain.hid>
	<43E31186.1000007@domain.hid>
In-Reply-To: <43E31186.1000007@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> ...and may also add further latencies with the system has to speed up
> again. Anyway, there might be use-cases where power consumption is -
> besides latency - also an important issue. I'm just thinking of our
> smaller mobile robots where the power demand of the drives and the
> controller are not that far apart as on the larger platforms.
> 
> What about other time sources on x86? Which systems already have HPET
> these days, and does this source not suffer from frequency scaling? I
> once read that HPET is quite easy to program, is this true? IOW, would
> it be worth considering to add this to the HAL?
If it an computer with ACPI (which is very likely), one could use the PM Timer 
(3.579545 MHz) as the base system clock, and sync with TSC at every clockscaling 
and power events (the reason for that is that PM Timer reads  are quite slow 
(around 1 microsecond on the hardwares I have tested), so most timer stuff 
should go via TSC).

The advantage with this is that the system will keep accurate time even in the 
low power modes (when TSC is turned off). I have done a crude implementation of 
this on KURT (http://www.ittc.ku.edu/kurt/), and it is a workable solution

There are also good research/development oppurtunities in:

   1. scheduling ACPI wakeup from those low-power modes in such good
      time that all realtime requirements are met :-)
   2. scheduling of clockscaling changes to make minimum impact
      on realtime tasks

(For ACPI, see http://www.acpi.info/DOWNLOADS/ACPIspec30a.pdf)

-- 

Regards

Anders Blomdell

