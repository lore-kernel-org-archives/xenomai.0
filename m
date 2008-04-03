Message-ID: <47F551AD.9030509@domain.hid>
Date: Thu, 03 Apr 2008 23:52:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
	<47F4D87F.7080204@domain.hid>
In-Reply-To: <47F4D87F.7080204@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig01ABBA9A450F4228649543A9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01ABBA9A450F4228649543A9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> This patch may do the trick: it uses the inverted tsc-to-ns function=20
>> instead of the frequency-based one. Be warned, it is totally untested =

>> inside Xenomai, I just ran it in a user space test program. But it may=
=20
>> give an idea.
>=20
> Your patch needed two minor corrections (ns instead of ts in functions =

> xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of=20
> latency -t1 seems to prove your bug-fix: There seems to be no drift.

That's good to hear.

> If I got your patch correctly, it doesn't make xnarch_tsc_to_ns more=20
> precise but introduces a new function xnarch_ns_to_tsc() which is also =

> less precise than the generic xnarch_ns_to_tsc(), right?

Yes. It is now precisely the inverse imprecision, so to say. :)

> So isn't there=20
> still the danger of getting wrong values when calling xnarch_tsc_to_ns(=
)=20
>  not in combination with xnarch_ns_to_tsc()?

Only if the user decides to implement his own conversion. Xenomai with=20
all its skins and both in kernel and user space should always run=20
through the xnarch_* path.

Jan


--------------enig01ABBA9A450F4228649543A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkf1Ua4ACgkQniDOoMHTA+kV7ACeKtZ9NKdOrCohIi4J3FDl5mn9
KpMAnA6qAXgB7U71bP/NAuoJ0Ylyuik/
=FIMp
-----END PGP SIGNATURE-----

--------------enig01ABBA9A450F4228649543A9--

