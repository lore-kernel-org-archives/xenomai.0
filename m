Message-ID: <4BFE913F.8010009@domain.hid>
Date: Thu, 27 May 2010 17:35:27 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>	<4BF251EC.7040605@domain.hid>
	<4BF267D3.4040500@domain.hid>	<4BF28401.6060503@domain.hid>
	<4BF28B0C.3080705@domain.hid>	<4BF2AB19.5060701@domain.hid>
	<4BF2DF77.90806@domain.hid>	<4BF2F73C.7070605@domain.hid>
	<4BF3045E.5080707@domain.hid> <4BF31010.2080003@domain.hid>
	<4BF31386.4030402@domain.hid> <4BF31C83.5070109@domain.hid>
	<4BF37BFD.6030709@domain.hid> <4BF38F14.1060105@domain.hid>
	<4BF64A65.6090202@domain.hid>
In-Reply-To: <4BF64A65.6090202@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Andreas Glatz <AndreasGlatz@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Just like it seems to be the case for Steve (unless I misunderstood his
>>>> reply), it is very useful for us being able to time-stamp events in RT
>>>> context that need to be correlated with events stamped in non-RT
>>>> (including non-Xenomai) parts or even on other systems: (offline) data
>>>> fusion, logging, tracing. I even bet that this is currently the major
>>>> use case for synchronized clocks, only a smaller part already has the
>>>> need to synchronize timed activities on a common clock source. But there
>>>> is huge potential in the second part once we can provide a stable
>>>> infrastructure.
>>> I already had such issues, and I did not solve them by modifying Xenomai
>>> core.
>>>
>>>> Even a "third clock" would have to be delivered for more archs than x86,
>>>> no question. We would basically need a generic but slow syscall variant
>>>> and per-arch syscall-less optimizations (where feasible).
>>> So, you would add a syscall which would becomre useless when you have
>>> implemented synchronized clocks properly? Yet another reason for
>>> avoiding this solution.
>>>
>> Could be "CLOCK_LINUX" - ie. no need for a new syscall.
> 
> I am Ok for this solution (and now that I think about it, I wonder if we
> did not already have this discussion). Anyway, I would go for
> CLOCK_HOST_REALTIME, in case someone wants to implement
> CLOCK_HOST_MONOTONIC. The advantage is that we can return EINVAL in the
> timer_create or clock_settime calls, to indicate clearly that using this
> clock for timing services is verboten. And when/if the full
> synchronization is implemented, the ID simply becomes a #define.

okay, so let's pursue this path. Patches will follow.

Best, Wolfgang

