MIME-Version: 1.0
In-Reply-To: <4BB5B874.5090904@domain.hid>
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
Date: Fri, 2 Apr 2010 11:32:22 +0200
Message-ID: <k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Ok, I might give Jan's proposal a try and could be sufficient for us:a
Xenomai thread with non-RT scheduling class (didn't know that was
possible).

We just need the thread in the Xenomai domain for being able to access
Xenomai resources, but want it to be scheduled together with the Linux
nice levels. A near IDLE nice level should be ok. We just don't want
that our Xenomai 'idle' thread with a while(1) would prevent Linux to
run.

On Fri, Apr 2, 2010 at 11:27 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Henri Roosen wrote:
>>>> We have the same requirement for which we also have no solution. One
>>>> of our threads has a configurable priority of which at the lowest
>>>> priority the thread should behave like an idle task that is only
>>>> scheduled when all xenomai threads are idle and also the Linux domain
>>>> is idle. The thread might use rtdm-drivers and xenomai mutexes and
>>>> therefore has to be moved to the Xenomai domain. But then it always
>>>> has higher priority than any threads scheduled in linux.
>>> That's not true, Xenomai threads can run in non-RT scheduling classes a=
s
>>> well. They may just gain RT priority while holding some lock that is
>>> requested by a RT thread as well.
>>>
>>>> Actually, when seen from the first domain, this requirement would be
>>>> solved when we could set a first domain priority for the second
>>>> domain... Gilles, is that what is meant by the SCHED_IDLE policy for
>>>> Linux?
>>> "nice +20", thus a very small CPU share if other task are runnable.
>>>
>>> Note that "true" SCHED_IDLE, ie. no CPU share if some other task is
>>> runnable, could only work if we forbid access to Linux syscalls for suc=
h
>>> tasks - not feasible.
>>
>> Actually, "nothing is impossible": That task could gain normal Linux
>> priority while running the syscall. But it would have to loose
>> immediately again when leaving Linux. So no lazy mode switching like we
>> do for other Xenomai tasks, otherwise these tasks would loose there idle
>> property after the first syscall.
>>
>> The point is that things get fairly special and maybe invasive to
>> Xenomai, and I'm still not seeing the practical benefit compared to nice
>> 19 or 20.
>
> I think the problem is not to have a "true" SCHED_IDLE when running
> under Linux scheduler, but rather when running under Xenomai scheduler.
> And that can probably be arranged by implementing the SCHED_IDLE policy
> for Xenomai.
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

