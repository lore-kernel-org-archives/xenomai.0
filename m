Message-ID: <43D62B07.3030703@domain.hid>
Date: Tue, 24 Jan 2006 14:26:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	
	<b647ffbd0601220010x3cc023an@domain.hid>	
	<fd6a47a90601220819n3f4cd382t@domain.hid>	
	<E1F16LA-0001ku-C4@domain.hid>
	<b647ffbd0601240514m11a11a64u@domain.hid>
In-Reply-To: <b647ffbd0601240514m11a11a64u@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig444206F13D2247D0FD0E3DF6"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig444206F13D2247D0FD0E3DF6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 23/01/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wr=
ote:
>> Jeroen Van den Keybus wrote:
>>> Hello,
>=20
>=20
>=20
>> [ skip-skip-skip ]
>>
>=20
>=20
>> Since in xnshadow_harden, the running thread marks itself as suspended=

>> before running wake_up_interruptible_sync, the gatekeeper will run whe=
n
>> schedule() get called, which in turn, depend on the CONFIG_PREEMPT*
>> configuration. In the non-preempt case, the current thread will be
>> suspended and the gatekeeper will run when schedule() is explicitely
>> called in xnshadow_harden(). In the preempt case, schedule gets called=

>> when the outermost spinlock is unlocked in wake_up_interruptible_sync(=
).
>=20
>=20
> In fact, no.
>=20
> wake_up_interruptible_sync() doesn't set the need_resched "flag" up. Th=
at's
> why it's "sync" actually.
>=20
> Only if the need_resched was already set before calling
> wake_up_interruptible_sync(), then yes.
>=20
> The secuence is as follows :
>=20
> wake_up_interruptible_sync ---> wake_up_sync ---> wake_up_common(...,
> sync=3D1, ...) ---> ... ---> try_to_wake_up(..., sync=3D1)
>=20
> Look at the end of  try_to_wake_up() to see when it calls resched_task(=
).
> The comment there speaks for itself.
>=20
> So let's suppose need_resched =3D=3D 0 (it's per-task of course).
> As a result of wake_up_interruptible_sync() the new task is added to th=
e
> current active run-queue but need_resched remains to be unset in the ho=
pe
> that the waker will call schedule() on its own soon.
>=20
> I have CONFIG_PREEMPT set on my machine but I have never encountered a =
bug
> described by Jan.
>=20
> The catalyst of the problem,  I guess, is  that some IRQ interrupts a t=
ask
> between wake_up_interruptible_sync() and schedule() and its ISR, in tur=
n,
> wakes up another task which prio is higher than the one of our waker (a=
s a
> result, the need_resched flag is set). And now, rescheduling occurs on
> return from irq handling code (ret_from_intr -> ...-> preempt_irq_sched=
ule()
> -> schedule()).

Yes, this is exactly what happened. I unfortunately have not saved a
related trace I took with the extended ipipe-tracer (the one I sent ends
too early), but they showed a preemption right after the wake_up, first
by one of the other real-time threads in Jeroen's scenario, and then, as
a result of some xnshadow_relax() of that thread, a Linux
preempt_schedule to the gatekeeper. We do not see this bug that often as
it requires a specific load and it must hit a really small race window.

>=20
> Some events should coincide, yep. But I guess that problem does not occ=
ur
> every time?
>=20
> I have not checked it yet but my presupposition that something as easy =
as :
>=20
> preempt_disable()
>=20
> wake_up_interruptible_sync();
> schedule();
>=20
> preempt_enable();

It's a no-go: "scheduling while atomic". One of my first attempts to
solve it.

The only way to enter schedule() without being preemptible is via
ACTIVE_PREEMPT. But the effect of that flag should be well-known now.
Kind of Gordian knot. :(

>=20
>=20
> could work... err.. and don't blame me if no, it's some one else who ha=
s
> written that nonsense :o)
>=20
> --
> Best regards,
> Dmitry Adamushko
>=20

Jan


--------------enig444206F13D2247D0FD0E3DF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD1isHniDOoMHTA+kRAh+hAJ9eHJQ6h2fkvpteEaaanFaWW4wSvACdGEMn
08zB+5FlRVVzQzXZshYVoXo=
=NbUO
-----END PGP SIGNATURE-----

--------------enig444206F13D2247D0FD0E3DF6--

