Message-ID: <4D4A80F6.5020600@domain.hid>
Date: Thu, 03 Feb 2011 11:18:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>	<4D49CF24.9080700@domain.hid>	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>	<4D49D608.5020006@domain.hid>
	<AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>
In-Reply-To: <AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] I-pipe clock source change and MMC issues (AT91)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: at91_enthus <nwromania@domain.hid>
Cc: xenomai@xenomai.org

at91_enthus wrote:
> On Wed, Feb 2, 2011 at 4:09 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> at91_enthus wrote:
>>>
>>> On Wed, Feb 2, 2011 at 3:39 PM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org
>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>>>
>>>     at91_enthus wrote:
>>>     > Hi.
>>>     >
>>>     > In order to get better accuracy with Xenomai, I modified the I-pipe
>>>     > timebase (MCK divider) in arch/arm.mach-at91/at91_ipipe_time.c.
>>>     > Unfortunately, I cannot mount the rootfs on the MMC, since the MMC
>>>     > controller is no longer functioning. I tried to change TCx in
>> kernel
>>>     > configuration to no avail.
>>>     > When I switch back to a timebase of 1 MHz, the MMC works fine.
>>>
>>>     The thing is that we are a bit tight on AT91. A 16 bits counter is
>> used
>>>     for both the timer and the tsc emulation, and this tsc must be
>> refreshed
>>>     at least once before it wraps. The problem is that since it is a 16
>> bits
>>>     counter, it wraps really fast, on my AT91SAM9263 it wraps in 20 ms,
>> and
>>>     since the Linux default period is 10ms we are actually quite close to
>>>     the limit.
>>>
>>>     Anyway, trying to get a better accuracy than 1us is kind of useless
>> on
>>>     AT91, since even reading this counter takes more than 1us. So, you
>> are
>>>     not in fact improving anything. The 1MHz is even a bit overkill.
>> On the other hand, the AT91SAM9G20 may be running at a better frequency.
>> But with latencies in the order of tens of microseconds, having a better
>> accuracy than 1us still does not make really much sense.
> 
> 
> 
> 
>> Why do you need
>> this accuracy?
>>
> 
> I want to time stamp the samples from a 8 channel SPI-based ADC. I know that
> a conversion takes between 3 and 5 microseconds depending on the SPI clock.
> What I want is to adapt the code to acquire a fixed number of samples in
> user space (I knew it was a long shot). Plain, Xenomai-free, userland
> application was out of the question, so I figured that a userspace
> application in Xenomai run at highest priority should do the trick.
> 
> On a second thought, a simple linux kernel module is what I want (this way I
> can use interrupts and one of the platform's six timers).

You can use interrupts and the platform's six timers in a Xenomai driver
based on the RTDM skin. The thing is, what interrupt latency is your target?

-- 
					    Gilles.

