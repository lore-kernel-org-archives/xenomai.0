Subject: Re: Cobalt Preemption of kernel update_fast_timekeeper can cause
 deadlocks
References: <f4c18591165c4b919c85ac90a756af9f@andritz.com>
 <159d2a96-fb82-b974-7958-79367a00a546@xenomai.org>
 <cdc2d93e-3d5b-0d5b-bf17-1a813e0622e2@siemens.com>
 <70702a6f3a2e47e58a54bc88e8298caf@P10-EX02.3DSystems.Internal>
 <4aebca73-7231-e92f-2424-0d44ee12e2a8@siemens.com>
 <3e000509f1c449a1bf20b25875bce3f8@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1dfb945e-1188-b9cd-5928-7765ebf665f0@siemens.com>
Date: Thu, 20 Dec 2018 14:32:49 +0100
MIME-Version: 1.0
In-Reply-To: <3e000509f1c449a1bf20b25875bce3f8@andritz.com>
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

On 20.12.18 13:29, Lange Norbert via Xenomai wrote:
>> On 19.12.18 19:26, Auel, Kendall via Xenomai wrote:
>>> Jan,
>>>
>>> I'm very much in favor of providing a way to prevent Xenomai modules
>> from using features which can result in deadlock, if there is a clean way to
>> detect such a situation.
>>>
>>> We used gettimeofday in one of our modules and it mostly worked great.
>> But once in a great while the system would deadlock. Most calls to
>> gettimeofday are benign and appear to work normally, which is why it is
>> especially problematic. It would have saved some debug cycles if there was a
>> kernel log message to warn us of our danger.
>>>
>>> Or perhaps we could collect a blacklist of references which will produce
>> warnings when linking a Xenomai module. All of these things are 'nice to
>> have' but certainly not urgent matters.
>>
>> We do have the infrastructure and a small use case for such RT traps already:
>> If you use --mode-check on xeno-config, any usage of malloc and free from
>> RT contexts will be detected and reported. These calls are evil as well
>> because they tend no not trigger a syscall in the fast path and only fail on
>> contention or empty-pool situations of the userspace allocator.
> 
> There is still the issue that the cobald kernel can interrupt the linux kernel
> while holding a lock.
> Consider the case that you have a 4 core CPU, several cobalt threads are bound to eg. Core 0 (legacy code assuming single core).
> 
> 1) linux wants to update the timekeeper struct
> 2) now cobalt preempts the linux kernel while holding the lock on Core 0
> 3) the cobalt threads run close to each other and thus Core 0 remains in cobalt domain for hundreds of ms.
> 4) finally all cobalt threads (that are bound to core 0) idle and linux can free the lock
> 
> This means that all Linux threads on *any core* that try to call some *gettime functions (possible others) will busywait on the lock.
> 

You do not need to look at the GTOD lock to construct such delays: every Linux 
spinlock taken on one core that is then interrupted by RT workload for a longer 
period can delay other cores doing Linux stuff that needs that lock. That is a 
generic property of the co-kernel architecture - and the reason you should allow 
Linux to run every few ms, on *every* core.

> That a rt thread (potentially just temporary promoted non-rt thread, or not lazily demoted yet) can additionally deadlock the system sits just on top of this issue.
> 
> Regarding to what I am allowed to do:
> AFAIK a thread started as cobalt thread can freely switch between domains, typically around syscalls and the switches are "lazy". What are the rules for a thread that needs to collect some data RT (potentially using some RT Mutexes with prio inheritance) calling into DSOs that aren’t compiled with the "cobalt wrappings" active (say a logging framework that uses libcs clock_gettime).
> Do I manually have to demote the thread somehow before calling DSO functions, is it not allowed at all to use DSOs that were compiled with "cobalt wrappings"?

If you are calling into an "unknown" non-RT blob, dropping from RT may actually 
be required. We do not promote explicit mode switches because they are not 
needed if you control (wrap) all your code. This might be  an exception.

> 
>> with posix, you are already
>> redirected to the RT-safe implementations of those functions.
> 
> In my case (posix skin, not "native" as I replied earlier), the call came from another DSO which is unaffected by the
> link-time wrapping.
> I would likely have to LD_PRELOAD a checker DSO, seems more sane to me,
> as the calls could originate from implicitly linked DSO aswell (C++ runtime library)

Is the reason that the other DSOs are not caught at link-time generic or 
specific to your build? The former case should be documented if it exists.

Irrespective of that, I would definitely be interested in a LD_PRELOAD-based 
checker that you can attach to an application easily, without the need to switch 
to link-time wrapping (which is not needed with non-posix skins).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

