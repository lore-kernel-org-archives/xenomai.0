Subject: Re: Cobalt Preemption of kernel update_fast_timekeeper can cause
 deadlocks
References: <f4c18591165c4b919c85ac90a756af9f@andritz.com>
 <159d2a96-fb82-b974-7958-79367a00a546@xenomai.org>
 <cdc2d93e-3d5b-0d5b-bf17-1a813e0622e2@siemens.com>
 <70702a6f3a2e47e58a54bc88e8298caf@P10-EX02.3DSystems.Internal>
 <4aebca73-7231-e92f-2424-0d44ee12e2a8@siemens.com>
 <3e000509f1c449a1bf20b25875bce3f8@andritz.com>
 <1dfb945e-1188-b9cd-5928-7765ebf665f0@siemens.com>
 <c2f4fd212ca0426a81148edbea1814df@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <70fd1a29-fc09-d4c0-f9b4-75d658210c5d@siemens.com>
Date: Thu, 20 Dec 2018 16:21:23 +0100
MIME-Version: 1.0
In-Reply-To: <c2f4fd212ca0426a81148edbea1814df@andritz.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 20.12.18 16:02, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Donnerstag, 20. Dezember 2018 14:33
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: Re: Cobalt Preemption of kernel update_fast_timekeeper can cause
>> deadlocks
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 20.12.18 13:29, Lange Norbert via Xenomai wrote:
>>>> On 19.12.18 19:26, Auel, Kendall via Xenomai wrote:
>>>>> Jan,
>>>>>
>>>>> I'm very much in favor of providing a way to prevent Xenomai modules
>>>> from using features which can result in deadlock, if there is a clean
>>>> way to detect such a situation.
>>>>>
>>>>> We used gettimeofday in one of our modules and it mostly worked
>> great.
>>>> But once in a great while the system would deadlock. Most calls to
>>>> gettimeofday are benign and appear to work normally, which is why it
>>>> is especially problematic. It would have saved some debug cycles if
>>>> there was a kernel log message to warn us of our danger.
>>>>>
>>>>> Or perhaps we could collect a blacklist of references which will
>>>>> produce
>>>> warnings when linking a Xenomai module. All of these things are 'nice
>>>> to have' but certainly not urgent matters.
>>>>
>>>> We do have the infrastructure and a small use case for such RT traps
>> already:
>>>> If you use --mode-check on xeno-config, any usage of malloc and free
>>>> from RT contexts will be detected and reported. These calls are evil
>>>> as well because they tend no not trigger a syscall in the fast path
>>>> and only fail on contention or empty-pool situations of the userspace
>> allocator.
>>>
>>> There is still the issue that the cobald kernel can interrupt the
>>> linux kernel while holding a lock.
>>> Consider the case that you have a 4 core CPU, several cobalt threads are
>> bound to eg. Core 0 (legacy code assuming single core).
>>>
>>> 1) linux wants to update the timekeeper struct
>>> 2) now cobalt preempts the linux kernel while holding the lock on Core
>>> 0
>>> 3) the cobalt threads run close to each other and thus Core 0 remains in
>> cobalt domain for hundreds of ms.
>>> 4) finally all cobalt threads (that are bound to core 0) idle and
>>> linux can free the lock
>>>
>>> This means that all Linux threads on *any core* that try to call some
>> *gettime functions (possible others) will busywait on the lock.
>>>
>>
>> You do not need to look at the GTOD lock to construct such delays: every
>> Linux spinlock taken on one core that is then interrupted by RT workload for
>> a longer period can delay other cores doing Linux stuff that needs that lock.
>> That is a generic property of the co-kernel architecture - and the reason you
>> should allow Linux to run every few ms, on *every* core.
> 
> You are right, I did not realize that.
> Userspace usually does not spinlock, so I consider those functions a lot more critical,
> clock_gettime is also heavily used (especially for tracing).

Sure, depending on the workload, this user-space triggered path can be way more 
likely than a kernel-side dependency. But the impact is 100% the same.

