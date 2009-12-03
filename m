Message-ID: <4B17980A.3060503@domain.hid>
Date: Thu, 03 Dec 2009 11:50:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>	<4B167B4B.3010804@domain.hid>
	<4B167FC4.8080904@domain.hid>	<4B1681DA.3090108@domain.hid>
	<4B1684D7.2080501@domain.hid>	<4B1690EC.8030002@domain.hid>
	<4B16949B.2040806@domain.hid> <4B169CF7.2060108@domain.hid>
	<4B16D403.1070202@domain.hid> <4B16E417.3000400@domain.hid>
	<4B16E813.6050906@domain.hid>
	<36FCBE44-88E0-4AAA-9E83-1A9F9AB3F5D9@domain.hid>
In-Reply-To: <36FCBE44-88E0-4AAA-9E83-1A9F9AB3F5D9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wm@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
>>>>>> The kernel need to synchronize with user land, so the problem is
>>>>>> (almost) the same as with obtaining the original data from Linux
>>>>>> directly: user land can only use a retry or a smart fall-back  
>>>>>> mechanism
>>>>>> to obtain consistent data.
>>>>> Well, ok, I imagine something like a revision counter. But I do  
>>>>> not see
>>>>> how it would work on an SMP system (kernel writing on one CPU,
>>>>> user-space reading on another cpu).
>>>> Ok, I had a look at seqlock.h, we can do it the same way, in an  
>>>> area of
>>>> the global heap. We will have to provide our own implementation  
>>>> since we
>>>> can not include linux/seqlock.h in user-space. update_vsyscall on  
>>>> x86_64
>>>> turns off the irqs, to protect against the same code or some reader
>>>> being called in an interrupt handler. We will have to do the same.
>>> But then the code can loop potentially unbounded, can't it? It may be
>>> that I'm missing something, but this was the initial reasaon for the
>>> three-buffer idea I've presented initially.
>> Well, on a normally running system, the update takes place for every
>> Linux timer interrupt (or is it only for the periodic tick ?), anyway,
>> if real-time code is running, there is no chance that it can be
>> preempted by a Linux timer interrupt, and if the code is called from  
>> non
>> real-time context, we do not care much.
> 
> For a tickless System, it's only the periodic Tick, Not every Timer  
> Interrupt.
>> Note that we already use such code for tsc emulation on some  
>> platforms,
>> and well, it works. And this is normal, the chances to get preempted
>> several times in a row by a timer interrupt without being able to
>> complete the loop are pretty low. Otherwise it would mean that there  
>> are
>> plenty of timer interrupts.
> 
> So that means, in essence, that you would accept probabilistic  
> algorithms in realtime context?

Ah, today's troll!

As I think I explained, the use of a seqlock in real-time context when
the seqlock writer only happens in linux context is not probabilistic.
It will work every time the first pass.

But other than that, yes, we do:
- RAM ECC algorithms only work for a given maximum number of bit changes
per cycle, and the source of bit changes is essentially random;
- cache behaviour, even though deterministic system-wise is
probabilistic from a real-time thread point of view, you never now how
many of your cache lines the non real-time threads will evict;
- fast user-space mutexes use compare-and-swap and retry if it failed
- user-space access to tsc on arm, powerpc, blackfin, nios, that is on
anything but x86 use a retry strategy.

We live with it.

The latency test allow you to measure the probabilistic effect of cache.

For the mutexes and tsc, if you happen to retry too often, it means that
the system starves the task which has the problem. It may be because you
designed your system that way, but in that case, you will expect it to
run slowly anyway, and it would be strange to specifically mandates the
mutex lock and tsc calls not to be slow. Or it may be because of a
design error, and in that case the design should be fixed, not mutex
lock and tsc.

-- 
                                          Gilles


