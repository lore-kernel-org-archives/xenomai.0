MIME-Version: 1.0
Date: Mon, 7 Jul 2008 15:19:06 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <487201E0.9080700@domain.hid>
References: <487201E0.9080700@domain.hid>
Message-ID: <1c0cec5bc2f1021b5f987524064973a8@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, 07 Jul 2008 13:45:36 +0200, Philippe Gerum <rpm@xenomai.org> wrot=
e:
> Matthieu wrote:
>> Hi
>>
>> Well I'm going to try to be clear :
>>
>> I work on a project that aims at migrating VxWorks tasks from PPC boar=
ds
> on
>> VME crate to X86 Computer ruuning with Linux. The cost of using Xenoma=
i
> API
>> instead of vxworks skin seems very costly. The idea is to keep the
> maximum
>> of mechanisms.
>>
>> As there is no implementation of vxworks periodic task instruction, th=
e
>> idea was to use watchdogs. In fact, as watchdogs are counting from
> ticks,
>> it's easy to make tasks periodic if the period of the task is a multip=
le
> of
>> the tick period. So each task starts it's watchdog, executes some
> routine,
>> and suspends itself. The watchdog, when the specified delay ticks
> elapsed,
>> resumes the task. And so on...
>=20
> You may want to use a semaphore to synchronize your wd handler with the
> task
> instead of suspend/resume calls.
>=20

Sorry, it was a mistake from me, semaphores are used instead of
suspend/resume.

>>
>> The use of multiple PPC boards, with periodic tasks that need to be
>> synchronized, has required the use of an hardware interrupt, spread to
> all
>> CPUs, and which handler tickAnnouce() vxworks. I know that this
> mechanism
>> isn't still necessary as there is only one vxworks tick on Xenomai, ev=
en
> if
>> I work with many CPUs.
>=20
> Wrong, Xenomai ticks on each CPU because internal timers are per-cpu
> resources;
> only the boot CPU tracks jiffies, but that's a different issue.
>=20
>  But in the new configuration, I have a PCI card that
>> will send this interrupt. So I need to stop the automatic vxworks tick
> with
>> tick_arg=3D0 and to handle this interrupt to tickAnnouce() manually. A=
s I
>> will don't have this card all the day, I need to simulate this mecanis=
m,
>> and I need to create something that will tickAnnouce() at a periodic
> time.
>>
>> I created a module that, in on case, will handle the interrupt, and on
> an
>> other case, will create a xenomai rt_task that tickAnnouce. And this
>> doesn't work. I want the ioctl method send the period to the module in
>> order to modify the period of the tick.
>>
>> I still have created this driver has you see but it doesn't work.
>=20
> What your code did is switching the VxWorks timer to aperiodic mode whi=
ch
> stops
> periodic timing; in that mode, the time unit is nanosecond, so every
> timeout
> data is interpreted as a count of nanoseconds. This is likely not what
you
> want.
>=20
>  I'm going
>> to test your modifications. Thank you for that.
>>
>=20
> Forget about this example; actually, those changes do not fix the logic=
,
> but
> only provide some hints about xntbase_switch(), and fix return code
> issues.
>=20
>> I will also need to get a precise time, and Gilles suggest me to use
>> xntbase, but xntbase_get_time(&nktbase); isn't recognized.
>=20
> What Gilles told you is that solely switching the VxWorks clock to
> aperiodic
> mode (by passing period =3D=3D 0) would wreck the underlying timing log=
ic of
a
> VxWorks app, which does not pass/expect nanoseconds but jiffies/ticks. =
In
> short,
> doing so is not enough.
>

I need a clock to get the time with a 10 =C2=B5s precision. I tought usin=
g this
master timebase, as it gives me a time in nanoseconds, irrespective of
vxworks timebase.=20

> Normally, solving your issue would require to make the master timebase
> paced by
> your PCI card, which would in turn provide the correct timing for the
> VxWorks
> timebase (as the timebase doc states, periodic timebases are cascaded
from
> the
> master aperiodic one). However, doing so would also require to adapt th=
e
> Xenomai
> HAL code accordingly, and a PCI hw that is oneshot programmable as well=
.
>=20
> If you want to hack the Xenomai timer sub-system in order to only affec=
t
> the
> VxWorks timebase, what you actually need is to control the coupling
> between the
> master timebase (paced by decrementer) and the slave VxWorks one, so th=
at
> decrementer ticks may be prevented from kicking the VxWorks timebase.
This
> way,
> you would be able to call tickAnnounce() freely to announce any incomin=
g
> VxWorks
> tick (i.e. from your PCI handler).
>=20
> In short, when paced by the PCI interrupt, you will need to:
>=20
> - call xntslave_stop(base2slave(wind_tbase))
> - call tickAnnounce() from your PCI IRQ handler
>=20
> When paced normally (simulation, "somebody stole by PCI card" mode), ju=
st
> leave
> the burden to the system timer (i.e. ppc decrementer) as usual, by
> coupling the
> VxWorks slave timebase to the master one anew:
>=20
> - call xntslave_start(base2slave(wind_tbase),  xnarch_get_cpu_time() +
> period,
> period); /* period is given in nanoseconds, depends on the master
timebase
> */
>=20
> In any case, you don't need to change the VxWorks tick period.
> Starting/stopping
> the VxWorks timebase should do the trick. NOTE: this is a hack exposing
> Xenomai
> internals -- we should probably encapsulate this into new
> xntbase_bind/unbind
> calls if this does eventually works for you.
>=20

You are right. It was un misunderstanding because I still don't know the
impact of tick_arg.
What you propose is very interesting. I's easier than what I tried to do.
xntbase_bind/unbind seems to be a good solution. I would like to know fro=
m
where I would be able to use these calls (kernel/user space) ?
What I need is to select the simulation working mode (without the card) o=
r
the PCI IRQ mode during the execution of my code (whose exectution is in
user space). If I'm working in simulation mode, I also need to specify th=
e
tick period at the begining of the execution (1ms or 5ms).

> --
> Philippe.

Matthieu



