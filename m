References: <664a5757-3d5a-af0d-96a0-485bc71d58f8@siemens.com>
 <73a53c88-66cd-0c01-5fe7-0303a30ccd2b@xenomai.org>
 <963cf145-9056-2b41-e5ef-0394ccf5c202@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d195f384-bc18-d3c6-d880-8ada841423c1@xenomai.org>
Date: Wed, 2 Aug 2017 14:47:27 +0200
MIME-Version: 1.0
In-Reply-To: <963cf145-9056-2b41-e5ef-0394ccf5c202@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Avoid stopping all timers during debug sessions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 08/02/2017 01:03 PM, Jan Kiszka wrote:
> On 2017-08-02 10:12, Philippe Gerum wrote:
>> On 07/27/2017 08:03 PM, Jan Kiszka wrote:
>>> Hi,
>>>
>>> currently, when gdb interrupts a Xenomai application, all timers stop
>>> firing (except for those marked with XNTIMER_NOBLCK - core timers). This
>>> means, you can't debug one RT application without affecting others on
>>> the same systems. I'm not wondering how to resolve this. Options:
>>>
>>>  - convert timer stopping to a per-process feature - implies the need to
>>>    establish some timer-process relationship concept, and it might be
>>>    tricky for drivers and other central timer creators
>>>
>>>  - let the application deal with timer overflows during debug:
>>>     - make timer stop optional (in case of single applications that
>>>       can't handle this yet)
>>>     - do not stop timers at all
>>>
>>> Any opinions?
>>>
>>
>> That stuff is a relic from the Dark Ages, which not only sits in a hot
>> path, but also crashes an ARM board here when ptracing. At the very
>> least, the implementation is overkill and needs fixing.
>>
>> I'm working on a much simpler and less intrusive approach, I'll follow
>> up today on this.
> 
> OK, looking forward.

To answer your original question, I would either let the application
deal with overruns, or provide an implementation that only cares for
hiding overruns that may have occurred due to ptracing, instead of
trying to somehow freeze time.

So I pushed an implementation doing exactly that, fixing the breakage
issue in the same move. There is no such thing as blocked timers
anymore, we just pretend that no overrun took place when asked via
xntimer_get_overrun() after a ptraced state has existed, until an
originally relaxed caller eventually leaves the kernel in primary mode,
at which point normal accounting is restarted.

That should exactly cover the case we are interested in, i.e. a once
ptraced - therefore relaxed - thread, returning from any service which
may collect the overrun count, and has to do so from primary mode (e.g.
sigwait(), timerfd.read(), rtdm_task_wait_period()).

The code is in wip/sstep for now.

> 
>>
>>> BTW, I also have pre/post-debug hook concept for applications out of
>>> tree that can help to make applications debug-aware. In our use cases,
>>> the pre-hook brings hardware into a state that permits application stop,
>>> and the post-host ramps everything up again.
>>>
>>
>> Hooks sitting in kernel space?
>>
> 
> No, in the application. They are running in a "privileged" carrier
> thread (privileged means that it is stopped only after the callback
> finished). Goes along with changes to enable synchronous stopping of all
> RT threads (except that one) once a debug-stop comes in.
> 

Maybe that could be generalized by defining a special signal some
dedicated thread within an application could sigwait() for. A thread
synchronously waiting for such signal would inherit the required
privileges by doing so.

-- 
Philippe.

