Message-ID: <4635D2A8.7050208@domain.hid>
Date: Mon, 30 Apr 2007 13:27:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4635B14C.2040001@domain.hid> <1177688176.5010.135.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
	<4548126.1177688516220.JavaMail.ngmail@domain.hid>
	<32420186.1177927883942.JavaMail.ngmail@domain.hid>
In-Reply-To: <32420186.1177927883942.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7277E1E6FB8301F5C776693E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
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
--------------enig7277E1E6FB8301F5C776693E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> enclosed is the output of this experiment.
> I have removed all patches from last week before applying the new patch=
=2E
>=20

This BUG look now very different from your previous issue. Are you sure
you build is consistent? Maybe the not-yet-backported IPI bug over
x86_64 actually cause this heisenbug, don't know.

Well, if and only if you have nothing better to do ;), you could retry,
starting a test with a patch-free tree, then switching on the tracer and
testing again, and finally re-applying my last patch. But we may also
wait for Philippe to provide the IPI fix first.

Jan


--------------enig7277E1E6FB8301F5C776693E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNdKpniDOoMHTA+kRAns3AJ93ZtEawgfzUyUxHNokLD0amPf+MACeO7Kt
HM1PNsPIUKms/ke+6FkMCcY=
=TlCk
-----END PGP SIGNATURE-----

--------------enig7277E1E6FB8301F5C776693E--

