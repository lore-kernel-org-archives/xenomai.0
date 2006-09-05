Message-ID: <44FD5D64.2080204@domain.hid>
Date: Tue, 05 Sep 2006 13:20:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai port to MIPS
References: <20060905065021.9474.qmail@domain.hid>
	<44FD354C.10007@domain.hid>
In-Reply-To: <44FD354C.10007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C487D15D666F18F2874FA1B"
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
To: Miguel Angel Alvarez <ma.alvarez@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C487D15D666F18F2874FA1B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Miguel Angel Alvarez wrote:
> I am also very intrerested in this kind of porting guidance, because I
> have to evaluate the difficulties in porting Xenomai (and Adeos) into
> Coldfire v4 (m68k) architecture.

See this posting for the Adeos part:

https://mail.gna.org/public/adeos-main/2006-09/msg00001.html

Regarding the porting effort of Xenomai: I would recommend to browse
through existing architectures, e.g. Blackfin, in order to asses the
amount and complexity of services you have to deal with.

Jan


--------------enig0C487D15D666F18F2874FA1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/V1kniDOoMHTA+kRAlHPAJ4sopG1wYET3bbZ+Gi4XrsOyf1XgwCeJaJb
xah5A7gyWUOSsQ7dqSI2iD8=
=Yx4S
-----END PGP SIGNATURE-----

--------------enig0C487D15D666F18F2874FA1B--

