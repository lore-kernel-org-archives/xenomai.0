Message-ID: <472E3758.3060304@domain.hid>
Date: Sun, 04 Nov 2007 22:19:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Ioj7Q-0004EI-JX@subversion.gna.org>
In-Reply-To: <E1Ioj7Q-0004EI-JX@subversion.gna.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7A4C1AFA71237DD4F64D2F6C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r3147 - __xn_access_ok changes
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
--------------enig7A4C1AFA71237DD4F64D2F6C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Let's discuss this without bothering users :)]

Philippe Gerum wrote:
> Author: rpm
> Date: Sun Nov  4 18:18:39 2007
> New Revision: 3147
>=20
> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D3147&view=3Drev
> Log:
> Make __xn_access_ok() return false for addresses lower than the natural=
 page size.
>=20
> Modified:
>     trunk/ChangeLog
>     trunk/include/asm-x86/syscall_32.h
>     trunk/include/asm-x86/syscall_64.h

Could it be that you meant "PAGE_SIZE" instead of "PAGE_OFFSET"? Because
the current version is "slightly" broken, tagging any address in user
land as invalid.

And if this test was meant to catch NULL page accesses early, is the
intention to cope with all those current i-pipe patches that do not yet
include the discussed domain switch on non-root faults? If yes, this
test would be a workaround for legacy code and should not become default
(pure overhead for later versions).

Last question: We need this for the other archs as well, don't we?

Jan


--------------enig7A4C1AFA71237DD4F64D2F6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHLjdYniDOoMHTA+kRAtl0AJ9byNYA4EeXcJgfgMVsAtdThYiGLQCaA8gV
T5BKgNs80r7wOCrg2fAG4Mw=
=Ybaw
-----END PGP SIGNATURE-----

--------------enig7A4C1AFA71237DD4F64D2F6C--

