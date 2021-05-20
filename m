MIME-Version: 1.0
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
 <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
In-Reply-To: <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Thu, 20 May 2021 17:39:30 +0200
Message-ID: <CADYdroOCUu7BWqMZ1CMa5mHSJB50V1aS+98sVfgXQRPdnJTyYg@mail.gmail.com>
Subject: Re: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: MONTET Julien <julien.montet@reseau.eseo.fr>, lttng-dev <lttng-dev@lists.lttng.org>, Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Am Do., 20. Mai 2021 um 17:09 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 9:56 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>
> > ----- On May 20, 2021, at 9:54 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >
> >> ----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >>
> >>> Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
> >>> <julien.montet@reseau.eseo.fr>:
> >>>>
> >>>> Hi Norbert,
> >>>>
> >>>> Thank you for your answer !
> >>>>
> >>>> Yes, I am using a Xenomai cobalt - xenomai is 3.1
> >>>> cat /proc/xenomai/version => 3.1
> >>>>
> >>>> After the installation, I tested "test tools" in /proc/xenomai/ and it worked
> >>>> nice.
> >>>
> >>> Just asked to make sure, thought the scripts usual add some -xeno tag
> >>> to the kernel version.
> >>>
> >>>> What do you mean by "it might deadlock really good" ?
> >>>
> >>> clock_gettime will either use a syscall (kills realtime always) or is
> >>> optimized via VDSO (which very likely is your case).
> >>>
> >>> What happens is that the kernel will take a spinlock, then write new
> >>> values, then releases the spinlock.
> >>> your program will aswell spin (but just to see if the spinlock is
> >>> free), read the values and interpolates them.
> >>>
> >>> But if your program interrupts the kernel while the kernel holds the
> >>> lock (all on the same cpu core), then it will spin forever and the
> >>> kernel will never execute.
> >>
> >> Just one clarification: the specific locking strategy used by the
> >> Linux kernel monotonic clock vDSO is a "seqlock", where the kernel
> >> sets a bit which keeps concurrent readers looping until they observe
> >
> > When I say "sets a bit", I actually mean "increment a sequence counter",
> > and readers observe either odd or even state, thus knowing whether
> > they need to retry, and whether the value read before/after reading
> > the data structure changed.
>
> Looking again at the Linux kernel's kernel/time/vsyscall.c implementation
> of vdso_update_{begin,end}, I notice that interrupts are disabled across
> the entire update. So I understand that the Interrupt pipeline (I-pipe)
> interrupt gets delivered even when the kernel disables interrupts. Did
> you consider modifying the I-pipe kernel patch to change the vdso update so
> it updates the vdso from within an I-pipe virq handler ?

Yes, I did use an non-upstreamed patch for a while to get things in order:
https://www.xenomai.org/pipermail/xenomai/2018-December/040134.html

I would prefer just a NMI safe source that might jump back a bit, no matter how.

> AFAIU this would allow Xenomai userspace to use the Linux kernel vDSO
> clock sources.

The Xenomai folks are trying to get their next-gen abstraction "dovetail" closer
coupled to the kernel, AFAIR their will be VDSO support and
unification of the clock sources.

Still need to get stuff running today =)

Norbert