> 
> Funny enough, the linux x86 vdso handles clock_gettime(CLOCK_MONOTONIC) but not clock_gettime(CLOCK_MONOTONIC_RAW).
> Seems the common denominator would be to use rdtsc directly =/
> (I know about the pitfalls, but our hardware should have a stable, invariant tsc)
> 
>>
>>> That a rt thread (potentially just temporary promoted non-rt thread, or not
>> lazily demoted yet) can additionally deadlock the system sits just on top of
>> this issue.
>>>
>>> Regarding to what I am allowed to do:
>>> AFAIK a thread started as cobalt thread can freely switch between
>> domains, typically around syscalls and the switches are "lazy". What are the
>> rules for a thread that needs to collect some data RT (potentially using some
>> RT Mutexes with prio inheritance) calling into DSOs that aren’t compiled with
>> the "cobalt wrappings" active (say a logging framework that uses libcs
>> clock_gettime).
>>> Do I manually have to demote the thread somehow before calling DSO
>> functions, is it not allowed at all to use DSOs that were compiled with "cobalt
>> wrappings"?
>>
>> If you are calling into an "unknown" non-RT blob, dropping from RT may
>> actually be required. We do not promote explicit mode switches because
>> they are not needed if you control (wrap) all your code. This might be  an
>> exception.
> 
> The non-RT "blob" is the regular linux rootfs in my case, ie. libstdc++ and I plan
> to use libnttg-ust and stuff like xml parsers.

That's all fine - as long as you are not in RT context.

Actually, if you use a SCHED_WEAK thread for calling into both RT and non-RT, 
you will not have to do the explicit switching because those threads fall back 
to non-RT as soon as they have no RT business (lock ownership or blocking) 
anymore, and then you are safe.

> I understand this as motivation to actually *have* the POSIX Skin (eases legacy code as well),
> as soon as we can muster the time, then anything RT will be explicit and RT only
> 
>>>
>>>> with posix, you are already
>>>> redirected to the RT-safe implementations of those functions.
>>>
>>> In my case (posix skin, not "native" as I replied earlier), the call
>>> came from another DSO which is unaffected by the link-time wrapping.
>>> I would likely have to LD_PRELOAD a checker DSO, seems more sane to
>>> me, as the calls could originate from implicitly linked DSO aswell
>>> (C++ runtime library)
>>
>> Is the reason that the other DSOs are not caught at link-time generic or
>> specific to your build? The former case should be documented if it exists.
> 
> If non-RT libstdc++ calls the function clock_gettime, then it will do so as it totally
> ignores what your compiled code does.

It still takes someone to call into that runtime lib from the wrong context.

RT is never transparent to the user, nor simple. It is a lot about managing your 
dependencies, call stacks and language runtimes. What we see here is some - 
maybe just small - gap in that. As pointed out, GTOD is not the only path, whole 
malloc & friends fall into that as well, just like non-RT locking in general 
(futexes are "evil" as they only trigger syscalls when there is contention).

> Too hook into this, you would need to make sure, that your replacement "clock_gettime" will be in the symbol table before libc is loaded.
> 

Maybe start with extracting some call stacks: How can you get to those 
invocations, and from which contexts?

>>
>> Irrespective of that, I would definitely be interested in a LD_PRELOAD-based
>> checker that you can attach to an application easily, without the need to
>> switch to link-time wrapping (which is not needed with non-posix skins).
> 
> If you don’t know lttng-ust, you could spend a hour or two playing with it,
> Eg you can interpose and trace any malloc/free by just preloading the wrapper:
> LD_PRELOAD=liblttng-ust-libc-wrapper your_app
> 
> This could help with non-posix skins mixing with dangerous other functions aswell.

It takes more than that if you look at how we decide whether to raise an alarm 
or not (context detection, warning flag evaluation, signal raising). lttng-ust 
can be a nice tracing tool, but for a runtime equivalent to --mode-check, I 
would rather set up a tool that behaves like the link-time version.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

