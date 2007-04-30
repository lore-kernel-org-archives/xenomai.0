Message-ID: <463606CF.1060001@domain.hid>
Date: Mon, 30 Apr 2007 17:10:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4635D2A8.7050208@domain.hid> <4635B14C.2040001@domain.hid>
	<1177688176.5010.135.camel@domain.hid>
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
	<10772026.1177937498308.JavaMail.ngmail@domain.hid>
In-Reply-To: <10772026.1177937498308.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F09CB863C977E91F61C1A83"
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
--------------enig6F09CB863C977E91F61C1A83
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I have done three experiments:
> 1. Using my kernel without any additional test-patches
> 2. Activating the trace stuff in the .config file
> 3. Applying your patches from today
>=20
> I hope this helps...
>=20

Heisenbug, as I feared. Something gets utterly corrupted, depending on
the code layout. :-/

Let's wait for Philippe's x86_64 back-port to save resources we may need
later on...

Jan


--------------enig6F09CB863C977E91F61C1A83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNgbPniDOoMHTA+kRAhWYAJ9/tgx6vXsiNsCzd8c3P7xJU6awQgCeIZ8Y
Zlh20Y1etVSQRyWrwfiJ5q0=
=s0K9
-----END PGP SIGNATURE-----

--------------enig6F09CB863C977E91F61C1A83--

