Message-ID: <491FF78D.9000609@domain.hid>
Date: Sun, 16 Nov 2008 11:35:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1L1XPO-0006Xh-1s@domain.hid>
In-Reply-To: <E1L1XPO-0006Xh-1s@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D9AD1656EA459B3A0803AF8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r4392 -
	/trunk/include/asm-x86/arith_64.h
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D9AD1656EA459B3A0803AF8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Author: gch
> Date: Sun Nov 16 03:30:40 2008
> New Revision: 4392
>=20
> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D4392&view=3Drev
> Log:
> Implement nodiv_ullimd on x86_64
>=20
> Modified:
>     trunk/include/asm-x86/arith_64.h

Nice. This solves the user-triggerable kernel oops due to idiv overflows
in the original version (rt_task_sleep_until(1LL<<63);). I happened to
receive such a bug report on Friday and was about to consider
alternative solutions beyond limit checks.

But how accurate is this conversion? I mean how many bits can we lose
when doing xnarch_ns_to_tsc(xnarch_tsc_to_ns(x))?

Final question: Already prepared a 32-bit version? :)

Jan



--------------enig6D9AD1656EA459B3A0803AF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkf95EACgkQniDOoMHTA+nAeACfTYuifWynrLcIFngq5mVmqle+
NDoAni75/oZTjmkq4KP2rxrWChHP0k56
=b0Dg
-----END PGP SIGNATURE-----

--------------enig6D9AD1656EA459B3A0803AF8--

