Message-ID: <4D46C6CA.60602@domain.hid>
Date: Mon, 31 Jan 2011 15:27:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=7M-cqps4b--i6Kud3o6-awuntk2Zpwj7JHZ8a@domain.hid>	<1296469933.2214.35.camel@domain.hid>	<4D469437.9050902@domain.hid>	<1296471234.2214.38.camel@domain.hid>	<AANLkTikz2UuirubwC1oRQoXBRCqWS0xf3z__3mD60rCn@domain.hid>
	<4D469978.8010600@domain.hid>
In-Reply-To: <4D469978.8010600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is xenomai OK for early boot purpose ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gryma biloy <gryma.biloy@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> gryma biloy wrote:
>> On Mon, Jan 31, 2011 at 11:53 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On Mon, 2011-01-31 at 11:51 +0100, Gilles Chanteperdrix wrote:
>>>> Philippe Gerum wrote:
>>>>> On Mon, 2011-01-31 at 09:55 +0100, gryma biloy wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On a project running Linux on a beagle board, I'd like to add the
>>>>>> following capabilities to my platform :
>>>>>>   - real time processes with periodic tasks (10ms, 100ms & 200 ms) and
>>>>>> a low jitter (< 50 us)
>>>>> Kernel space apps then, likely. Userland apps (the recommended way)
>>>>> probably have a larger worst-case jitter on this hardware, albeit still
>>>>> below 100 us. Gilles?
>>>> Las time I checked, latency measured on a 720MHz omap3 was around 55us
>>>> with a 1ms period and 35us with a 100us period.
>>> Yeah, I suspect that longer periods ( >= 10 ms ) may introduce more
>>> opportunities for cache eviction due to linux activity, and therefore
>>> higher jittery, even if bounded.
>> Does this mean that the main reason for jittery is due to the cache ?
>> What would be the other reasons, if any ?
> 
> interrupt latency is mainly due to interrupts masking sections in the
> kernel, and the time to reach the code of the interrupt handler when an
> interrupt is received, including the time it takes to preempt current
> context to go to interrupt mode, then to access the hardware to mask/ack
> the interrupt.
> scheduling latency (of the higher priority task) is bound roughly by
> interrupt latency plus the time that it takes to switch context in
> kernel-space, plus the time that it takes to return to user-space.
> 
> All these paths are made of code which is executed and which access
> data, and so which execution time depend on both I-cache and D-cache.

In particular, things could be improved if we found a way to use the
SRAM on OMAP3, either for some critical code, or data, or both. This of
course, if you do not need the SRAM on OMAP3 (so, if you do not use the
hardware accelerated multi-media capabilities, I guess). I have this
idea in mind for some time, but never found time to try it. Probably
much easier for data than for code, though not impossible.

-- 
					    Gilles.

