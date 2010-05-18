Message-ID: <4BF28B0C.3080705@domain.hid>
Date: Tue, 18 May 2010 14:41:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF251EC.7040605@domain.hid> <4BF267D3.4040500@domain.hid>
	<4BF28401.6060503@domain.hid>
In-Reply-To: <4BF28401.6060503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
>> - gettimeofday should not have another timebase than
>> clock_gettime(CLOCK_REALTIME): in other word, the whole clock system
>> should be based on the ntp clock.
> Sorry, I'm not quite sure what you are talking about here. The NTP
> corrections are provided for the clock offered in the vsyscall page
> by Linux, so the clock is based on the NTP clock, isn't it? Or
> am I misparsing your statement?

Unless I misunderstood your patch, what you provide is:
gettimeofday which uses linux timebase
clock_gettime which uses Xenomai timebase unrelated to linux' timebase
This is unacceptable. What we want is a unique timebase.

And since this will have a cost not everyone is willing to pay, I have
another requirement: this code should be compiled conditionally.

> 
>> - you should not use vread, you should use __xn_rdtsc directly in
>> user-space, otherwise, your code would only work on x86. Of course this
>> means that the I-pipe should create a clocksource with whatever hardware
>> counter the architecture is providing to Xenomai. This also means that
>> the I-pipe should declare a clocksource using whatever hardware counter
>> is provided by the architecture with highest priority than other
>> clocksources, to ensure that Linux is using the same clock source as
>> Xenomai, and that NTP is correcting that clock source. This would also
>> remove the issue with Linux declaring the tsc unstable.
> the reason why it's based on vread() is because the Linux kernel
> automatically makes sure that it points to a function that can be called
> from userland, so why would it only run on x86? Currently, the
> userland patch is limited to x86 because I've only adapted the
> sequence counter for this arch.
> 
> Besides, vread() could also work with a different source than the TSC as
> long as it's accessible from userland.

vread is a function pointer call, which:
- requires vsyscalls, currently only implemented on x86 (and maybe ppc)
- is function pointer call, so damn slow on low end hardware.

Xenomai has __xn_rdtsc on all architectures, so, we should be based on that.

Since what we want is Xenomai to use the same clock source as Linux, and
anything else than tsc is not implemented for Xenomai, we should
implement tsc first and keep other clock sources for later. And when we
use another clock, __xn_rdtsc will use that clock anyway.

> 
>> - why the transactionnal mechanism at all? Why not simply using seqlocks
>> with an ipipe_spinlock, and do the update with irqs off? the locking
>> section is much shorter than, say, xnpod_schedule, so it will not have
>> any influence on the worst case latency, and the reader side will still
>> be lockless.
> Because even if we don't increase the peak latency, we'll still
> increase the average latency. Additionally, it would also be possible
> to extend the base mechanism to an RCU-style communication channel
> between the kernel and Xenomai in the long run, so I'd argue that
> the lock-less solution is nicer.

It is a useless optimization, it is a lot of code to avoid shutting
interrupts of for a handful of assignments (since you can avoid copying
vread, and mult and shift which never change if we enfore the clock
source). There are many more, longer masking sections everywhere in the
I-pipe patch and in Xenomai code.

On the one hand you make complicated code (which will be costly on low
end hardware) to avoid shutting interrupts around a few assignments, but
on the other hand you leave an architecture specific function pointer
call where we want a fast behaviour on average (remember, we do all this
to avoid a system call, which is only a few hundreds nanoseconds on your
big iron x86), and where we have a generic fast replacement. Sometimes,
I do not understand your logic.

> 
>> - the NTP event should trigger an ipipe event with ipipe_dispatch_event.
> could do, but I was following Gilles' suggestion  ;-) to use an
> arch-specific hook since it's easier to maintain in the long run than
> writing a generic function and replacing every call to
> vsyscall_update(), also the future.
> (http://www.opensubscriber.com/message/xenomai@xenomai.org,
> although I can change that, certainly no religious issues here)

What I mean is that vsyscall_update should trigger ipipe_dispatch_event.
This is what I meant from the beginning.

Ok. I will not be able to answer much more during the rest of the
afternoon, so do not be surprised if I remain silent until tonight.

-- 
					    Gilles.

