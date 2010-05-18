Message-ID: <4BF2AD14.6080003@domain.hid>
Date: Tue, 18 May 2010 17:07:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF251EC.7040605@domain.hid> <4BF267D3.4040500@domain.hid>
	<4BF28401.6060503@domain.hid> <4BF28B0C.3080705@domain.hid>
	<4BF2AB19.5060701@domain.hid>
In-Reply-To: <4BF2AB19.5060701@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Question about getting system time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> [moved to xenomai-core]
> 
> Gilles Chanteperdrix wrote:
>> Wolfgang Mauerer wrote:
>>>> - gettimeofday should not have another timebase than
>>>> clock_gettime(CLOCK_REALTIME): in other word, the whole clock system
>>>> should be based on the ntp clock.
>>> Sorry, I'm not quite sure what you are talking about here. The NTP
>>> corrections are provided for the clock offered in the vsyscall page
>>> by Linux, so the clock is based on the NTP clock, isn't it? Or
>>> am I misparsing your statement?
>> Unless I misunderstood your patch, what you provide is:
>> gettimeofday which uses linux timebase
>> clock_gettime which uses Xenomai timebase unrelated to linux' timebase
>> This is unacceptable. What we want is a unique timebase.
> 
> okay, I see your point now. But this sound more like 3.0 stuff, doesn't
> it? The goal right now is just to have some code that generates
> synchronised, NTP corrected timestamps on Linux and Xenomai, not
> to rework the base timer handling.

We are going to open a 2.6 branch soon (we are migrating Xenomai to a
new hoster, and this job is almost finished). This will go to 2.6. And I
am not going to merge anything that would provide two different
timebases for CLOCK_REALTIME. That is too unnatural. There are a bunch
of natural things which will not work with this approach. It create many
ways to shoot oneself in the foot. So the answer is definitely no.

>> vread is a function pointer call, which:
>> - requires vsyscalls, currently only implemented on x86 (and maybe ppc)
>> - is function pointer call, so damn slow on low end hardware.
> 
> ... and fast as lightning on x86 when the call is made often, which
> is the important case when speed matters. So it makes sense on this
> platform.

rdtsc is even faster. It is just one instruction.
The generic solution is even faster than the architecture specific one.
So, please implement the generic one.

>> On the one hand you make complicated code (which will be costly on low
>> end hardware) to avoid shutting interrupts around a few assignments, but
>> on the other hand you leave an architecture specific function pointer
>> call where we want a fast behaviour on average (remember, we do all this
>> to avoid a system call, which is only a few hundreds nanoseconds on your
>> big iron x86), and where we have a generic fast replacement. Sometimes,
>> I do not understand your logic.
> 
> But using the same argument, you could get rid of Linux vsyscall based
> gettimeofday()...
> 
> Would having the synchronised time stamp feature (maybe by another name
> than gettimeofday()) conditionally compiled on x86 be acceptable?

No. We have a generic implementation at hand for a limited amount of
additional effort. Let us do things properly.

-- 
					    Gilles.

