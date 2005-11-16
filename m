Message-ID: <437AFCF7.7000304@domain.hid>
Date: Wed, 16 Nov 2005 10:33:43 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Question about shadow migration
References: <OF5FF1274A.4919E255-ONC12570BB.002EA267-C12570BB.00331586@domain.hid>
In-Reply-To: <OF5FF1274A.4919E255-ONC12570BB.002EA267-C12570BB.00331586@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A1F501F7C350D31AFA4E576"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A1F501F7C350D31AFA4E576
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>=20
> xenomai-core-bounces@domain.hid wrote on 16.11.2005 09:09:07:
>=20
>> The question for me is now if I got these details right: first a
>> migration request is issued [1] but not immediately executed,
>=20
> This request is about scheduling an APC for execution (which is lostage=
_apc
> in that case). The APC mechanism is implemented on top of the VIRQ
> mechanism so when Linux gets control back it has a pending VIRQ that wi=
ll
> be executed at the first appropriate point. It's not immediately actual=
ly
> since the Linux domain could have been preempted last time at some poin=
t
> with the interrupts off.
> The VIRQ handler, in turn, wakes up a desired process (i.e. puts it in =
the
> linux's runqueue) so it can be run again at the next preempteble point.=

> Sure, there can be other runnable processes with higher prios.
>=20
>> then the
>> priority of the root thread (Linux) is lifted to the one of the shadow=

>> thread [2]
>=20
> Yes, in order to prevent other rt activities with lower rt prios from
> preempting a soon-to-be-relaxed thread while it's going to be run in th=
e
> secondary mode. So it's about keeping the sole priority scheme across
> domains (classical RTAI does the opposite to my knowledge).
>=20
>> , and then the shadow thread is suspend with respect to the
>> xenomai scheduler [3]. The last step should let the Linux kernel start=

>> over again, run to its next preemption point (and this is the region
>> where non-deterministic delays may be injected with current kernels,
>> isn't it?),
>=20
> Yes, there are 2 points:
>=20
> - a time between a moment when the Linux domain gets control back and t=
he
> moment when VIRQ->APC->lostage_handler may be executed (*);
>=20
> e.g. the Linux domain could have been preempted last time at some point=

> with the interrupts off so we are dependent on the lenght of irq-off
> sections in the linux kernel.
>=20
> - a time between (*) and the next preemption point when a newly awakene=
n
> task may get control back.
>=20
> e.g. other asynch. activities have been previously scheduled in the lin=
ux
> domain (pending interrupts, bottom halves).
>=20
> The IRQ shield (if used) protects only from the asynch. activities that=
 may
> occur when a rt task is already executing in the linux domain, not from=

> those that were scheduled for execution before the rt task has entered =
the
> linux domain.
>=20
>=20
>> and switch over to lostage_handler() [4] to resume the Linux
>> part of the shadow thread. After that the execution of the shadow, now=

>> in secondary mode, continues in xnshadow_relax() after [3]. Am I right=
?
>=20
> Yes, Actually, another interesting point here is rthal_reenter_root().
> It's about properly (re-)adjusting a priority of the linux thread if th=
e
> shadow counterpart has changed its priority while running in the primar=
y
> domain. The linux thread is executing with its old priority between L54=
3
> and L551. So it's a small priority-related flaw regarding the migration=

> scheme. The reason is that it's not possible (likely it's possible with=

> linux versions >=3D 2.6.13) to properly change the priority of the linu=
x task
> on top of VIRQs (ISR handlers). Once we have discussed it with Philippe=
 and
> there can be another solution though. But we decided to wait a bit unti=
l
> all the dust with scheduler-related changes in 2.6.x settles down.
>=20
> Hopefully, I haven't misled you too much with my comments :o)
>=20

No, I actually got it :). I'm preparing a presentation about Xenomai,
and now I can even boast a bit more with details. ;)

Jan



--------------enig0A1F501F7C350D31AFA4E576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDevz6ncNeS9Q0k+IRApQJAJ96ILfBrbxbNBkjeUqo0Hmag+iZoQCfaB2G
AnY6FNJGXs2RTsQqT43YVHU=
=KmbP
-----END PGP SIGNATURE-----

--------------enig0A1F501F7C350D31AFA4E576--

