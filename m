Message-ID: <44046AC9.2050601@domain.hid>
Date: Tue, 28 Feb 2006 16:22:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <440324EE.6030309@domain.hid> <440442FC.8090100@domain.hid>
	<44045A6D.7000508@domain.hid>
In-Reply-To: <44045A6D.7000508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] negative values of
	latency/klatency
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
Cc: xenomai@xenomai.org, Rudolf Marek <rudolf.marek@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Rudolf Marek wrote:
>>
>>>...
>>>RTT|  00:00:01
>>>RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
>>>RTD|        4767|        4929|       15191|       0|        4767|       15191
>>>RTD|        4767|        4808|        8282|       0|        4767|       15191
>>>RTD|        4767|        4808|        8080|       0|        4767|       15191
>>>RTD|        4808|        4808|        7838|       0|        4767|       15191
>>>RTD|        4767|        4808|        7272|       0|        4767|       15191
>>>RTT|  00:00:06
>>>RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
>>>RTD|        4808|        4808|        7555|       0|        4767|       15191
>>>RTD|        4767|        4808|        7959|       0|        4767|       15191
>>>RTD|        4767|        4808|        7393|       0|        4767|       15191
>>>RTD|        4808|        4808|        7191|       0|        4767|       15191
>>>RTD|        4767|        4808|        7313|       0|        4767|       15191
>>>
>>>Is this a bug or feature please? Can someone throw the light?
>>>Good would be to print the units to the numbers too (ns).
>>>
>>
>>That was likely a layout question of the latency tool's output. We could
>>simply dump something like "All latencies in nanoseconds" during
>>start-up. Would this be more helpful?
>>
> 
> 
> The output of latency is indeed inconsistent. Histogram and stats are
> printed in microseconds, intermediate and overall latencies go out as
> nanoseconds. Anyone any objections to switch to micros with 3 digits
> after the decimal point? Patch is ready to be applied.

Let's roll.

> 
> == Sampling period: 150 us
> == Test mode: in-kernel timer handler
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 150 us period)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|       8.935|      13.824|      39.951|       0|       8.935|
> 39.951
> RTD|       8.998|      14.619|      36.867|       0|       8.935|
> 39.951
> RTD|       8.576|      14.604|      37.417|       0|       8.576|
> 39.951
> RTD|       3.018|      14.623|      40.466|       0|       3.018|
> 40.466
> [grabbed on a low-end board]
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

