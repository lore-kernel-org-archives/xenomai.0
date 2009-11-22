Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4B096FC0.9030808@domain.hid>
Message-ID: <4B096FA2.1000600@domain.hid>
Date: Sun, 22 Nov 2009 18:06:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580911161827y4926a14fm1facd405efa44ba4@domain.hid>
	<4B026454.9080604@domain.hid>
	<1f3e02580911182130v4872251eic97a99cf81a449e2@domain.hid>
In-Reply-To: <1f3e02580911182130v4872251eic97a99cf81a449e2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Patch to support ARM_MV
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sergey Didenko <didenkos@domain.hid>

Sergey Didenko wrote:
>> In __ipipe_mach_demux_irq, you must call ipipe_handle_irq, not
>> desc_handle_irq.
> 
> 
> I hope you mean __ipipe_handle_irq

Yes.

> 
> ipipe_mach_get_tscinfo also needs fixing (type should be
>> IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN,
> 
> 
> file ipipe.h (arch\arm\include\asm) has next defines
> 
> #define IPIPE_TSC_TYPE_NONE       0
> #define IPIPE_TSC_TYPE_FREERUNNING 1
> #define IPIPE_TSC_TYPE_DECREMENTER 2
> 
> you mean i have to use IPIPE_TSC_TYPE_DECREMENTER or I have to define
> IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN as 3 and use it?

Yes, please do that.

> 
> 
>> and counter should be set to timer0's physical address, not virtual address
> 
> Ok, for my board it is same...naming problem

That is a bit surprising, did you test the user-space tsc emulation?



-- 
					    Gilles.


