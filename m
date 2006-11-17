Message-ID: <455DD777.2030505@domain.hid>
Date: Fri, 17 Nov 2006 16:38:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Re: What happens if task entry function
	returns?
References: <455DCE75.1080300@domain.hid>
	<455DC001.2040001@domain.hid>	<434646.1163765689576.JavaMail.ngmail@domain.hid>
	<16178634.1163773048304.JavaMail.ngmail@domain.hid>
	<8592118.1163777339046.JavaMail.ngmail@domain.hid>
In-Reply-To: <8592118.1163777339046.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0252CA57437BD00A1F478BB8"
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
--------------enig0252CA57437BD00A1F478BB8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan!
>=20
> I have modified my test to use a sleep(1) at the end of the task functi=
ons.
> I have enclosed the strace logs to this mail.
> The file strace.tls is the one that uses the /lib/tls/... libraries.
> The file strace is the one that uses the /lib/... libraries.

Ok. And now a trace of the all-cpu-0 scenario would be good, as it is
broken but should still dump some information.

Jan


--------------enig0252CA57437BD00A1F478BB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXdd3niDOoMHTA+kRAvBXAJkBDZmvx1DvmASknpHLfYixuZCGPwCfYTLO
DE1eKy5e6+Ru+SLmunYqPLg=
=hJ7b
-----END PGP SIGNATURE-----

--------------enig0252CA57437BD00A1F478BB8--

