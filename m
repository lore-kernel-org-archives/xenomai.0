Message-ID: <4656F400.1030803@domain.hid>
Date: Fri, 25 May 2007 16:34:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4656E62F.3090603@domain.hid>
	<4656E887.7040406@domain.hid>	<4656EABD.60601@domain.hid>
	<1180102373.20410.103.camel@domain.hid> <4656F037.4040704@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F547BA@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01F547BA@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7DF01BC1D72760C558B2557"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest termination
 --	scalable sched?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7DF01BC1D72760C558B2557
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Well, that may be related to the bug I am seeing when I am ending cycli=
ctest with Ctrl-C, Recursive kernel Ooops and this is on plain 2.3.1

My tests all ran over trunk, but you may easily verify the relation by
enabling XENO_OPT_DEBUG_QUEUES.

Jan


--------------enigF7DF01BC1D72760C558B2557
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVvQAniDOoMHTA+kRAsuFAJ9pBSc7VmFUrtQJHTikhtLe1NmluwCfbJ2s
bdnwTCXC1585Hu0+ScHYdi4=
=Y1MD
-----END PGP SIGNATURE-----

--------------enigF7DF01BC1D72760C558B2557--

