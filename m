Message-ID: <4687F466.2020901@domain.hid>
Date: Sun, 01 Jul 2007 20:37:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98490978B90DFCC0637A2C70"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH-STACK] Missing bits for -rc1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98490978B90DFCC0637A2C70
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

I've just uploaded my rebased patch stack, including specifically the
last bits that should go in before -rc1, namely

- only-setsched-in-trampoline.patch: missing bits for rt-caps-groups
- clean-nktbase-init.patch: nitpicking, but more consistent
- fix-intr-locking-part-ii-v2.patch: basically my first version but
  addressing the NULL issue Dmitry pointed out and adding one - as I
  think - important barrier. Dmitry, please have another look if I
  messed something up or if I missed something from your proposal.
- refactor-timer-modes-v2.patch: the final(?) version
- rtdm-timer-v3.patch: rebased over timer-modes-v2

Compile-tested, at least booting under qemu/smp, another real box is
about to boot in a few seconds.

Jan


--------------enig98490978B90DFCC0637A2C70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGh/RoniDOoMHTA+kRAojpAJ4vkrk3cmO8al1Gls21NboC1ZeDRwCfQazQ
5U8FOK/+Russq5539O6cdhk=
=J8ux
-----END PGP SIGNATURE-----

--------------enig98490978B90DFCC0637A2C70--

