References: <5AC116C9.6040809@freyder.net>
 <15a83f1d-7785-11c9-5f64-c09cb035ff10@xenomai.org>
 <5AC24433.30107@freyder.net>
 <6cacabd8-af4c-27e0-1b62-34ce73d7b933@xenomai.org>
 <5AC25632.90608@freyder.net>
 <7f51755d-8a54-c1a8-9ee4-a3014e03b3df@xenomai.org>
 <5ACA9F4C.8090902@freyder.net>
 <bdd2e389-bb90-1b16-9e18-6c23ec31218d@xenomai.org>
 <9638da9b-dcf7-8fac-8ef7-3b54d9f10316@xenomai.org>
 <5ACF7EE1.7020404@freyder.net>
 <fb8259aa-d3b2-479e-b508-58202e5f75ee@xenomai.org>
 <5ACF9DCC.5020102@freyder.net>
 <b6e53d00-24f7-c1d7-333f-3f037360c41e@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5AD0D9E2.10506@freyder.net>
Date: Fri, 13 Apr 2018 11:25:06 -0500
MIME-Version: 1.0
In-Reply-To: <b6e53d00-24f7-c1d7-333f-3f037360c41e@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Possible Xenomai fuse filesystem/registry queue
 status files issue?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 4/13/2018 1:36 AM, Philippe Gerum wrote:
