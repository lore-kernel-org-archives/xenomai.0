Message-ID: <cbe23c50702120058s2bf042d0o95bb1a69997e921a@domain.hid>
Date: Mon, 12 Feb 2007 09:58:34 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] Multiple NIC trouble
In-Reply-To: <45CCA96C.7080605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
	<17864.63903.244809.994959@domain.hid>
	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>
	<45C9B7C4.8050705@domain.hid>
	<cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>
	<45CB4291.408@domain.hid>
	<cbe23c50702090849i3bfff5a0j64acbcd58163f880@domain.hid>
	<45CCA96C.7080605@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

2007/2/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Maybe you should enable kernel debugging and xenomai debugging. If I
> were you, I would reserve the console for error logging, I would not use
> it to log in.
>
> From your logs, there is one thing you should try first: disable HPET
> timer, since the box seems to have one and it is used by Linux, and
> there is no support whatsoever of the HPET timer by Xenomai.

Bingo,

I disable HPET and xeno-test now runs just fine with no hang at all.

>>>>>>>>>
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       3.346|       3.622|      13.130|       0|       3.346|      13.130
RTD|       3.352|       3.626|      12.365|       0|       3.346|      13.130
RTD|       3.352|       3.629|      12.533|       0|       3.346|      13.130
RTD|       3.342|       3.625|      11.598|       0|       3.342|      13.130
>>>>>>>>>>

Thanks to all of us for this bug hunt.

I've just added CONFIG_HPET and CONFIG_HPET_TIMER to
"should be avoided?" kernel option in the Wiki FAQ:
http://www.xenomai.org/index.php/FAQs#Installation_and_Setup

I don't know much about Kconfig syntax but I think it should be
useful to add explicit warnings when HPET_xxx are enabled
just as you do with APM, CPU_FREQ etc...

I located this in linux/init/Kconfig
and would try something like:

comment "WARNING! You enabled HPET timer support "
        depends on HPET || HPET_TIMER
comment "option. These options are known to cause troubles with Xenomai."
        depends on HPET || HPET_TIMER

I may try to re-enable MSI in order to see if its OK without HPET
but with MSI.

Thanks again.
-- 
Erk

