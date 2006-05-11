Message-ID: <44635D1B.6020807@domain.hid>
Date: Thu, 11 May 2006 17:49:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Some basic questions
References: <4546494d0605110704k32c1e7c8qa7d1f1dbbf23ceb5@domain.hid>
In-Reply-To: <4546494d0605110704k32c1e7c8qa7d1f1dbbf23ceb5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: Xenomai-help@domain.hid

Li Yi (Adam) wrote:
> Hi,
>=20
> I have been getting touch with Xenomai for some time, but I still has=20
> some basic confusions (and I think these questions may be common for ne=
w=20
> users starting to write real-time application using Xenomai).
>=20
> 1. If my real-time task want to access the HW resource, like DMA,=20
> memory, Network,etc, does the task has to access through Linux kernel=20
> service of allocating DMA or allocating memory, etc. Xenomai itself doe=
s=20
> not provide HW management services, except interrupt and timer. But by=20
> using Linux kernel service, the task may suffer from the=20
> non-determinstic (non-preemptive) of Linux kernel? Is there any solutio=
n=20
> for this?
>

Xenomai is there to 1) complement Linux when it fails to be=20
deterministic, 2) provide foreign real-time API emulation unknown from=20
the Linux environment to port legacy applications. The solution is to=20
analyze the requirements of your application, so that you should be able=20
to determine which services are really required to be deterministic, and=20
in which (calling) contexts.

Some Linux services are inherently non-deterministic, e.g. you can't=20
rely on blockable kernel memory allocation requests, or on the TCP=20
protocol to get such guarantee. Once you have identified the=20
requirements, then you can pick the right tools to fulfill them in the=20
Xenomai framework, like the POSIX skin which impersonates most of the=20
RT-significant services of the regular POSIX API. If you can afford=20
calling the plain Linux services wrt induced latency, Xenomai helps by=20
allowing such call seamlessly. Said differently, the fact that an=20
application runs over an RTOS does not make it real-time, it's because=20
it properly defines its own real-time requirements that such application=20
can properly use the RTOS.

> 2. When writing a real-time task dealing with HW (that is, a real-time=20
> driver), is the RTDM the prefered interface to use? If I am to make an=20
> existing linux driver (for example, an A/D converter driver) real-time,=
=20
> and I don't want to change the code a lot, beside RTDM, what other=20
> Xenomai service (API) can I use?

Use RTDM, really.

>=20
> 3. Does it make sense that I start a real-time task using the Xenomai=20
> native API, while the task calling into Linux network stack (e.g, open =
a=20
> TCP socket)? Since the Linux network stack is not determinstic, the=20
> result is the same as I start a normal real-time linux task with=20
> SCHED_FIFO or SCHED_RR, that is, the task can be only soft-rt?
>=20

First, I would preferably use the POSIX skin and not the native API, to=20
keep my application portable from Xenomai to another RT system at low=20
cost. Yes, you read me well: Xeno strives to provide doors to get in=20
through API-agnosticism, and others to get out through deep integration=20
within the Linux environment. This is why the POSIX skin is very=20
actively enhanced and maintained.

Aside of this, yes, your analysis is mostly correct, except that TCP is=20
a no go for any real-time purpose anyway. To get a deterministic UDP/IP=20
network stack, you should have a look at RTNet.

> 4. To create a task to be fully determinstic, I need to make sure the=20
> task running in Xonomai domain. When the task need to acess HW, it=20
> should not use Linux service. Is that right?
>=20

Yes, but since RTDM provides a deterministic impersonation of the basic=20
file I/O services, you could just write a RTDM-compliant driver and=20
access it normally. Additionally, when MMIO are involved, nothing=20
prevents you from dealing with your HW from user-space directly.

> 5. What is the scheduling policy for Xenomai rt task? SCHED_RR or=20
> SCHED_FIFO? Sorry I did not found it in the document.
>=20

SCHED_FIFO when it is running under the control of the Linux kernel,=20
otherwise, it's not applicable since the Xenomai scheduler is=20
independent from the latter. The priority level is shared and consistent=20
between both execution modes though (primary-Xenomai and secondary-Linux)=
.

> 6. And finally a question specific to Blackfin: What is the purpose of=20
> starting a kernel thread for each interrupt handler in Linux kernel?
>

That's a long story, but since you asked for it, here is the main reason:

The culprit is, at your option, either my brain, or the way the Blackfin=20
determines the current execution mode of the CPU, either supervisor or=20
user, through the IPEND register. As you already know, this register=20
tracks the currently processed interrupts, by priority level, and the=20
CPU is switched to supervisor mode when at least one interrupt is marked=20
as being processed in IPEND. In consequence of what, and due to some=20
additional algorithmic hell, one must never perform context switching as=20
soon as more than a single interrupt is marked as being processed in=20
this register, which conversely means that we must wait for all=20
interrupts but the outer one to exit _before_ ever trying to call the=20
rescheduling procedure, and this also concerns Xenomai user-space tasks,=20
which are initially built over Linux tasks, then put on stero=EFds afterw=
ards.

If you don't respect this basic "don't schedule in nested interrupt=20
context" principle, the kernel will soon end up rescheduling some random=20
kernel thread while IPEND is cleared, i.e. out of the supervisor mode,=20
which means that the "Illegal use of supervisor resource" fatal=20
exception is not far away.

Now, the famous "Houston, we have a problem" episode: then, how are we=20
expected to schedule a Xenomai thread asap upon a real-time event, if we=20
are required to wait for all the currently nested non-realtime Linux=20
ISRs to finish, i.e. the ones that have precisely been preempted by the=20
real-time event? The only way I have been able to come up with was to=20
move the non-realtime Linux IRQ handlers over threads, and make all=20
Linux interrupt top-halves as short as possible, basically posting a=20
semaphore in order to wake the associated IRQ thread up. This way, the=20
Xenomai rescheduling would only be postponed for a few microseconds in a=20
time-bounded way during the execution of the short top-halves, and not=20
for a long and unbounded period of time depending on the vanilla kernel=20
ISRs.

> Sorry about so many questions and many thanks in advance!
>=20
> -Li Yi
>=20
>=20
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20

Philippe.

