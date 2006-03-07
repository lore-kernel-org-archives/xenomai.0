Message-ID: <440DC7E9.300@domain.hid>
Date: Tue, 07 Mar 2006 18:50:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-core] Fundamental Questions
References: <5D63919D95F87E4D9D34FF7748CE2C2A20688E@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A20688E@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0C06B75A7D5EFE4AA19739E"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0C06B75A7D5EFE4AA19739E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Dear Jan,
> thank you for taking time to answer my questions and=20
> sorry for the delayed response, but I have been busy=20
> with some other work.=20
> Please find my follow-up questions inserted in the text.
>=20
>>> 1.)
>>> Essentially the question deals with the problem, how long a=20
>> Xenomai task in secondary mode can be delayed by normal Linux tasks.=20
>>> In detail : we plan to to have a lot of "near realtime"=20
>> ethernet communication from within Xenomai using the normal=20
>> Linux network stack (calling the normal socket API). The=20
>> question now is, how our network communication is influenced=20
>> by other Linux tasks performing also network communication,=20
>> let=B4s say an FTP transfer ?
>>
>> Depending on the "normal" networking load, you will suffer=20
>> from more or less frequent (indeterministic) packet delays.=20
>=20
> Do you have an idea about the dimension weare talking about :
> less than a millisecond, few milliseconds, seconds, or is the
> delay complete indeterministic ?

Normally you will only see millisecond delays or less. But in case of
overload (heavy data transfers, miss-configured or virus-contaminated
nodes etc.) you may face several hundred milliseconds or more - up to
packets drops. That depends on the infrastructure (network layout,
switches and their QoS features) and cannot be answered generally. Good
QoS-aware switches can help here.

>=20
>> Xenomai will not improve this in any way. If your task in=20
>> secondary mode tries to send some data and requires to take a=20
>> networking lock currently held by another Linux task, it can=20
>> take a real long time until this request is completed.=20
>=20
>=20
>=20
> But at least, after a (linux-)systemcall (from what task ever) finished=
,=20
> Xenomai gets controll back before any other linux task, isn=B4t it ?
> This means : between systemcalls a rescheduling back to Xenomai is perf=
ormed=20
> or isn=B4t it ??

The Xenomai domain regains control as soon as a) the real-time task in
secondary mode can continue or b) some other real-time task becomes
runnable.

> Sorry for the next stupid question, but what is a network lock. With wh=
at kind of=20
> action a task can lock the complete stack ? And how long could it block=
 the stack ?
> Could you give me an example for better understanding ?

"Network lock" was an oversimplification. Actually, this is a complex
topic, and I had a wrong model in mind. To clarify:

The networking stack contains a lot of locks (NIC transmission access,
routing and ARP tables, input and output queues, ...), but they are
non-preemptible for the transmission and reception path on standard
Linux (as long as I do not oversee some corner case). So, contention is
now happening to the point where your RT-task issues a Linux syscall.
The kernel then has to preempt the interrupted Linux task (=3D interrupte=
d
by Xenomai when the RT-task became runnable) to let your task run in
secondary mode. This normally happens within a few hundred microseconds
(CONFIG_PREEMPT enabled in the kernel), but there can be scenarios where
preemption is disabled for several hundred milliseconds or more - though
very rarely with CONFIG_PREEMPT, but possible. That can be ok for soft
RT if you are able to handle the exceptions.

Besides this, another critical issue are delays due to buffer
acquisitions. If there is no fitting buffer at hand on packet arrival or
transmission request, it can take a while to free the necessary
resources, specifically if your whole system just happen to run short on
memory (swapping is taking place, some application leaked memory, ...).

>=20
>=20
>> This=20
>> gets better with PREEMPT_RT but still remains non-RT because=20
>> the Linux networking stack is not designed for hard real-time.
>>
>=20
>=20
> Next stupid question : what is PREEMPT_RT ? Is this kernel 2.6 or is it=
 the=20
> Monta Vista approach for real time (making the kernel more preemtable) =
?

Actually, neither of both. It is the ongoing community effort (which
includes MontaVista) to make the kernel natively preemptible, it is not
MontaVista's own project. Watch out for "-rt" or "real-time preempt" on
the Linux kernel mailing list, or look at
http://people.redhat.com/mingo/realtime-preempt (don't ask me for the
latest user-space pieces, i.e. glibc patches, they are either still
unpublished, well hidden, or non-existent yet).

