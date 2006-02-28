Message-ID: <4404477B.2040102@domain.hid>
Date: Tue, 28 Feb 2006 13:52:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] negative values of latency/klatency
References: <440324EE.6030309@domain.hid> <440442FC.8090100@domain.hid>
In-Reply-To: <440442FC.8090100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org, Rudolf Marek <rudolf.marek@domain.hid>

Jan Kiszka wrote:
> Rudolf Marek wrote:
> 
>>Hello all,
>>
>>I tried the latency and klatency demo on some PPC procesor(s) (e500 and 60x) and the measurement results are rather strange.
>>I observed this with arbitrary version of Adeos/ipipe and on Xenomai 2.0.3 older 2.0.x too.
>>
>>-sh-3.00# ./run -- -T 10 -h -l 5
>>...
>>RTT|  00:00:01
>>RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
>>RTD|       -4525|       -4323|        5777|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1777|       0|       -4525|        5777
>>RTD|       -4525|       -4444|        -565|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1656|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1979|       0|       -4525|        5777
>>RTT|  00:00:06
>>RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
>>RTD|       -4525|       -4444|       -2020|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1050|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1616|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1898|       0|       -4525|        5777
>>RTD|       -4525|       -4444|       -1939|       0|       -4525|        5777
>>...
>>Well if I set scheduling latency from automatic "0" to "1" I get:
> 
> 
> 0 means automatic latency compensation (which does not seem to work that
> well here, it overcompensates),

Dynamic determination of the intrinsic latency during nucleus startup has been 
dropped some time ago (circa fusion 0.6.8), because it just did not provide 
accurate results. Since then, when 0 is specified in Kconfig, the value read from 
include/asm-*/calibration.h is substituted. In this case, 9500 ns are taken for a 
ppc32 platform, which is likely too high for this board. Setting ~4500 in Kconfig 
would better approximate the latency.

  while 1 effectively means "no
> hardware/software scheduling latency" (=> 1 ns). See also help of the
> related kernel configuration parameters.
> 
> 
>>-sh-3.00# ./run -- -T 10 -h -l 5
>>
>>RTT|  00:00:01
>>RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
>>RTD|        4767|        4929|       15191|       0|        4767|       15191
>>RTD|        4767|        4808|        8282|       0|        4767|       15191
>>RTD|        4767|        4808|        8080|       0|        4767|       15191
>>RTD|        4808|        4808|        7838|       0|        4767|       15191
>>RTD|        4767|        4808|        7272|       0|        4767|       15191
>>RTT|  00:00:06
>>RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat worst
>>RTD|        4808|        4808|        7555|       0|        4767|       15191
>>RTD|        4767|        4808|        7959|       0|        4767|       15191
>>RTD|        4767|        4808|        7393|       0|        4767|       15191
>>RTD|        4808|        4808|        7191|       0|        4767|       15191
>>RTD|        4767|        4808|        7313|       0|        4767|       15191
>>
>>Is this a bug or feature please? Can someone throw the light?
>>Good would be to print the units to the numbers too (ns).
>>
> 
> 
> That was likely a layout question of the latency tool's output. We could
> simply dump something like "All latencies in nanoseconds" during
> start-up. Would this be more helpful?
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

