Message-ID: <48C0C95E.7020709@domain.hid>
Date: Fri, 05 Sep 2008 07:53:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200808312323.29665.berlemont.hauw@domain.hid>	<48BCF4D9.8030100@domain.hid>
	<200809030148.06130.berlemont.hauw@domain.hid>
In-Reply-To: <200809030148.06130.berlemont.hauw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE8CA6FC35FDA9B2843646F1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] skin RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE8CA6FC35FDA9B2843646F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexis Berlemont wrote:
> Hi,
>=20
>>> - Or do you expect a more complete solution like fuse or fusd ?
>> There are a few tricky parts when you want a seamless driver API,
>> allowing to test or even use RTDM drivers in userspace:
>>
>>  - IRQ handling (means: forwarding, acknowledging, sharing).
>>    You won't be able to achieve 100% equivalent functionality here, of=

>>    course.
>=20
>=20
> On that point I thought about some hidden dedicated task(s) / thread(s)=
:=20
> either one task per interrupt or one task per CPU for all interrupt (th=
e=20
> second alternative may seem better).

=46rom the locking perspective, this sounds reasonable. But fault
containment will be harder to achieve then.

>=20
> The issue is to be as close as possible from the functioning in kernel =
mode:
> -> This task must work with the highest priority as an IRQ handler cann=
ot be=20
> preempted (yet...).
> -> The spinlock mechanism could be emulated thanks to an "interrupt" lo=
ck (to=20
> emulate irq masking and a common mutex. Thus, by taking the "interrupt"=
 lock,=20
> any RT task can indirectly prevent the IRQ user-handler execution.

The spinlock can remain as is, but the interrupt locking part (as well
as its stand-alone version) will require some thoughts. It has some
implicit property: no reschedule on the current CPU. That should be
preserved for the tasks the driver interacts with.

>=20
>>  - Managing the driver context.
>>    When in kernel space, driver code can run in RTDM tasks (that trivi=
al
>>    to port), in IRQ context (=3D> probably some carrier task then) or
>>    caller context - and here the problem starts. Single-user drivers
>>    could simply run as library within the context of the user, but for=

>>    shared drivers we need some framework that deals with accessing use=
r
>>    data which we could easily in kernel space, but not when the driver=

>>    has its own process or should run within multiple user space
>>    contexts.
>=20
> The driver code would be executed by a process but this driver context =
would=20
> be hidden behind the context of the application which uses the driver. =

>=20
> Here are the cases, I have in my head:
> -> one application uses one device managed by one kernel module (like m=
isc=20
> device); =3D> the simplest case: with one thread inside the driver=20
> user-process, we emulate the application context;
> -> many applications uses the same device managed by one kernel module =
=3D> if=20
> we are on a SMP config, we might need one thread per CPU-core inside th=
e=20
> driver user-process;
> -> many applications uses many devices managed by the the same kernel m=
odule=20
> (common char devices) =3D> In this configuration, a driver thread must =
wait for=20
> commands coming many contexts; however, this issue could easily be hand=
led by=20
> the kernel module devoted to redirect syscall.

The threading model is not the key here, and I don't think we need new
threads at all. What is the key is the address space organization. In
order to map the model we have with in-kernel drivers to user space, my
idea is to have a shared memory between all processes using some driver
so that this driver can access its own data from all process contexts it
may be called from. That way we could let the driver code run in te
context of the application threads under the related processes. And
there would be no need to switch the memory mapping on driver entry,
which should keep the overhead of multi-user drivers low. But this kind
of environment may be tricky to create and may contain some traps and
pitfalls I didn't find yet.

>=20
> Therefore I think such a development could be divided in two steps:
> -> the first one would be the extension of a part of the RTDM API in us=
er-mode=20
> (most of the functions located in drvlib.c)
> -> the second one would be the syscall redirection.=20

Having the basic driver lib (also the possibility to [un]register
drivers) in user space is surely a good starting point. Then one can
start writing first simple demos/test cases.

>=20
> The second part can be implemented in two ways:
> -> the RTDM kernel skin is extended;
> -> an RTDM kernel driver is developed (this driver would handle ioctl c=
oming=20
> from the user-driver (copy_from_user, register_device, wait_command, et=
c.)=20
> and the user-application (open, read, write, close).

As a second step I would focus on IRQ handling and the execution model
of non-shared (single-user) drivers that can run in the process context
of their only user (=3D> RTDM drivers as application library).

And the third step should then deal with multi-user drivers, maybe
exploring what I sketched above.

>=20
> Which one do you think is the best?
>=20
> On my side, I started the first alternative (kernel skin extension) so =
as to=20
> check that my ideas could be translated in code lines (it is just a POC=
 which=20
> does not work yet).
>=20
> Alexis.
>=20
> P.S.: I sent the first mail sunday night, I don't know why it took more=
 than=20
> one day to reach its destination.

No error message on this?

Jan


--------------enigFE8CA6FC35FDA9B2843646F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjAyW4ACgkQniDOoMHTA+leigCeNAsxXB+FFwTuHtv8IGFgH7LH
ydQAniXQSwpgKyBIZNCi7+2+YTNM4aU6
=ydSq
-----END PGP SIGNATURE-----

--------------enigFE8CA6FC35FDA9B2843646F1--

