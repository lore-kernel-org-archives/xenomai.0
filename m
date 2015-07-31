Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <55BB305C.9000702@xenomai.org>
Date: Fri, 31 Jul 2015 11:21:20 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <F67D2A98-6335-49CB-A641-E74DF8B979A8@gmail.com>
References: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
 <55BA500F.8010504@xenomai.org>
 <EDF30F93-FA23-49BE-8EAF-FD2DBE0A1F66@gmail.com>
 <55BB305C.9000702@xenomai.org>
Subject: Re: [Xenomai] mutate/start RT_TASK a posix thread?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Philippe,

this is excellent news because this means the scheme would work _and_ =
improve versatility.

I have only an optimization question left:

> Am 31.07.2015 um 10:22 schrieb Philippe Gerum <rpm@xenomai.org>:
>=20
> On 07/31/2015 08:50 AM, Michael Haberler wrote:
>> Philippe,
>>=20
>>=20
>>> Am 30.07.2015 um 18:25 schrieb Philippe Gerum <rpm@xenomai.org>:
>>>=20
>>> On 07/30/2015 07:26 AM, Michael Haberler wrote:
>>>> we're happily using RT threads using the Xenomai 2 thread API
>>>>=20
>>>> is it possible _using this API_ to create/mutate/relax such a =
thread intentionally into a Posix thread but retaining the API usage?
>>>=20
>>> It is possible to run them as low priority Xenomai threads, =
assigning
>>> them to the SCHED_OTHER class. The native API is retained for those
>>> threads, but their main runtime mode is relaxed, i.e. the co-kernel
>>> makes sure to switch them back to relaxed mode automatically before
>>> returning to user-space from a syscall which required a switch to
>>> primary mode.
>>=20
>> that would give us 'low-priority RT (SCHED_OTHER)' threads which is =
already a great improvement for us, and it would be simple to do as you =
outlined in the followup mail
>>=20
>>=20
>> taking things one step further (I'm unsure about the precise =
semantics of 'relaxed mode', so far I understood it as 'behaves like a =
normal Linux thread'):
>=20
> By relaxed, I mean scheduled by the regular kernel as any other
> non-Xenomai thread, not by the Xenomai scheduler. As a consequence of
> this, no rt guarantee, no pressure for very short response time.
>=20
>>=20
>> would such a SCHED_OTHER-class thread be able to use _any_ system =
calls like a normal Linux thread? like file I/O, sockets, poll, etc?
>>=20
>=20
> Yes. The only issue to care about is not passing file descriptors
> obtained by the Xenomai open() call to regular Linux I/O services. The
> converse works with the POSIX API though, since the Xenomai I/O
> subsystem hands over requests for fds it does not own to the
> corresponding glibc call.

not an issue since Xenomai file descriptors not used, but good to know

>=20
>> if so - are there any side effects I should be aware of?
>>=20
>=20
> None. However, switching a non-rt Xenomai thread back and forth =
between
> the Xenomai and Linux sides involves several scheduling operations =
each
> time (one less for 3.x compared to 2.x though). Therefore, it is =
better
> if the low priority thread does not have to do this at a high rate, =
it's
> faily costly CPU-wise.

I just went through the code to see which native services are used post =
creation:

every thread cycle:
rt_task_wait_period()=20
rt_timer_read().
rt_task_self() (unsure, need to check usage)

rarely:
rt_task_inquire()
rt_task_suspend()
rt_task_resume()

at thread exit: rt_task_delete() rt_task_join() but I guess not relevant

Assuming your load concern applies for these calls likewise, I see two =
options:

a) since the relax would happen intentionally through a startup option, =
I could have the thread check its descriptor and figure 'I better avoid =
native services' and use equivalent non-RT Linux services
b) if there is a cheap way of introspecting on the 'am I a relaxed =
thread?' property of a thread I could make the conditional API usage =
self-contained, i.e. without reference to our task descriptor; and it =
would help reducing API breakage.

I assume rt_task_self() is the right one. Do you think that is cheap =
enough to pursue option b) ?


this might be already rearranging deck chairs though - the question of =
CPU cost might not be that important after all:

the feature is intended to be used for throwing spare cores at jobs =
which are not time-critical, and they might use more of the Linux API =
while at it; but without having to rewrite too much

