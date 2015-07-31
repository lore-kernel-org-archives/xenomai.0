Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <55BA500F.8010504@xenomai.org>
Date: Fri, 31 Jul 2015 08:50:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <EDF30F93-FA23-49BE-8EAF-FD2DBE0A1F66@gmail.com>
References: <09EA8A4C-D8EB-4470-A339-C2019D1B662B@gmail.com>
 <55BA500F.8010504@xenomai.org>
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


> Am 30.07.2015 um 18:25 schrieb Philippe Gerum <rpm@xenomai.org>:
>=20
> On 07/30/2015 07:26 AM, Michael Haberler wrote:
>> we're happily using RT threads using the Xenomai 2 thread API
>>=20
>> is it possible _using this API_ to create/mutate/relax such a thread =
intentionally into a Posix thread but retaining the API usage?
>=20
> It is possible to run them as low priority Xenomai threads, assigning
> them to the SCHED_OTHER class. The native API is retained for those
> threads, but their main runtime mode is relaxed, i.e. the co-kernel
> makes sure to switch them back to relaxed mode automatically before
> returning to user-space from a syscall which required a switch to
> primary mode.

that would give us 'low-priority RT (SCHED_OTHER)' threads which is =
already a great improvement for us, and it would be simple to do as you =
outlined in the followup mail


taking things one step further (I'm unsure about the precise semantics =
of 'relaxed mode', so far I understood it as 'behaves like a normal =
Linux thread'):

would such a SCHED_OTHER-class thread be able to use _any_ system calls =
like a normal Linux thread? like file I/O, sockets, poll, etc?

if so - are there any side effects I should be aware of?

(I guess my question really is: does 'relaxed mode equals Linux thread =
semantics' hold?)


>=20
>>=20
>> I can do any conditional API usage through thread parameters to avoid =
calls which will not work for a relaxed thread, but I would like to =
retain the API (I guess I could switch to the posix skin but I would =
like to avoid another learning curve/test cycle for now)
>>=20
>> going forward/Xenomai 3: what would be your recommendation to address =
the issue long-term?=20
>>=20
>=20
> Xenomai 3 in dual kernel mode extends the feature above, with the
> SCHED_WEAK class:
> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Scheduling
>=20
>>=20
>>=20
>>=20
>> (may sound like whacky question but great use case around here - =
turns out many jobs do not need RT capabilities but it would be handy to =
retain the flow)
>>=20
>=20
> If I interpreted your question properly, it's definitely a legitimate
> use case; sometimes the non-rt stuff may want to interact with the rt
> world using Xenomai APIs, but without getting in the way =
priority-wise.

exactly. The unknown for me is: can that quasi-non-rt thread do more =
than a bona-fide RT thread.=20

For comparison: in the RT-PREEMPT flavor of our stack, to achieve the =
same effect we'd just skip the sched_setscheduler(0, SCHED_FIFO, ..) =
step on thread creation and have the desired result.

thanks for clarifying - that really helps!

Michael


>=20
> --=20
> Philippe.


