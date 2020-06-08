From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Still getting Deadlocks with condition variables
References: <VI1PR05MB59177F9BC5CD74A181467003F6860@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <260342fe-450f-a30b-72c2-751961bc28dd@xenomai.org>
 <VI1PR05MB5917E09F83A6B78BC1798287F6850@VI1PR05MB5917.eurprd05.prod.outlook.com>
Message-ID: <4f24ced8-5317-3520-70e7-1c2e2dd24603@xenomai.org>
Date: Mon, 8 Jun 2020 16:17:10 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917E09F83A6B78BC1798287F6850@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 6/8/20 12:08 PM, Lange Norbert wrote:
> 
>> This kernel message tells a different story, thread pid 681 received a #PF,
>> maybe due to accessing its own stack (cond.c, line 316). This may be a minor
>> fault though, nothing invalid. Such fault is not supposed to occur for Xenomai
>> threads on x86, but that would be another issue. Code-wise, I'm referring to
>> the current state of the master branch for lib/cobalt/cond.c, which seems to
>> match your description.
> 
> I dont know what you mean with minor fault, from the perspective of Linux?
> A RT thread getting demoted to Linux is rather serious to me.
>

Minor from a MMU standpoint: the memory the CPU  dereferenced is valid but no
page table entry currently maps it. So, #PF in this case seems to be a 'minor'
fault in MMU lingo, but it is still not expected.

> Also, the thing is that I would not know how a PF in the long running thread, with locked memory,
> With the call being close to the thread entry point in a wait-for-condvar-loop, never using more than an insignificant> amount of stack at this time should be possible.>

Except if mapping an executable segment via dlopen() comes into play,
affecting the page table. Only an assumption at this stage.

> On the other hand, the non-RT thread loads a DSO and is stuck somewhere after allocating memory.
> My guess would be that the PF ends up at the wrong thread.
> 

As Jan pointed out, #PF are synchronously taken, synchronously handled. I
really don't see how #PF handling could ever wander.

>>>
>>
>> You refer to an older post describing a lockup, but this post describes an
>> application crashing with a core dump. What made you draw the conclusion
>> that the same bug would be at work?
> 
> Same bug, different PTHREAD_WARNSW setting is my guess.
> The underlying issue that a unrelated signal ends up to a RT thread.
> 
>> Also, could you give some details
>> regarding the
>> following:
>>
>> - what do you mean by 'lockup' in this case? Can you still access the board or
>> is there some runaway real-time code locking out everything else when this
>> happens? My understanding is that this is no hard lock up otherwise the
>> watchdog would have triggered. If this is a softer kind of lockup instead, what
>> does /proc/xenomai/sched/stat tell you about the thread states after the
>> problem occurred?
> 
> This was a post-mortem, no access to /proc/xenomai/sched/stat anymore.
> lockup means deadlock (the thread getting the signal holds a mutex, but is stuck),
> Coredump happens if PTHREAD_WARNSW is enabled (means it asserts out before).
> 
>> - did you determine that using the dynamic linker is required to trigger the
>> bug yet? Or could you observe it without such interaction with dl?
> 
> AFAIK, always occurred at the stage where we load a "configuration", and load DSOs.
> 
>>
>> - what is the typical size of your Xenomai thread stack? It defaults to 64k min
>> with Xenomai 3.1.
> 
> 1MB

I would dig the following distinct issues:

- why is #PF taken on an apparently innocuous instruction. dlopen(3)->mmap(2)
might be involved. With a simple test case, you could check the impact of
loading/unloading DSOs on memory management for real-time threads running in
parallel. Setting the WARNSW bit on for these threads would be required.

- whether dealing with a signal adversely affects the wait-side of a Xenomai
condvar. There is a specific trick to handle this in the Cobalt and libcobalt
code, which is the reason for the wait_prologue / wait_epilogue dance in the
implementation IIRC. Understanding why that thread receives a signal in the
first place would help too. According to your description, this may not be
directly due to taking #PF, but may be an indirect consequence of that event
on sibling threads (propagation of a debug condition of some sort, such as
those detected by CONFIG_XENO_OPT_DEBUG_MUTEX*).

At any rate, you may want to enable the function ftracer, enabling conditional
snapshots, e.g. when SIGXCPU is sent by the cobalt core. Guesswork with such
bug is unlikely to uncover every aspect of the issue, hard data would be
required to go to the bottom of it. With a bit of luck, that bug is not
time-sensitive in a way that the overhead due to ftracing would paper over it.

-- 
Philippe.

