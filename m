Message-ID: <439411B5.7030708@domain.hid>
Date: Mon, 05 Dec 2005 11:08:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] i386 2.4 backport performing (too?) well
References: <Pine.LNX.4.63.0512021139500.2791@domain.hid>
	<43904AE7.4090002@domain.hid>
	<Pine.LNX.4.63.0512051002430.4132@domain.hid>
In-Reply-To: <Pine.LNX.4.63.0512051002430.4132@domain.hid>
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
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

Klaas Gadeyne wrote:
> On Fri, 2 Dec 2005, Philippe Gerum wrote:
> 
>> Klaas Gadeyne wrote:
> 
> [...]
> 
>>> For comparison, on the same hardware platform: - the RTAI 
>>> lxrt-latency on rtai 3.0r5 (adeos oldgen r18c1
>>>   patch for 2.4.31 also) test reports 38 usec
>>> - the latency test of xenomai 2.01 running on a 2.6.14-ipipe-1.0-10
>>>   kernel resulted in a latency of 80 usec.
>>
>>
>> 80 us on 2.6 is clearly pathological if 2.4 gives 30 us. All tests 
>> using 2.6.14-1.0-10 on dual SMP 750Mhz and 2.8Ghz, Geode 266 Mhz, 
>> Celeron 1Ghz, Centrino 1.6 Mhz and Pentium 90Mhz show a slight 
>> advantage for 2.4 over 2.6 (1-3%), but still in the error margin, I 
>> think. Maybe some option is enabled in your 2.6 configuration that 
>> might trigger this very high value?
> 
> 
> I rechecked the 2.6 config.  Apart from the lapic option, which I
> couldn't enable with xenomai [*], I can't see something obvious that I
> would have missed.  I'm sending you the config file in private.
> 
> Note that I haven't tested the 2.6 kernel with xenomai-trunk yet though...
> 
> thx,
> 
> Klaas
> 
> [*] When enabling local apic in the kernel configuration and booting
> with the lapic option, I get
> 

> Disable APIC support or pass "lapic" as boot param.
> 

lapic=1 on your boot line. This is not a Xeno issue, but a Linux kernel 
requirement. Using the local APIC is even recommended when available on 
your hw with Xeno.

> while loading xeno_hal.
> 
> 
> 


-- 

Philippe.

