Message-ID: <50105A22.3090704@xenomai.org>
Date: Wed, 25 Jul 2012 22:42:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>	<5009A292.4060508@grandegger.com>	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
	<501028DC.8000803@xenomai.org> <50102E8D.1040004@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8E07@KEMPMAIL2.woodward.com>
In-Reply-To: <CE2E43470FE5444A811B580382FE5EDF2113EA8E07@KEMPMAIL2.woodward.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/25/2012 10:15 PM, Lukasz Zemla wrote:

> 
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Wednesday, July 25, 2012 7:36 PM
>> To: Lukasz Zemla
>> Cc: Xenomai@xenomai.org
>> Subject: Re: [Xenomai] Xenomai installation on P1020RDB
>>
>> On 07/25/2012 07:11 PM, Gilles Chanteperdrix wrote:
>>
>>> On 07/25/2012 06:18 PM, Lukasz Zemla wrote:
>>>
>>>> I tried to install Xenomai on 3.2.21 - it boots, but waits about 76
>> seconds after initialization of first eth0 controller:
>>>>
>>>> 	[    0.905820] fsl-gianfar ethernet.1: eth0: TX BD ring size for
>> Q[7]: 256
>>>> 	[   77.451135] fsl-gianfar ethernet.2: eth1: mac:
>> 00:04:9f:02:2d:11
>>>>
>>>> There is no delay between eth1 and eth2.
>>>>
>>>> The vanilla 3.2.21 does not have any delays - it initializes eth0,
>> eth1, eth2 immediately.
>>>>
>>>> [...]
>>>
>>>
>>> It is very much likely a timer issue. At the time it happens, is
>>> xenomai started ?
>>>
>>
>>
>> Also, it would be interesting to know a bit more about your kernel
>> configuration, at least whether the following options are enabled:
>> CONFIG_HIGH_RES_TIMERS
>> CONFIG_NO_HZ
>> CONFIG_XENO_OPT_WATCHDOG
>>
>> If the first two are on and the third is off, try the following patch:
> 
> The Xenomai is running at that time. 
> [    0.385023] type=2000 audit(0.324:1): initialized
> [    0.389902] I-pipe: head domain Xenomai registered.
> [    0.394795] Xenomai: hal/powerpc started.
> [    0.398762] Xenomai: scheduling class idle registered.
> [    0.403848] Xenomai: scheduling class rt registered.
> [    0.415567] Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
> [    0.422217] Xenomai: debug mode enabled.
> [    0.426434] Xenomai: starting native API services.
> [    0.431160] Xenomai: starting POSIX services.
> [    0.435609] Xenomai: starting RTDM services.
> [    0.448964] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> 
> Here are the values of mentioned parameters:
> 	CONFIG_HIGH_RES_TIMERS=y
> 	CONFIG_NO_HZ=y
> 	CONFIG_XENO_OPT_WATCHDOG=y
> 	CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
> 

> The third one is on, eventually I could try patch, but I'll have

> access to hardware in the morning (I'm working in Europe).


No, the patch is probably needed for correctness, but will not solve the
issue you observe (with the watchdog on, there is always a timer
running, so, the decrementer is always programmed by xenomai).

What you can try is:
- putting a printk in __ipipe_grab_timer (say, print a dot every HZ ticks)
- and a similar printk in the "timer_interrupt" in
arch/powerpc/kernel/time.c

Now run the kernel and see if the two of them are ticking during the 76s
period.

-- 
                                                                Gilles.

