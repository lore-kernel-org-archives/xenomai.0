Message-ID: <4587E404.2050101@domain.hid>
Date: Tue, 19 Dec 2006 14:07:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: Aw: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native
	leads...
References: <4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
In-Reply-To: <4383100.1166529856857.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5EB55A209EE2482E25794538"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5EB55A209EE2482E25794538
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I tried to enable the kernel hacking parameters you proposed.
> However, now I get a "NMI early shots: 0" message many times per second=
=2E
> These seems to slow down everything dramatically, it is hard to work wi=
th the
> system. What are the early shots messages and how can I avoid them?

My feeling is that the issue you saw with gcc-4.1.2 is still unsolved,
just the recompilation made some stuff move around. Now, with additional
features activated, the issue seems to pop up again in a different way.

So again my suggestion: forget about the NMI for a while, check if we
can make progress with other debugging switches.

Further question to tighten the test case: do the basic Xenomai
testsuite programs run without noticeable problems on your box?

Jan


--------------enig5EB55A209EE2482E25794538
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFh+QEniDOoMHTA+kRAnlSAJ0U+8UhA0vkoRm+RokGrf4ITw0ttgCbB0Eb
Sb4d18rVDkn8eRtU8cGT/tM=
=zx/4
-----END PGP SIGNATURE-----

--------------enig5EB55A209EE2482E25794538--

