Message-ID: <46F8A992.2070500@domain.hid>
Date: Tue, 25 Sep 2007 08:24:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F4805ED19@domain.hid>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4805ED19@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5F137AF0FC3F344D88F25964"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Fast Context Switch Extension for ARM Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F137AF0FC3F344D88F25964
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Richard Cochran wrote:
>> -----Original Message----- From: Gilles Chanteperdrix >=20
>> The feature was already dropped, it is deprecated in ARMv6.
>=20
> Doesn't ARMv6 have a new cache design based on physical addresses?
>=20
> I thought I saw this somewhere...

Just grabbed this:

"Version 6 now supports physically tagged caches, reducing software
overhead on context switches."

[http://www.simplemachines.it/doc/ARMv6_Architecture.pdf]

But does this mean this layout is optional or mandatory for ARMv6
integrators?

Jan


--------------enig5F137AF0FC3F344D88F25964
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG+KmTniDOoMHTA+kRAkxYAJ4ghoM1ueZPNwFNEgEHs62+Bb8zkgCZAaZ1
WEITU0byFOA93CWNfVwREFk=
=ZN86
-----END PGP SIGNATURE-----

--------------enig5F137AF0FC3F344D88F25964--

