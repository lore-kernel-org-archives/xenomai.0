Message-ID: <4690B846.8060404@domain.hid>
Date: Sun, 08 Jul 2007 12:11:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <468ED509.8060105@domain.hid>
In-Reply-To: <468ED509.8060105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig495693605A7A637DA301E2FF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] reduce config complexity of intr.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig495693605A7A637DA301E2FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Here comes an attempt to clean up some of the mess that piled up in
> nucleus/intr.c over the time and specifically after our last hot-fixes.=


The first version contained a regression that oops'ed when dumping
/proc/xenomai/stat. Here is -v2 without that bug + a few more
micro-refactorings to kill #ifdefs:

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/xnintr-cleanups-v2=
=2Epatch

Jan


--------------enig495693605A7A637DA301E2FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkLhKniDOoMHTA+kRAqzAAJ91BKv3xx1J87WYR0/oClupZPYkuACdGUow
chHb7l6bMXJ4wASaCryI83A=
=meTu
-----END PGP SIGNATURE-----

--------------enig495693605A7A637DA301E2FF--

