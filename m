Message-ID: <46488A61.6090709@domain.hid>
Date: Mon, 14 May 2007 18:12:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1178268043.5391.47.camel@domain.hid>		<463B086B.6060402@domain.hid>
	<463B5E27.7050408@domain.hid>	<1179137384.4820.31.camel@domain.hid>
	<464839C8.8060304@domain.hid> <46488839.4060801@domain.hid>
In-Reply-To: <46488839.4060801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latencies while ethernet access
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Let us get the tracer right.
>>...
> 
> 
> And here is the issue already when having a second look:
> 
> 
>>/ # cat /proc/ipipe/trace/frozen 
>>I-pipe frozen back-tracing service on 2.6.19.2/ipipe-1.6-04
>>------------------------------------------------------------
>>Freeze: 9187269471 cycles, Trace Points: 30 (+10)
>>Calibrated minimum trace-point overhead: 3.000 us
>>
>> +----- Hard IRQs ('|': locked)
>> |+---- <unused>
>> ||+--- Xenomai
>> |||+-- IShield
>> ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
>> |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10 us)
>> |||||                        |        +- NMI noise ('N')
>> |||||                        |        |
>>      Type    User Val.   Time    Delay  Function (Parent)
>>:| #  begin   0x80000001  -190+   4.250N __ipipe_mach_get_tsc+0x48 (xntimer_do_tick_aperiodic+0x40)
> 
> 
> __ipipe_mach_get_tsc() must never pop up in trace, it has to be marked
> "notrace". I guess you ported that service for your board? Please fix
> and retry the test.

This has only be fixed very recently, version 1.6-04 of the I-pipe patch
for ARM makes use of plain local_irq_save_hw/local_irq_restore_hw, which
causes the NMI noise.

-- 
                                                 Gilles Chanteperdrix

