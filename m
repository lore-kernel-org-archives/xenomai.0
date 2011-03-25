MIME-Version: 1.0
In-Reply-To: <1301086366.3221.105.camel@domain.hid>
References: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>
	<1301041270.2079.8.camel@domain.hid>
	<AANLkTikkkj0GTbpG2m8ozy8TjTJ1Yz0CHoU4FEP8dqsS@mail.gmail.com>
	<1301083171.3221.93.camel@domain.hid>
	<AANLkTinANQJYmAi942WcvnGWL4FZFJBo4S6-WxG2obKH@mail.gmail.com>
	<1301086366.3221.105.camel@domain.hid>
Date: Fri, 25 Mar 2011 17:28:07 -0400
Message-ID: <AANLkTin6ooP_SZpNoTW3+Wb_0GA2U7SotV6LTeH_qOnY@mail.gmail.com>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Scheduling questions...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Great, I think that clears it up.  Let me just make sure I understand.
 First, setting background priority (I assume you mean
sched_ss_low_priority in pthreads) to -1 will cause a thread to be
unrunnable after exhausting its credit.  Next, if I had say 4 real
time threads, and set them all to get 20mS credit every 100mS, that
would leave 20mS during which Linux would be come runnable due to the
low_priority being -1 for all RT threads, correct?

So I think I understand how this would work using the POSIX skin, but
I'm planning to do all my work with the native API.  I'm a bit
concerned because it appears things like xnsched_sporadic members are
only manipulated in nucleus and POSIX, not native.  Can I achieve the
goal of ensuring the Linux kernel gets time to run using only the
native API?

Thanks again.

- Eric

On Fri, Mar 25, 2011 at 4:52 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Fri, 2011-03-25 at 16:43 -0400, Eric Eric wrote:
>> What I'm really asking about is specifically the "unless" clause at
>> the end of your response. =A0Assume a high priority RT thread is doing
>> something like while(1) { } and just spinning and eating CPU. =A0I would
>> like to force the Linux kernel to be scheduled for, say, up to 20mS
>> every 200mS to give it the opportunity to service Linux interrupts
>> even if the high-priority RT task is runnable (ie I want to
>> periodically preempt the RT thread and allow the Linux kernel to run
>> for a limited amount of time). =A0It looks like SCHED_SPORADIC is a way
>> to do this, I'm just not sure how to apply that to the kernel itself.
>
> Scheduling all threads your create within the SCHED_SPORADIC class, with
> specifying a background priority set to -1 for all of them would do the
> job.
>
>>
>> Thanks,
>>
>> - Eric
>>
>> On Fri, Mar 25, 2011 at 3:59 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> > On Fri, 2011-03-25 at 15:48 -0400, Eric Eric wrote:
>> >> Roger on the RR/FIFO scheduling question. =A0Regarding Linux starvati=
on,
>> >> it looks like pthread_setschedparam_ex can be used on a particular
>> >> Linux thread to avoid starvation, however I'm more concerned about th=
e
>> >> Linux kernel itself. =A0In the example below, I may want the kernel t=
o
>> >> have some time to service interrupts even if an RT task is behaving
>> >> badly. =A0How could I achieve this?
>> >
>> > As an extension, Xenomai interprets param.low_prio =3D=3D -1 as "suspe=
nd the
>> > thread". So each time the thread exceed its runtime credit, the nucleu=
s
>> > suspends it until it is replenished, instead of merely downgrading its
>> > priority. As a side-effect, Linux becomes runnable again (unless anoth=
er
>> > -rt thread is requesting the CPU immediately, but you get the point).
>> >
>> >>
>> >> Thanks again for the fast and helpful responses!
>> >>
>> >> - Eric
>> >>
>> >> On Fri, Mar 25, 2011 at 4:21 AM, Philippe Gerum <rpm@xenomai.org> wro=
te:
>> >> > On Thu, 2011-03-24 at 19:47 -0400, Eric Eric wrote:
>> >> >> Hello, I've been reading through some of the documentation and hav=
e a
>> >> >> few questions regarding scheduling:
>> >> >>
>> >> >> - API docs say that rt_task_set_mode can allow a task to undergo
>> >> >> round-robin scheduling. =A0This seems to imply that we can have an
>> >> >> environment of mixed round-robin and FIFO task scheduling. =A0Is t=
his
>> >> >> correct? =A0If so, what is the scheduling relationship between tas=
ks
>> >> >> running in FIFO and RR modes?
>> >> >
>> >> > RR are FIFO threads within the same priority group.
>> >> >
>> >> >>
>> >> >> - I am concerned about Linux starvation. =A0For example, suppose a
>> >> >> misbehaving RT task spins and burns CPU indefinitely (watchdog
>> >> >> notwithstanding). =A0I would still like to preempt this task and a=
llow
>> >> >> Linux to run for up to some maximum time (say up to 30mS every 200=
mS).
>> >> >> =A0So, if using RR scheduling, is there a way to use rt_task_slice=
 to
>> >> >> allocate time to Linux? =A0Is there a Linux shadow thread that I c=
an
>> >> >> allocate time to?
>> >> >
>> >> > Xenomai implements sporadic server scheduling. See SCHED_SPORADIC,
>> >> > usable with int pthread_setschedparam_ex().
>> >> >
>> >> >>
>> >> >> Thank you.
>> >> >>
>> >> >> - Eric
>> >> >>
>> >> >> _______________________________________________
>> >> >> Xenomai-help mailing list
>> >> >> Xenomai-help@domain.hid
>> >> >> https://mail.gna.org/listinfo/xenomai-help
>> >> >
>> >> > --
>> >> > Philippe.
>> >> >
>> >> >
>> >> >
>> >
>> > --
>> > Philippe.
>> >
>> >
>> >
>
> --
> Philippe.
>
>
>