>=20
>> (I guess my question really is: does 'relaxed mode equals Linux =
thread semantics' hold?)
>>=20
>>=20
>=20
> Almost, with the added bonus of being able to synchronize with other
> Xenomai threads (rt and non-rt) as well, which a regular Linux thread =
can't.
>=20
> The gist of the matter is about being able to block/sleep on Xenomai
> synchronization objects, such as sem4s, mutexes, queues, events, etc: =
to
> do that, the caller has to provide a Xenomai-originated task control
> block to the co-kernel, so that it can be queued in the Xenomai
> scheduler runqueues. That control block is semantically equivalent to
> the "struct task_struct" type in the Linux kernel, but for =
representing
> a thread that can be scheduled by the Xenomai kernel.
>=20
> Threads created by any of the Xenomai APIs bind themselves to the
> co-kernel when emerging (see the "trampoline" routines in the library
> code), getting that special task control block addition in the =
process.
> Once done, those threads can sleep on Xenomai resources. Regular =
(glibc)
> threads don't bind themselves to Xenomai, so they may not sleep on =
such
> resources, and will get EPERM if attempting to do so. That particular
> action of extending a regular Linux thread with a Xenomai TCB is =
called
> "shadowing" in our parlance, i.e. a Xenomai-specific shadow control
> block gets added to the common Linux-originated task_struct.
>=20
> However, many Xenomai services which only signal resources may be =
called
> from a plain Linux context/thread, since the corresponding syscall =
does
> not have to refer to the Xenomai control block of the caller for
> carrying out the action. Typically, sem_post() is one of these.
>=20
>>>=20
>>>>=20
>>>> I can do any conditional API usage through thread parameters to =
avoid calls which will not work for a relaxed thread, but I would like =
to retain the API (I guess I could switch to the posix skin but I would =
like to avoid another learning curve/test cycle for now)
>>>>=20
>>>> going forward/Xenomai 3: what would be your recommendation to =
address the issue long-term?=20
>>>>=20
>>>=20
>>> Xenomai 3 in dual kernel mode extends the feature above, with the
>>> SCHED_WEAK class:
>>> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Scheduling
>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> (may sound like whacky question but great use case around here - =
turns out many jobs do not need RT capabilities but it would be handy to =
retain the flow)
>>>>=20
>>>=20
>>> If I interpreted your question properly, it's definitely a =
legitimate
>>> use case; sometimes the non-rt stuff may want to interact with the =
rt
>>> world using Xenomai APIs, but without getting in the way =
priority-wise.
>>=20
>> exactly. The unknown for me is: can that quasi-non-rt thread do more =
than a bona-fide RT thread.=20
>=20
> All Xenomai threads may call regular Linux services safely, the
> co-kernel detects the situation and takes care of this. One just needs
> to care about the symbol wrapping with the POSIX API, so that e.g.
> connect() calls the Xenomai service for connecting a socket endpoint,
> and __real_connect() calls the glibc version of that routine.
>=20
> The point is about picking the most appropriate type of thread =
depending
> on the expected duty:
>=20
> - don't care for low latency, only regular Linux services needed =3D>
> plain glibc/Linux threads
> - don't care for low latency, may want to synchronize (i.e. =
block/sleep)
> on Xenomai resources =3D> SCHED_OTHER as implemented by the Xenomai
> scheduler with 2.x
> - do care for latency =3D> any Xenomai policy but SCHED_OTHER (or
> SCHED_WEAK in 3.x).

well in this case it's the first option plus 'programmer too lazy to =
rewrite' ;)

thanks - that really helped my understanding how this all works!

I'll report what comes out of this

best regards

Micahel


>=20
>>=20
>> For comparison: in the RT-PREEMPT flavor of our stack, to achieve the =
same effect we'd just skip the sched_setscheduler(0, SCHED_FIFO, ..) =
step on thread creation and have the desired result.
>>=20
>=20
> That would be exactly the same with any Xenomai version and the POSIX
> API. With the native(v2.x) or alchemy(v3.x) API, you would simply pass =
a
> zero priority to rt_task_create/rt_task_shadow to leave the new thread
> in the SCHED_OTHER class, instead of SCHED_FIFO.
>=20
>> thanks for clarifying - that really helps!
>>=20
>=20
> You are welcome.
>=20
> --=20
> Philippe.


