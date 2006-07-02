Message-ID: <44A7CA35.5060009@domain.hid>
Date: Sun, 02 Jul 2006 15:29:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.6.17 hang on "will halt now" (possibly SMI
	related)
References: <200606301654.45844.lbocseg@domain.hid>
In-Reply-To: <200606301654.45844.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig48B5855AA87E7D2B8B35560C"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48B5855AA87E7D2B8B35560C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> I began to experience a problem since 2.6.17 when shutting down my PC.
>=20
> I noticed the problem just after I recompiled my kernel to enable the S=
MI=20
> workaround. I, then rebooted the new kernel and when I tried to shutdow=
n  the=20
> system, it stopped on "will halt now" message or something like.
>=20
> The same behavior is occurring both in home (Pentium-3 550 MHz) and  at=
=20
> college (P4-1.7GHz). In both systems, Xenomai advised me to enable SMI =

> workaround. Actually, at home, the worst latency with the latency test =
was=20
> about 20us independently from enabling or not the SMI workaround.
>=20
> Do someone else experienced a similar problem when upgrading to 2.6.17?=


Yep. Should be fixed now, see latest trunk.

It was a deadlock due to clumsy unregistration of the reboot notifier
from its own handler. I think the locking of the kernel changed in
2.6.17 (RCU) and made this fatal.

Jan


PS: 20us on a P-III 550 is a bit too good. I guess some serious load is
missing (cache load, IRQs, ...).


--------------enig48B5855AA87E7D2B8B35560C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEp8o4niDOoMHTA+kRAgLgAJ0UF+W2kl21biYjc0Eg5BDPdqW/EgCfQ1kO
ksQ8PSDRZkh41ThX9ycXLBg=
=1uHF
-----END PGP SIGNATURE-----

--------------enig48B5855AA87E7D2B8B35560C--

