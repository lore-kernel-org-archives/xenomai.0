Message-ID: <43DDFD03.5030104@domain.hid>
Date: Mon, 30 Jan 2006 12:48:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	<b647ffbd0601220010x3cc023an@domain.hid>	<fd6a47a90601220819n3f4cd382t@domain.hid>	<E1F16LA-0001ku-C4@domain.hid>	<b647ffbd0601240514m11a11a64u@domain.hid>	<43D62B07.3030703@domain.hid>
	<b647ffbd0601300337g2387b9f5w@domain.hid>
In-Reply-To: <b647ffbd0601300337g2387b9f5w@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3984015C083BAC2B6AE28C4A"
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
--------------enig3984015C083BAC2B6AE28C4A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>>> ...
>=20
>> I have not checked it yet but my presupposition that something as easy=
 as
>> :
>>> preempt_disable()
>>>
>>> wake_up_interruptible_sync();
>>> schedule();
>>>
>>> preempt_enable();
>> It's a no-go: "scheduling while atomic". One of my first attempts to
>> solve it.
>=20
>=20
> My fault. I meant the way preempt_schedule() and preempt_irq_schedule()=
 call
> schedule() while being non-preemptible.
> To this end, ACTIVE_PREEMPT is set up.
> The use of preempt_enable/disable() here is wrong.
>=20
>=20
> The only way to enter schedule() without being preemptible is via
>> ACTIVE_PREEMPT. But the effect of that flag should be well-known now.
>> Kind of Gordian knot. :(
>=20
>=20
> Maybe I have missed something so just for my curiosity : what does prev=
ent
> the use of PREEMPT_ACTIVE here?
> We don't have a "preempted while atomic" message here as it seems to be=
 a
> legal way to call schedule() with that flag being set up.

When PREEMPT_ACTIVE is set, task gets /preempted/ but not removed from
the run queue - independent of its current status.

>=20
>=20
>>> could work... err.. and don't blame me if no, it's some one else who =
has
>>> written that nonsense :o)
>>>
>>> --
>>> Best regards,
>>> Dmitry Adamushko
>>>
>> Jan
>>
>>
>>
>>
>=20
>=20
> --
> Best regards,
> Dmitry Adamushko
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core



--------------enig3984015C083BAC2B6AE28C4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3f0DniDOoMHTA+kRAng8AJwJe6zuwOsEIX9hm2stAgLHCc3fZwCggnoC
IhEo9j/XJogTufmjvs0oRQQ=
=dF/Q
-----END PGP SIGNATURE-----

--------------enig3984015C083BAC2B6AE28C4A--

