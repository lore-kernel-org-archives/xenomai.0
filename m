Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <55BB8129.8040807@xenomai.org>
Date: Fri, 31 Jul 2015 17:17:43 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <A93F4986-FE56-4D84-9D5C-9D960D1CD32A@gmail.com>
References: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
 <55BA500F.8010504@xenomai.org>
 <EDF30F93-FA23-49BE-8EAF-FD2DBE0A1F66@gmail.com>
 <55BB305C.9000702@xenomai.org>
 <F67D2A98-6335-49CB-A641-E74DF8B979A8@gmail.com>
 <55BB8129.8040807@xenomai.org>
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


> Am 31.07.2015 um 16:07 schrieb Philippe Gerum <rpm@xenomai.org>:
>=20
> On 07/31/2015 11:21 AM, Michael Haberler wrote:
>> Philippe,
>>=20
>> this is excellent news because this means the scheme would work _and_ =
improve versatility.
>>=20
>> I have only an optimization question left:
>>=20
>>> Am 31.07.2015 um 10:22 schrieb Philippe Gerum <rpm@xenomai.org>:
>>>=20
>>> On 07/31/2015 08:50 AM, Michael Haberler wrote:
>>>> Philippe,
>>>>=20
>>>>=20
>>>>> Am 30.07.2015 um 18:25 schrieb Philippe Gerum <rpm@xenomai.org>:
>>>>>=20
>>>>> On 07/30/2015 07:26 AM, Michael Haberler wrote:
>>>>>> we're happily using RT threads using the Xenomai 2 thread API
>>>>>>=20
>>>>>> is it possible _using this API_ to create/mutate/relax such a =
thread intentionally into a Posix thread but retaining the API usage?
>>>>>=20
>>>>> It is possible to run them as low priority Xenomai threads, =
assigning
>>>>> them to the SCHED_OTHER class. The native API is retained for =
those
>>>>> threads, but their main runtime mode is relaxed, i.e. the =
co-kernel
>>>>> makes sure to switch them back to relaxed mode automatically =
before
>>>>> returning to user-space from a syscall which required a switch to
>>>>> primary mode.
>>>>=20
>>>> that would give us 'low-priority RT (SCHED_OTHER)' threads which is =
already a great improvement for us, and it would be simple to do as you =
outlined in the followup mail
>>>>=20
>>>>=20
>>>> taking things one step further (I'm unsure about the precise =
semantics of 'relaxed mode', so far I understood it as 'behaves like a =
normal Linux thread'):
>>>=20
>>> By relaxed, I mean scheduled by the regular kernel as any other
>>> non-Xenomai thread, not by the Xenomai scheduler. As a consequence =
of
>>> this, no rt guarantee, no pressure for very short response time.
>>>=20
>>>>=20
>>>> would such a SCHED_OTHER-class thread be able to use _any_ system =
calls like a normal Linux thread? like file I/O, sockets, poll, etc?
>>>>=20
>>>=20
>>> Yes. The only issue to care about is not passing file descriptors
>>> obtained by the Xenomai open() call to regular Linux I/O services. =
The
>>> converse works with the POSIX API though, since the Xenomai I/O
>>> subsystem hands over requests for fds it does not own to the
>>> corresponding glibc call.
>>=20
>> not an issue since Xenomai file descriptors not used, but good to =
know
>>=20
>>>=20
>>>> if so - are there any side effects I should be aware of?
>>>>=20
>>>=20
>>> None. However, switching a non-rt Xenomai thread back and forth =
between
>>> the Xenomai and Linux sides involves several scheduling operations =
each
>>> time (one less for 3.x compared to 2.x though). Therefore, it is =
better
>>> if the low priority thread does not have to do this at a high rate, =
it's
>>> faily costly CPU-wise.
>>=20
>> I just went through the code to see which native services are used =
post creation:
>>=20
>> every thread cycle:
>> rt_task_wait_period()=20
>> rt_timer_read().
>> rt_task_self() (unsure, need to check usage)
>>=20
>> rarely:
>> rt_task_inquire()
>> rt_task_suspend()
>> rt_task_resume()
>>=20
>> at thread exit: rt_task_delete() rt_task_join() but I guess not =
relevant
>>=20
>> Assuming your load concern applies for these calls likewise, I see =
two options:
>>=20
>> a) since the relax would happen intentionally through a startup =
option, I could have the thread check its descriptor and figure 'I =
better avoid native services' and use equivalent non-RT Linux services
>> b) if there is a cheap way of introspecting on the 'am I a relaxed =
thread?' property of a thread I could make the conditional API usage =
self-contained, i.e. without reference to our task descriptor; and it =
would help reducing API breakage.
>>=20
>> I assume rt_task_self() is the right one. Do you think that is cheap =
enough to pursue option b) ?
>>=20
>>=20
>=20
> rt_task_self() would return a valid descriptor for both SCHED_OTHER =
and
> SCHED_FIFO threads, provided they are Xenomai threads. You need
> something cheap that would quickly tell the caller about its
> capabilities as a Xenomai thread instead.
>=20
> With 2.x, you could hack that check with xeno_get_current_mode(), =
which
> is part of the internal API, testing the XNOTHER bit there. Have a =
look
> at src/skins/native/mutex.c for some examples. XNOTHER is armed for
> Xenomai-managed SCHED_OTHER threads. This only entails a plain memory
> reference, so this is cheap enough. Granted, this is an internal call,
> so no guarantee for backward compat. But Xenomai 2.x is virtually EOL
> already, there will be no 2.7, so that feature is there to stay
> indefinitely.

fine, I'll manage that.

any suggestions for Xenomai 3? If too hairy, I'll go for the 'inspect =
our own thread descriptor' option.

thanks,

- Michael

>=20
> --=20
> Philippe.


