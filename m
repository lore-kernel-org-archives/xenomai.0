Message-ID: <48804E28.80906@domain.hid>
Date: Fri, 18 Jul 2008 10:02:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1216282324.3472.29.camel@domain.hid>
In-Reply-To: <1216282324.3472.29.camel@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Generel problem with realtime-tops(like adeos)
 over	linux-kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

Schl=E4gl Manfred jun. wrote:
> Hi!
>=20
> I think we've discovered a generell logical problem with realtime-tops
> like adeos over the linux-kernel.
>=20
> The basic-assumption of such an system is: Linux is not a
> realtime-system, so it is not able to provide realtime to it's services,
> so no linux-service is able to use realtime-capabilities, so no
> linux-service has realtime-requirements.
>>From this it follows that we are able use a top like adeos (send
> interrupts later, always interrupt the linux-kernel).
>=20
> But... Linux is able to provide hard-realtime while interrupts are
> locked. And many services(driver) use this.
>=20
> abstract example:
> {{{
> spin_lock_irqsave
> if(hardware_data_valid())
> 	process_hardware_data()
> spin_lock_irqrestore
> }}}

Well, real-time is not about allowing this handler to perform un-preempted,=
 but
rather to guarantee that the highest priority code will always get the CPU =
at
any point in time. If that handler is the most time-critical work to do on =
your
box, that's fine. But if it's not, this code is wrong, because it basically
wrecks real-time behaviour.

Actually, your basic assumption is flawed on a regular SMP kernel: what if =
the
lock is currently held by a task running on another CPU, that ends up being
preempted by an IRQ, or any higher priority task? Unless running a RT-capab=
le
system, common spinlock loops are entered with hw interrupts off, therefore=
, you
end up locking interrupts for an undefined amount of time on your local CPU,
before being able to enter your critical section. So much for predictabilit=
y,
both for entering that critical section, but above all for any other code t=
hat
would want to get the local CPU attention asap while your code is waiting f=
or
the lock.

Masking interrupts may solve the preeemption issue on a uniprocessor box, b=
ut
this does not guarantee that any other time-critical part of the system
requiring immediate attention, because of its higher priority, will get the=
 CPU
on time. Therefore, I don't see how this construct could be used to enforce
real-time, precisely because it completely ignores priorities.

> works fine without adeos,

In fact, it does not work in a reliable manner, without actual RTOS support.
The point is not about Adeos, which is only an enabler for real-time suppor=
t,
which in turn brings proper preemption and priority management.

> but with adeos there may be a relative long
> interruption between validation and processing. The hardware may overrun
> and process_hardware_data is called without valid data...
>=20
> In our case we have this problem while the rx-interrupt of our
> ethernet-driver. The dma is running permanently and generates an overrun
> between the error-checking(which would catch the overrun) part and the
> data-processing part of the handler.
>=20
> I think it is possible that there could be many such (latent) problems
> in linux-kernel. For example USB which itself has realtime-requirements,
> or eventually mtd (lost data as cause of wrong flash-write/erase
> timings), ...

The whole idea underlying dual RT/non-RT systems, is that RT processes
1) share the available CPU horsepower between them all according to arbitra=
ry
priorities, 2) should be part of a software system that leaves some cycles =
to
the non-RT processes whenever possible.

The example you described says basically: 1) any time-critical driver may l=
ock
interrupts out in order to complete its duty un-preempted, 2) all time-crit=
ical
drivers have to perform their duty without stepping on each others toes wit=
h the
rather limited help of a single giant traffic light (i.e. hw interrupt mask=
ing,
and no priority scheme).

When designing such a system, you would have to think about the potential d=
amage
high priority tasks may cause to low priority tasks, because of preemption,=
 or
absence therereof. But again, you would have to do that with all kinds of RT
frameworks. This is something which could only be sorted out at coding desi=
gn
level, which means that you would have to review the locking scheme for all
time-critical sections you want to care of in any case.

Once identified, those sections can be fixed individually, including with A=
deos.
If they happen to be too complex for using a different kind of (ironed,
Adeos-aware) lock, then maybe they do not qualify for being atomic in the f=
irst
place.

Practically, if you don't want to put your MTD flash at risk on a dual RT/G=
POS
design, use VxWorks, but in that case, do not run the MTD task along with o=
ther
tasks that may preempt it for a dangerously long time. Back to square #1, I=
'm
afraid, you have to know what your RT constraints are.

>=20
> So ... what do you think about that.
>

Native preemption turns spinlocks into rt-mutexes, which allows the code fl=
ow to
be diverted from the critical section for an undefined amount of time when =
the
CPU has to turn its attention to a higher priority task. So your spinlock
actually gives you no guarantee beyond proper serialization of the section =
in
question. Therefore, the issue you raised is not a co-kernel problem, it si=
mply
expresses a general question about any RT design: which activity has highest
priority and lowest response time required? I don't think your are going to=
 get
away with that problem only relying on hw interrupt masking.

To sum up, if a system has multiple time-critical duties to perform, well, I
see no other option than enumerating them, and building a sane priority des=
ign
accordingly. Depending on multi-domain execution the Adeos way, or native
preemption makes no difference here. At the end of the day, both of them wi=
ll
bring predictability to my RT code, whilst a non-RT kernel will certainly
cause me headaches.

--=20
Philippe.






