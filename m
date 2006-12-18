Message-ID: <4586A0E6.6060608@domain.hid>
Date: Mon, 18 Dec 2006 15:08:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F20619389B4FB03C793D54C"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F20619389B4FB03C793D54C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> With 2.3-rc3 I get a new problem preparing the kernel :
>=20
> "Can't open perl script "/home/user/xenomai-2.3-rc3/scripts/help_from_k=
config.pl": Datei oder Verzeichnis nicht gefunden "
>=20
> Any suggestions how I can get around this ?

Please copy that file from an SVN checkout for now.

We are lacking a distribution entry in the related Makefile.am. I'm
currently preparing makefile changes anyway and will check in a fix.

@all: please give the -rc3 tar.bz2 hell! New files can easily slip
through the developer fingers when it comes to distribution (I know this
very well /wrt RTnet...).

Jan


--------------enig2F20619389B4FB03C793D54C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhqDmniDOoMHTA+kRAtI5AJ9hEMg4fesulYceqgar+6OtqF45wACfVNCu
3RNM5MUnIPcWhJW06idSttE=
=2+9v
-----END PGP SIGNATURE-----

--------------enig2F20619389B4FB03C793D54C--

