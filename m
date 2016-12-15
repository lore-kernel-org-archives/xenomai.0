References: <CAMJ=MEeueNfVgXx9eHbv69P4c3jQWDtR7QxSio_-M5buDu0O5w@mail.gmail.com>
 <f2c1ecaf-676d-786e-452d-3ea68c61877f@xenomai.org>
 <CAMJ=MEeZvtjpDg=XqtWHB96=pTCaj_6+DRqtsy9ZV7C-_wZqiw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <32c9bacb-4310-dbdf-c51c-eb8536ed8499@xenomai.org>
Date: Thu, 15 Dec 2016 15:08:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEeZvtjpDg=XqtWHB96=pTCaj_6+DRqtsy9ZV7C-_wZqiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mercury: roundrobin scheduling using Linux scheduler.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 12/15/2016 01:47 PM, Ronny Meeus wrote:
> On Fri, Dec 9, 2016 at 11:48 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 12/06/2016 03:56 PM, Ronny Meeus wrote:
>>> Hello
>>>
>>> Round-robin scheduling is implemented in Mercury by
>>> starting a per-thread timer that sends a signal to the thread
>>> when its budget is consumed.
>>>
>>> There are several good reasons to implement round-robin
>>> in this way, one of them being the complete freedom at
>>> application level to decide what the round-robin interval is.
>>>
>>> On the other hand, there are also several reasons to use
>>> the Linux round-robin mechanism:
>>> - most probably less overhead
>>> - sched_yield not being async-safe (some sources mention
>>>   it is safe while others say it is not)
>>
>> AFAIR, the opengroup does not mention sched_yield() as an async-safe
>> routine in the 1003.1 standard, but the glibc and uClibc implementations
>> merely issue a sched_yield syscall, which eventually gets us this guarantee.
> 
> Where is this documented? I cannot find anything about it.
>

Reading the glibc and the sched_yield implementation of any kernel
release Xenomai supports tells us so.

> In an ideal (bug free) world you are right. Both the applications and
> the library code needs to be able to cope with signals and syscalls
> that return error codes. But the world is far from ideal ...

That is not the point. A kernel should/can not work around any possible
bug of any possible application, this is the other way around: the
application should fix its own bugs, and cope with the limitations of
the kernel.

>> I would make your option the default, allowing a per-thread RR quantum
>> only on demand with a config switch, since needing distinct RR time
>> slices is most likely an infrequent requirement.
>>
> 
> But this would mean that there is on impact on the current behavior and
> all systems using Xenomai will have to adapt their configuration...
> 

"All systems using Xenomai" is not relevant in that case. The only
systems that would be impacted would have to, inclusively:

- run over Mercury, meaning that they would need Xenomai only for
emulating traditional RTOS APIs or the former native API, i.e. not
POSIX-based (i.e. not that many)
- run multiple time slices in a single application, which is something
no traditional RTOS API we emulate can do, i.e. pSOS and VxWorks can
only handle a single global RR quantum. Therefore, that feature is
already beyond the scope of emulation.

So, except applications currently running multiple applications using
different RTOS emulators (e.g. pSOS AND VxWorks) within the scope of a
single _process_, or former "native" Xenomai applications that moved
from a dual kernel to single kernel configuration which would also need
to undergo multiple RR time slices concurrently, nobody should care for
such change.

Since the change is about working around a kernel bug, I would
definitely make the sane behavior the default, leaving the user the
option of turning off the safe option for gaining multiple RR
timeslices. It should be easier to notice a functional limitation (i.e.
single RR slice), than chasing a broken kernel behavior.

-- 
Philippe.

