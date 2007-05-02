Message-ID: <463896E1.1010404@domain.hid>
Date: Wed, 02 May 2007 15:49:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1178109768.5111.102.camel@domain.hid> <46384E4B.2050200@domain.hid>
	<1177947596.32698.47.camel@domain.hid>	
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid>	 <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>	
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid>	 <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>	
	<1177706363.5010.158.camel@domain.hid>	
	<33288775.1178089500362.JavaMail.ngmail@domain.hid>	
	<33481027.1178097243064.JavaMail.ngmail@domain.hid>
	<5375222.1178113469458.JavaMail.ngmail@domain.hid>
In-Reply-To: <5375222.1178113469458.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA36C266D258153DE2CA57DDC"
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
--------------enigA36C266D258153DE2CA57DDC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Philippe,
>=20
> I enabled the two kernel configuration parameters.
> However, this changes the error behaviour.
> Now, the e1000 driver will  be loaded, however it will not work...
> A unload and reload of the e1000 driver leads now to a kernel oops. How=
ever this looks
> completely different than the original one I am chasing...
> =20
> I will try to instrument the e1000 driver to ensure that it tries to re=
trieve the correct interrupt...

Let's don't change the test setup permanently unless it results in a
"better" oops. We need ONE base where we try to narrow the issue down,
not n of them.

OK, then please post the new oops, maybe it is in fact more comprehensibl=
e.

Jan


--------------enigA36C266D258153DE2CA57DDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOJbhniDOoMHTA+kRAhCRAJ0Z73u3si58wJl87NrDVXaFZ6na+wCfYe1M
ql1J8a954wxRqmhLw1W0zls=
=eQ8U
-----END PGP SIGNATURE-----

--------------enigA36C266D258153DE2CA57DDC--

