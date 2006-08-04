Message-ID: <44D35F15.6060600@domain.hid>
Date: Fri, 04 Aug 2006 16:52:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai & Elinos
References: <1299EF3181B10F479D85C3280132852422DAE1@domain.hid>
In-Reply-To: <1299EF3181B10F479D85C3280132852422DAE1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD32D1B4FE9EC22B588D649CB"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD32D1B4FE9EC22B588D649CB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

GUARDIOLA-FALCO Sebastien 204282 wrote:
> Hello,
>=20
> I believe some people wanted to know which version of Xenomai is curren=
tly supported by ElinOS (Sysgo).
> This is the 2.0.4, patched to a 2.6.15 kernel, but I'm only talking abo=
ut PowerPC archs (don't know others).

Thanks for the info. Yeah, I meanwhile read this as well in some
publicly available data sheet. Just the precise patch level remained
unclear.

What did they patched, only I-pipe? What I-pipe version is the patch
based on?

> What can I expect of this Xenomai version? what has been mostly improve=
d since then?

See the ChangeLog of a recent Xenomai version... :)

A lot of stuff has improved since then, e.g. the performance
enhancements due to pipeline head optimisation or the shared IRQ
support. And I bet that a few recent bug fixes are missing in the 2.0
series as well (one may correct me, it's a subjective impression). The
same may be true for the I-pipe patch.

It would be really a pity if they have patches of common interest for
Xenomai/I-pipe, even if only for 2.0.x, and did not posted them yet...

Jan


--------------enigD32D1B4FE9EC22B588D649CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE018VniDOoMHTA+kRAqnLAJwKNjCEnv6dVLD8YvpTHyJysMeZ7gCfRc6s
p1mYqvLlA00xcxmso0FfNf4=
=pmkP
-----END PGP SIGNATURE-----

--------------enigD32D1B4FE9EC22B588D649CB--

