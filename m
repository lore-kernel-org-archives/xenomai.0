Message-ID: <455AD828.4040801@domain.hid>
Date: Wed, 15 Nov 2006 10:04:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Don't call __ipipe_mach_set_dec in
	rthal_timer_release directly
References: <E1Gjcbu-0006ZA-4a@domain.hid> <4559FA51.6050002@domain.hid>
	<E1GkGSD-0007Z8-0a@domain.hid>
In-Reply-To: <E1GkGSD-0007Z8-0a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
> 
>>Sebastian Smolorz wrote:
>>
>>>Hi,
>>>
>>>here's a proposal for a minor change in the I-pipe implementation for
>>>ARM. Since it is required for my S3C24xx patch not to call
>>>__ipipe_mach_set_dec directly when the timer is released by the Xenomai
>>>domain I suggest the following changes. The patch comprises the necessary
>>>modifications for PXA, SA1100 and Integrator, too.
>>>
>>>Comments or objections?
>>
>>Why can not you call __ipipe_mach_set_dec directly when the timer is
>>released ?
> 
> 
> The timer used for generating interrupts operates in auto-reloading mode when 
> it is under Linux control. But when Xenomai reloads the timer the mode of 
> operation is one-shot (auto-reload feature in hardware is off). So I have to 
> make a distinction between setting the dec value by Xenomai for programming 
> the next period and setting the dec value to __ipipe_mach_ticks_per_jiffy 
> when the timer control is given back to Linux.
> 
> The reason for this is the fact that programming a timer on the S3C24xx can 
> take some ticks which means that these ticks aren't count whereas time is 
> going on in the real world. So it is more reasonable to let the timer reload 
> itself when Xenomai hasn't started it. Setting __ipipe_mach_ticks_per_jiffy 
> in the Linux interrupt handler would make every period last some ticks 
> longer.

You can avoid this problem by adding LATCH or
__ipipe_mach_ticks_per_jiffy to the current value of the match register
in the timer interrupt, as it is done for the SA and PXA architectures.

-- 
                                                 Gilles Chanteperdrix

