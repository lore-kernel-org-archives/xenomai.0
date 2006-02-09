Message-ID: <43EB1741.9080809@domain.hid>
Date: Thu, 09 Feb 2006 11:19:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>	<43E86F4D.4050400@domain.hid>	<43E8DFC4.4010805@domain.hid>	<43E9CE95.3070806@domain.hid>
	<43EAFD8B.7020400@domain.hid> <43EB1279.3040902@domain.hid>
In-Reply-To: <43EB1279.3040902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B60916083575364D29942BC"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B60916083575364D29942BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Anders Blomdell wrote:
>=20
>> My distinct feeling is that the return value should be a scalar and
>> not a set!
>>
>=20
> To sum up, the valid return values are HANDLED, HANDLED | ENABLE (*),
> HANDLED | CHAINED and CHAINED. It's currently a set because I once
> thought that the "handled" indication (or lack of) could be a valuable
> information to gather at nucleus level to detect unhandled RT
> interrupts. Fact is that we currently don't use this information,

But it is required for the edge-triggered case to detect when the IRQ
line was at least shortly released. I guess Dmitry introduced that NOINT
just because HANDLED equals 0 so far. As I would say HANDLED =3D=3D !NOIN=
T,
we could avoid this new flag by just making HANDLED non-zero.

> though. IOW, we could indeed define some enum and have a scalar there
> instead of a set; or we could just leave this as a set, but whine when
> detecting the invalid ENABLE | CHAINED combination.

In combination with the change above and some doc improvement ("valid
combinations are: ..."), I could also live with keeping the flags. The
advantage were that we wouldn't break existing applications.

>=20
> (*) because the handler does not necessary know how to ->end() the
> current IRQ at IC level, but Xenomai always does.
>=20

Jan


--------------enig8B60916083575364D29942BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6xdBniDOoMHTA+kRAtf6AJ9rBh1LDFeNydlYeW+q+DNhQSbg8gCghSPF
5QAiiUOoMeRpeWhOUXdo8rk=
=ZD46
-----END PGP SIGNATURE-----

--------------enig8B60916083575364D29942BC--

