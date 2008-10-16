Message-ID: <48F7BB23.9090600@domain.hid>
Date: Fri, 17 Oct 2008 00:07:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.318326730@domain.hid>
	<48F79C8E.3070900@domain.hid> <48F7B86D.8090204@domain.hid>
	<48F7B90D.3030107@domain.hid>
In-Reply-To: <48F7B90D.3030107@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3403D6091BD8FAF68B209024"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 06/12] Lockless fast
	path	for	xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3403D6091BD8FAF68B209024
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>
>>> Ok. Though I do not see the point of the FASTSEM/FASTSYNCH rename.
>>> FASTSEM is short, and we are not much interested in getting anything
>>> else than semaphores faster.
>> We aren't optimizing semaphores (at least not yet), we are optimizing
>> mutexes only. And if we ever optimize also semaphores, FASTSYNCH will
>> luckily still fit. :)
>=20
> The name was chosen because we plan to optimize semaphores as well, and=

> because mutexes are simply a special kind of semaphores, so, by saying
> FASTSEM, we cover semaphores as well as mutexes.

That depends on how you define both - most semaphore definitions do not
include the ownership concept, thus are not a superclass of
(owner-tracking) mutexes we consider here.

Jan


--------------enig3403D6091BD8FAF68B209024
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3uycACgkQniDOoMHTA+m6RACeJWfv1HBlxs5xslHpLMLwpwYC
EbwAn2LyYvhD3kks2EaMST2xau+Tub8r
=Plyl
-----END PGP SIGNATURE-----

--------------enig3403D6091BD8FAF68B209024--