> On 04/12/2018 07:56 PM, Steve Freyder wrote:
>> On 4/12/2018 11:05 AM, Philippe Gerum wrote:
>>> On 04/12/2018 05:44 PM, Steve Freyder wrote:
>>>> On 4/12/2018 5:23 AM, Philippe Gerum wrote:
>>>>> On 04/12/2018 11:31 AM, Philippe Gerum wrote:
>>>>>> On 04/09/2018 01:01 AM, Steve Freyder wrote:
>>>>>>> On 4/2/2018 11:51 AM, Philippe Gerum wrote:
>>>>>>>> On 04/02/2018 06:11 PM, Steve Freyder wrote:
>>>>>>>>> On 4/2/2018 10:20 AM, Philippe Gerum wrote:
>>>>>>>>>> On 04/02/2018 04:54 PM, Steve Freyder wrote:
>>>>>>>>>>> On 4/2/2018 8:41 AM, Philippe Gerum wrote:
>>>>>>>>>>>> On 04/01/2018 07:28 PM, Steve Freyder wrote:
>>>>>>>>>>>>> Greetings again.
>>>>>>>>>>>>>
>>>>>>>>>>>>> As I understand it, for each rt_queue there's supposed to be a
>>>>>>>>>>>>> "status file" located in the fuse filesystem underneath the
>>>>>>>>>>>>> "/run/xenomai/user/session/pid/alchemy/queues" directory, with
>>>>>>>>>>>>> the file name being the queue name.  This used to contain very
>>>>>>>>>>>>> useful info about queue status, message counts, etc.  I don't
>>>>>>>>>>>>> know
>>>>>>>>>>>>> when it broke or whether it's something I'm doing wrong but I'm
>>>>>>>>>>>>> now getting a "memory exhausted" message on the console when I
>>>>>>>>>>>>> attempt to do a "cat" on the status file.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here's a small C program that just creates a queue, and then
>>>>>>>>>>>>> does
>>>>>>>>>>>>> a pause to hold the accessor count non-zero.
>>>>>>>>>>>>>
>>>>>>>>>>>> <snip>
>>>>>>>>>>>>
>>>>>>>>>>>>> The resulting output (logged in via the system console):
>>>>>>>>>>>>>
>>>>>>>>>>>>> # sh qtest.sh
>>>>>>>>>>>>> + sleep 1
>>>>>>>>>>>>> + ./qc --mem-pool-size=64M --session=mysession foo
>>>>>>>>>>>>> + find /run/xenomai
>>>>>>>>>>>>> /run/xenomai
>>>>>>>>>>>>> /run/xenomai/root
>>>>>>>>>>>>> /run/xenomai/root/mysession
>>>>>>>>>>>>> /run/xenomai/root/mysession/821
>>>>>>>>>>>>> /run/xenomai/root/mysession/821/alchemy
>>>>>>>>>>>>> /run/xenomai/root/mysession/821/alchemy/tasks
>>>>>>>>>>>>> /run/xenomai/root/mysession/821/alchemy/tasks/task@1[821]
>>>>>>>>>>>>> /run/xenomai/root/mysession/821/alchemy/queues
>>>>>>>>>>>>> /run/xenomai/root/mysession/821/alchemy/queues/foo
>>>>>>>>>>>>> /run/xenomai/root/mysession/system
>>>>>>>>>>>>> /run/xenomai/root/mysession/system/threads
>>>>>>>>>>>>> /run/xenomai/root/mysession/system/heaps
>>>>>>>>>>>>> /run/xenomai/root/mysession/system/version
>>>>>>>>>>>>> + qfile='/run/xenomai/*/*/*/alchemy/queues/foo'
>>>>>>>>>>>>> + cat /run/xenomai/root/mysession/821/alchemy/queues/foo
>>>>>>>>>>>>> memory exhausted
>>>>>>>>>>>>>
>>>>>>>>>>>>> At this point, it hangs, although SIGINT usually terminates it.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've seen some cases where SIGINT won't terminate it, and a
>>>>>>>>>>>>> reboot is
>>>>>>>>>>>>> required to clean things up.  I see this message appears to be
>>>>>>>>>>>>> logged
>>>>>>>>>>>>> in the obstack error handler.  I don't think I'm running out of
>>>>>>>>>>>>> memory,
>>>>>>>>>>>>> which makes me think "heap corruption".  Not much of an
>>>>>>>>>>>>> analysis!
>>>>>>>>>>>>> I did
>>>>>>>>>>>>> try varying queue sizes and max message counts - no change.
>>>>>>>>>>>>>
>>>>>>>>>>>> I can't reproduce this. I would suspect a rampant memory
>>>>>>>>>>>> corruption
>>>>>>>>>>>> too,
>>>>>>>>>>>> although running the test code over valgrind (mercury build)
>>>>>>>>>>>> did not
>>>>>>>>>>>> reveal any issue.
>>>>>>>>>>>>
>>>>>>>>>>>> - which Xenomai version are you using?
>>>>>>>>>>>> - cobalt / mercury ?
>>>>>>>>>>>> - do you enable the shared heap when configuring ?
>>>>>>>>>>>> (--enable-pshared)
>>>>>>>>>>>>
>>>>>>>>>>> I'm using Cobalt.  uname -a reports:
>>>>>>>>>>>
>>>>>>>>>>> Linux sdftest 4.1.18_C01571-15S00-00.000.zimg+83fdace666 #2
>>>>>>>>>>> SMP Fri
>>>>>>>>>>> Mar
>>>>>>>>>>> 9 11:07:52 CST 2018 armv7l GNU/Linux
>>>>>>>>>>>
>>>>>>>>>>> Here is the config dump:
>>>>>>>>>>>
>>>>>>>>>>> CONFIG_XENO_PSHARED=1
>>>>>>>>>> Any chance you could have some leftover files in /dev/shm from
>>>>>>>>>> aborted
>>>>>>>>>> runs, which would steal RAM?
>>>>>>>>>>
>>>>>>>>> I've been rebooting before each test run, but I'll keep that in
>>>>>>>>> mind for
>>>>>>>>> future testing.
>>>>>>>>>
>>>>>>>>> Sounds like I need to try rolling back to an older build, I have a
>>>>>>>>> 3.0.5
>>>>>>>>> and a 3.0.3 build handy.
>>>>>>>> The standalone test should work with the shared heap disabled,
>>>>>>>> could you
>>>>>>>> check it against a build configure with --disable-pshared? Thanks,
>>>>>>>>
>>>>>>> Philippe,
>>>>>>>
>>>>>>> Sorry for the delay - our vendor had been doing all of our kernel
>>>>>>> and SDK
>>>>>>> builds so I had to do a lot of learning to get this all going.
>>>>>>>
>>>>>>> With the --disable-pshared in effect:
>>>>>>>
>>>>>>> /.g3l # ./qc --dump-config | grep SHARED
>>>>>>> based on Xenomai/cobalt v3.0.6 -- #6e34bb5 (2018-04-01 10:50:59
>>>>>>> +0200)
>>>>>>> CONFIG_XENO_PSHARED is OFF
>>>>>>>
>>>>>>> /.g3l # ./qc foo &
>>>>>>> /.g3l # find /run/xenomai/
>>>>>>> /run/xenomai/
>>>>>>> /run/xenomai/root
>>>>>>> /run/xenomai/root/opus
>>>>>>> /run/xenomai/root/opus/3477
>>>>>>> /run/xenomai/root/opus/3477/alchemy
>>>>>>> /run/xenomai/root/opus/3477/alchemy/tasks
>>>>>>> /run/xenomai/root/opus/3477/alchemy/tasks/qcreate3477
>>>>>>> /run/xenomai/root/opus/3477/alchemy/queues
>>>>>>> /run/xenomai/root/opus/3477/alchemy/queues/foo
>>>>>>> /run/xenomai/root/opus/system
>>>>>>> /run/xenomai/root/opus/system/threads
>>>>>>> /run/xenomai/root/opus/system/heaps
>>>>>>> /run/xenomai/root/opus/system/version
>>>>>>> root@ICB-G3L:/.g3l # cat
>>>>>>> run/xenomai/root/opus/3477/alchemy/queues/foo
>>>>>>> [TYPE]  [TOTALMEM]  [USEDMEM]  [QLIMIT]  [MCOUNT]
>>>>>>>     FIFO        5344       3248        10         0
>>>>>>>
>>>>>>> Perfect!
>>>>>>>
>>>>>>> What's the next step?
>>>>>>>
>>>>>> I can reproduce this issue. I'm on it.
>>>>>>
>>>>> The patch below should solve the problem for the registry, however this
>>>>> may have uncovered a bug in the "tlsf" allocator (once again), which
>>>>> should not have failed allocating memory. Two separate issues then.
>>>>>
>>>>> diff --git a/include/copperplate/registry-obstack.h
>>>>> b/include/copperplate/registry-obstack.h
>>>>> index fe192faf7..48e453bc3 100644
>>>>> --- a/include/copperplate/registry-obstack.h
>>>>> +++ b/include/copperplate/registry-obstack.h
>>>>> @@ -29,11 +29,12 @@ struct threadobj;
>>>>>     struct syncobj;
>>>>>
>>>>>     /*
>>>>> - * Assume we may want fast allocation of private memory from real-time
>>>>> - * mode when growing the obstack.
>>>>> + * Obstacks are grown from handlers called by the fusefs server
>>>>> + * thread, which has no real-time requirement: malloc/free is fine for
>>>>> + * memory management.
>>>>>      */
>>>>> -#define obstack_chunk_alloc    pvmalloc
>>>>> -#define obstack_chunk_free    pvfree
>>>>> +#define obstack_chunk_alloc    malloc
>>>>> +#define obstack_chunk_free    free
>>>>>
>>>>>     struct threadobj;
>>>>>
>>>>>
>>>> Thanks Philippe,
>>>>
>>>> I shall add this to my build ASAP.  If I understand correctly, this is
>>>> switching
>>>> the entire registry-obstack-related dynamic storage allocation mechanism
>>>> from the
>>>> "pv" routines (TLSF allocator?) paradigm to the standard malloc/free
>>>> paradigm.
>>> Yes, because the context that runs those calls is a non-rt one in
>>> essence, i.e. the fuse filesystem server thread.
>>>
>>>> I ask because my next issue report was going to be about a SEGV that
>>>> I have
>>>> been seeing occasionally in registry_add_file() after having called
>>>> pvstrdup()
>>>> and having gotten a NULL return back.  The caller there apparently
>>>> does not
>>>> expect a NULL return, so when you said "should not have failed
>>>> allocating memory"
>>>> that brought my attention back to the SEGV issue.  This appears to be
>>>> related to
>>>> what I will call "heavy registry activity" when I am initializing -
>>>> creating
>>>> lots of RT tasks, queues, mutexes, etc, causing hot activity in
>>>> registry_add_file
>>>> I would expect.
>>> Your assumption is spot on. There is a flaw in the way the private
>>> memory allocator is sized in pshared mode (i.e. tlsf in that case). Only
>>> 8k are reserved for the main private pool pvmalloc() refers to, that
>>> size was picked in order to limit the amount of locked memory reserved
>>> by an allocator which is usually under low pressure when pshared is
>>> enabled. The consequence of random pvmalloc() calls implicitly pulling
>>> memory from that heap was overlooked.
>>>
>>> Problem is that a high registry activity exactly defeats that
>>> assumption, consuming much more memory as obstacks grow with printout
>>> data.
>>>
>>> I've been converting pvmalloc() calls to plain malloc() when applicable
>>> lately, but we may still need a way to let the user specify which amount
>>> of private memory would be required for the remaining pvmalloc() calls.
>>>
>>>> I'm thinking creation of a "registry exerciser" program may be in
>>>> order...
>>>>
>>>>
>>> Yeah, possibly. The fuse-based registry was assumed to be straighforward
>>> to implement in theory, but ended up with lots of brain damage corner
>>> cases.
>>>
>> That 8K allocation, is that on a "per-process" basis?  I had started
>> breaking my code into more processes because I had an inkling that
>> there was some kind of limit on how many registry entries a process
>> could have - maybe now I understand where that limit originates!
>>
>> Do you think that an increase from 8 to 64K would be acceptable?  A
>> "temporary workaround" at best, but I'm pretty sure that would be
>> enough to get my code running in short order.
>>
> As a work aroud, just raise MIN_TLSF_HEAPSZ to the value you see fit.
> There is no limitation on the number of registry entries whatsoever,
> only transient memory pressure on the private allocator with FUSE, when
> running pshared that could lead to OOM situations.
>
> The situation may get worse because TLSF is really bad at dealing with
> internal fragmentation. I'm working on a drop in replacement for the
> -next branch for this reason.
>
I will do that.

Thank you for all of this and the associated enlightenment, very
much a pleasure.
--
Steve