>=20
>> If you communication can be soft-RT, you could indeed avoid=20
>> the separation - but you will then have to live with the side=20
>> effects. All you can do then is try to lower the number of=20
>> deadline misses by keeping the standard network traffic low=20
>> and managing the bandwidth of the participants (the Linux=20
>> network stack has some support for QoS, at least
>> 2.6 I think).
>>
>> BTW, as long as your network is not separated or you have no=20
>> control over the traffic arriving at your system, picking the=20
>> Linux stack in favour of RTnet (which is compatible with=20
>> non-RT networks) is indeed generally recommended. This way=20
>> you keep indeterministic load away from the real-time subsystem.
>>
>=20
> Unfortunatelly we don=B4t want to limit non realtime traffic, we just=20
> want to make shure, that deterministic traffic has a higher priority=20
> than non RT traffic (like in other RTOS like vxWorks).=20

RT !=3D RT. Soft RT is feasible with improved stacks, hard RT requires
different approaches, e.g. buffer pre-allocation or traffic control for
non-RT data. Specifically, when you read about TCP and real-time, this
can only refer to soft RT applications, as TCP do not have hard RT
characteristics (undefined timeout and packet repetition behaviour).

> Indeterministic traffic should get just the leftover bandwith.
> What do you mean with : "Rtnet is compatible with non-RT networks" ?=20

It "speaks" the same UDP/IP protocol, just removes some dynamics from
problematic parts (ARP, IP fragmentation).

> I thought RTnet uses a time slice mechanism and therefore could not be =

> mixed with systems transmitting when ever they want. Do you refer to VN=
ICs ?

That's true, mixing up RTnet with non-RT stations in the same physical
network doesn't make sense, it destroys the determinism of other RT
threads on the RTnet node.


To sum your options up:

1) Go the "hard" way, and let RTnet control both RT and non-RT traffic
as well as manage the buffer resources.

2) Mix up RT and non-RT traffic for the sake of good non-RT performance
and fair soft-RT qualities with optimisations like QoS-switches.

The question is if you can handle rare deadline misses or if you need
hard guarantees.

>=20
>>> I have created a scheduling scenario and I would ask you to=20
>> have a look on it and to tell me whether it is correct or=20
>> not. Thank you !
>>> An corresponding question about this scheduling is : are there=20
>>> differences between a 2.4 and 2.6 Linux kernel ? (for our PowerPC=20
>>> plattform we intend to use the 2.4 kernel for performance reasons)
>>>
>>> Scheduling scenario :
>>> (I hope formating is not destroyed by email transfer)
>>>
>>> Time moves downwards
>>>
>>> v-Xenomai=20
>>>      v-Linux kernel
>>>           v-Linux processes
>>>
>>>           l1   Linux task1 running
>>>      s1 < l1   Linux task1 makes systemcall
>>>      s1        Linux task1 systemcall processed
>>> -------------  Linux scheduling  =20
>>>           l2   Linux task2 starts to run
>>>      s2 < l2   Linux task2 makes systemcall
>>>      s2        Linux task2 systemcall processed
>>> +++++++++++++  Xenomai scheduling
>>> x3             Xenomai task3 starts to run =3D> primary mode
>>> x3 > s3        Xenomai task3 makes systemcall =3D> secondary mode
>>>      s3        Xenomai task3 systemcall processed=20
>>> -------------  Linux scheduling =3D> Xenomai task preemted
>> This preemption will only happen if the target Linux task has=20
>> a higher priority or the Xenomai task on secondary mode has=20
>> to block on some resource to be become free. As I sketched=20
>> above, this can actually happen in the network stack.
>=20
>=20
> What do you mean with "higher priority" ? I thought Xenomai has
> a higher priority than anything else in the linux system.

Either a Xenomai shadow thread in secondary mode or a standard task with
SCHED_FIFO/_RR set could become runnable. Xenomai will allow this switch
 - as long as no other Xenomai thread in primary mode is runnable, which
would then trigger switching back to the Xenomai domain.

> Could you give mean example about the resource (related to network
> communication) s3 could wait for ?

Yep, rescheduling due to lock contention is not likely for the
networking scenario (see above), only voluntary blocking, e.g. when
waiting on yet unavailable data.

As Linux IRQs can arrive and trigger interruptions while in secondary
mode, you may furthermore consider to use the IRQ-shield of Xenomai (see
config) to improve the predictability.

Jan


--------------enigA0C06B75A7D5EFE4AA19739E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDcfpniDOoMHTA+kRAtFrAKCEjTE/A/Tn6yEfASTD0wEh2XIEpgCeJiNc
O33LOQXhhDFbIOIaKCD5s04=
=CMKr
-----END PGP SIGNATURE-----

--------------enigA0C06B75A7D5EFE4AA19739E--

