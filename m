Message-ID: <43562C36.1090609@domain.hid>
Date: Wed, 19 Oct 2005 13:21:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E30@domain.hid>
	<4356274A.5010004@domain.hid>
In-Reply-To: <4356274A.5010004@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Fillod Stephane wrote:
> 
>> Wolfgang Grandegger wrote:
>> [...]
>>
>>>> Load for klatency/latency was ping flooding on FCC (piece of cake),
>>>> and cache calibrator. IMHO, we can do nastier.
>>>
>>>
>>> You mean the cache calibrator from http://monetdb.cwi.nl/Calibrator/? I
>>> tried it on my Ocotea board and it increased the max latency for 25 to
>>> 30 us.
>>
>>
>>
>> Yes, that very one. In this case, it has been used as a cache trashing
>> load generator. But IMHO, this Calibrator should be better used in the
>> Benchmarking Plan to get L1/L2/RAM access latency figures (w/o RT
>> running),
>> and offer one more correlation against RT latency results.
>>
>> We can afford a better cache trashing load generator. Earlier this year,
>> I proposed flushy(tm) [1], but as Philippe suggested, we can do better.
>> Flushy should be rewritten as an ADEOS layer, inserted just in front 
>> of Xenomai in the pipeline. This way, we would be sure the caches
>> are dead cold when Xenomai enter its domain. Using tools like OProfile,
>> it should be possible then to track cache misses, and fix them by 
>> prefetching, where available.
>>
>> [1] http://rtai.dk/cgi-bin/gratiswiki.pl?Latency_Killer (bottom of page)
>>
>>
>> Here is the result of my 1.0-01 tests on e500:
>>
>> $ cat /proc/ipipe/version
>> 1.0-01
>>
>> SWITCH without load:
>> RTH|     lat min|     lat avg|     lat max|        lost
>> RTD|        3660|        3690|        8070|           0    1.0-00
>> RTD|        4620|        4740|        8730|           0    1.0-01
>>
>> KLATENCY with load:
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
>> RTS|       -7350|       -5715|        6420|       0|    00:03:17 1.0-00
>> RTS|       -6150|       -4384|       12180|       0|    00:03:13 1.0-01
>>
>> LATENCY with load:
>> == Sampling period: 100 us
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
>> RTS|       -6930|       -4260|        8700|       0|    00:08:06 1.0-00
>> RTS|       -5670|       -4620|       12930|       0|    00:12:39 1.0-01
>>
>> That's weird. Figures are worse, but since the load (ping -f +
>> calibrator)
>> was executed manually, it may not be the same.
>>
> 
> Ok, I now suspect that another change regarding the size of the 
> interrupt counters made this worse. I'm going to revert it and upload 
> -02, just to make sure.
> 

http://download.gna.org/adeos/patches/v2.6/adeos/ppc/adeos-ipipe-2.6.13-ppc-1.0-02.patch

-- 

Philippe.

