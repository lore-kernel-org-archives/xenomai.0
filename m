Message-ID: <4624EDD6.1010902@domain.hid>
Date: Tue, 17 Apr 2007 17:55:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221038@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221038@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Perfs and rt alarms questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

RAKOTOSALAMA, Nirilanto wrote:
> 
>>>Hello everybody.
>>>
>>>I managed to compile a stable kernel (the Scalability O(1) 
>>
>>scheduler options seems to make my system freeze)
>>
>>That's not good. What precisely did you do? Applied the .config you
>>posted, just enabling CONFIG_XENO_OPT_SCALABLE_SCHED? And what test
>>case, latency?
> 
> 
> 
> I both tested a configuration with CONFIG_XENO_OPT_SCALABLE_SCHED enabled and an other disabled.
> When I enable and when I launch the cyclictest, the system hard lock and the 2 left keyboard leds blink.
> When I let it disabled the system is stable.
> 
> 
> 
>>>xenomai 2.3.1 and vanilla 2.6.20.4, gcc 4.1.1 on FC6.
>>>
>>>I'm programming and testing a xenomai support for a timer 
>>
>>library using rt_alarm. The test program
>>
>>>lauches the timer periodically and calculate the precision 
>>
>>(difference between theoretical and practical results).
>>
>>>When I launch the latency test, the max latency I have 
>>
>>doesn't exceed 10us. So I supposed the precision shouldn't 
>>
>>Using what load for the system? Keep in mind that unloaded benchmark
>>numbers are practically meaningless.
>>
>>
>>>exceed 10 to 20us as well, No ? But sometimes, the 
>>
>>precision exceed 30 to 60us. Is it normal ?
>>
>>Depending on your hardware (CPU, chipset, peripherals), this 
>>can be very
>>well a worst-case latency of the loaded system. Try to capture such a
>>result with the tracer 
> 
> 
> I've tested latency with loaded system (lot of applications loaded, dd, cp, tar, find /)and have a max latency of 339us.
> But I don't understand anything in the frozen trace file.

You likely have either an issue with SMI, or with X-window. Read the
TROUBLESHOOTING file.


-- 
                                                 Gilles Chanteperdrix

