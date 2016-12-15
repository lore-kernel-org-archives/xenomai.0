MIME-Version: 1.0
In-Reply-To: <f2c1ecaf-676d-786e-452d-3ea68c61877f@xenomai.org>
References: <CAMJ=MEeueNfVgXx9eHbv69P4c3jQWDtR7QxSio_-M5buDu0O5w@mail.gmail.com>
 <f2c1ecaf-676d-786e-452d-3ea68c61877f@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 15 Dec 2016 13:47:57 +0100
Message-ID: <CAMJ=MEeZvtjpDg=XqtWHB96=pTCaj_6+DRqtsy9ZV7C-_wZqiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Mercury: roundrobin scheduling using Linux scheduler.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Dec 9, 2016 at 11:48 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/06/2016 03:56 PM, Ronny Meeus wrote:
>> Hello
>>
>> Round-robin scheduling is implemented in Mercury by
>> starting a per-thread timer that sends a signal to the thread
>> when its budget is consumed.
>>
>> There are several good reasons to implement round-robin
>> in this way, one of them being the complete freedom at
>> application level to decide what the round-robin interval is.
>>
>> On the other hand, there are also several reasons to use
>> the Linux round-robin mechanism:
>> - most probably less overhead
>> - sched_yield not being async-safe (some sources mention
>>   it is safe while others say it is not)
>
> AFAIR, the opengroup does not mention sched_yield() as an async-safe
> routine in the 1003.1 standard, but the glibc and uClibc implementations
> merely issue a sched_yield syscall, which eventually gets us this guarantee.

Where is this documented? I cannot find anything about it.

>> - application receives a lot of signals in various places in
>>   the application and library code
>>
>
> Depends on the RR period; I would not say that a millisecond-level
> period is that frequent on the processing time scale of a modern
> processor. Of course, things might turn ugly with a RR period set to 100
> us, but would that be a reasonable value for this kind of scheduling
> policy anyway?

We use a RR period of 5ms. But this still means that we get a
sched_yield call 200 times a second (per core) when the system is
under full load.

> Besides, the application code is supposed to always deal
> with receiving signals by testing syscall return values.
>

In an ideal (bug free) world you are right. Both the applications and
the library code needs to be able to cope with signals and syscalls
that return error codes. But the world is far from ideal ...

>> The last one is the most important for us at the moment.
>> We observe strange crashes in glibc sporadically in our
>> product. We have created a test program that can reproduce
>> the issue in a couple of minutes/hours.
>> In fact it is a combination of RT thread, priority inherited
>> mutexes and signals. If any of the 3 needed elements is
>> removed, the issue is not seen anymore.
>>
>> After chasing long time (by experts in the area) for the
>> root-cause, it has been identified. It was located in the
>> Linux kernel. Details can be found in the link:
>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=dbb26055defd03d59f678cb5f2c992abe05b064a
>>
>> Since this bug it is actually triggered by the Xenomai
>> Mercury behavior and never has seen before (the issue
>> exists already for 10 years), it makes me worry that we
>> will hit other issues in the future as well. (in the kernel or
>> in the glibc)
>> It was mentioned several times in the discussions that
>> we are most probably using the system in a mode that is
>> not common at all.
>>
>> Therefor I would like to start a discussion on this.
>> Would it be possible/acceptable to make it a configuration
>> option, or even better a tunable to use the Linux scheduler
>> instead of the signal mechanism?
>>
>
> Fine with me, this can't hurt. We already have a workaround in Mercury
> for the broken PI management with condition variables in the glibc anyway.
>
>> As a kind of experiment I have created an implementation
>> based on a compilation flag in the copperplate code, did
>> some testing with it and it behaves well I think.
>>
>> If the community is open for such a thing, I'm willing to spend
>> some additional effort to change the implementation into a
>> run-time flag (tunable).
>>
>
> I would make this a static build switch. Picking the implementation that
> fits and actually works around a known bug is something that should not
> require dynamic tuning.

The idea of this flag is that it can be enabled/disabled based on some
criteria, which can depend on the application. Since we have many
applications running on the system at the same time, it will be handy
that the option can be enabled/disabled by a config flag.

>
>> The impact in the code will basically be:
>> - do not handle (start /stop) the per-thread timer.
>> - return the correct policy in prepare_rr_corespec
>>
>> The default behavior could be kept as today.
>>
>
> I would make your option the default, allowing a per-thread RR quantum
> only on demand with a config switch, since needing distinct RR time
> slices is most likely an infrequent requirement.
>

But this would mean that there is on impact on the current behavior and
all systems using Xenomai will have to adapt their configuration...

Ronny

> --
> Philippe.

