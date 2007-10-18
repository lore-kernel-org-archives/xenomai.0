Message-ID: <4717C642.6030002@domain.hid>
Date: Thu, 18 Oct 2007 22:46:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85B714EF530D9FE7E61E01CF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] xnsched_resched_p test in hisyscall
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85B714EF530D9FE7E61E01CF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

what's the point about

	if (xnsched_resched_p())
		xnpod_schedule();

at the beginning of do_hisyscall_event() [1]? Could you provide a
comment for the background of this hunk? Or can we even remove it?

Jan

[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.=
c?v=3DSVN-trunk#1870


--------------enig85B714EF530D9FE7E61E01CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHF8ZFniDOoMHTA+kRAqVfAJ4q6egJ2ehmxRLOaHvylPmx9aLnDACfafDP
Xw4OvEw/FaUtUIMBzbROjlA=
=PqLe
-----END PGP SIGNATURE-----

--------------enig85B714EF530D9FE7E61E01CF--

