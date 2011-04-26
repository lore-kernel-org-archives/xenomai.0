Message-ID: <4DB6AB8E.2070000@domain.hid>
Date: Tue, 26 Apr 2011 13:25:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>	<20110409185503.GB11908@domain.hid>	<4DA0B580.4070602@domain.hid>
	<4DA0B878.9010106@domain.hid>	<20110410065250.GA28869@domain.hid>	<4DA192E0.2090802@domain.hid>	<20110414164248.GA4725@domain.hid>	<4DA846FF.5040204@domain.hid>
	<4DB11857.4030604@domain.hid>	<4DB484C4.6040204@domain.hid>	<20110425064852.GA3700@domain.hid>
	<4DB522F0.3090705@domain.hid>
In-Reply-To: <4DB522F0.3090705@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
>> On Sun, Apr 24, 2011 at 10:15:00PM +0200, Gilles Chanteperdrix wrote:
>>> some temporary results on the benchmark here:
>>> http://www.xenomai.org/~gch/latency-at91sam9263.png
>>>
>>> The worst case latency seems not to vary much over time, it looks like
>>> it is decreasing a bit, but the differences may well be in the
>>> measurement noise. Unlocked context switch actually improves the latency.
>>>
>>> I will update the png as I get new results.
>> Gilles,
>>
>> That is a very interesting graph. It might be nice to have a
>> "performance benchmarks" page on the wiki, including that figure, plus
>> the description of the test setup. I can contribute IXP and some
>> PowerPC results.
> 
> Yes, we should set this up. The xeno-test currently in the head branch
> is made to help doing this.
> 
>> Regarding the measured performance, the graphs are shaped like the
>> letter, H (or like a Bactrian camel, with two humps).
>>
>> I appears to me that the peaks of the 2.4.10 lines (red, green) are
>> standing clearly to the left of the 2.5.6 lines (blue, purple), by
>> about 10 microseconds. I would say that 2.4.10 outperforms 2.5.6, on
>> average.
> 
> I added the average latencies (except for 2.4.10 with the I-pipe 1.14-04
> patch). The peak corresponds roughly to the average "lat max" column in
> latency results.
> 
> Both the I-pipe version and Xenomai version seem to contribute to the
> increased average latency.
> 
> The unlocked context switch also improves the worst-case at the expense
> of the average.
> 
> But there is hope, 2.6.33-1.18-03 introduces pic muting and re-enables
> irq in the middle of gpio demuxing, which seems to improve the average
> latency.

Hi Richard,

I jumped to conclusions too quickly. I am not sure the results I obtain
really are meaningful. I am probably not doing it enough rigorously.

Regards.

-- 
                                                                Gilles.

