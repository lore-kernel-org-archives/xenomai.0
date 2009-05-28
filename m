Message-ID: <4A1E550D.9090702@domain.hid>
Date: Thu, 28 May 2009 11:10:37 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4A00848D.1090500@domain.hid>
In-Reply-To: <4A00848D.1090500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9A7B514F0256C61F48A0D473"
Subject: Re: [Xenomai-help] Debian package building fails with 2.5-rc1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A7B514F0256C61F48A0D473
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

thx for commiting to xenomai-head.
Please merge to 2.4.x, you removed the Changelog file one week ago.

Thank you
Stefan

Stefan Kisdaroczi schrieb:
> Hi,
>=20
> there is no ChangeLog file in the project root anymore, so debian packa=
ge building fails.
> Following patch fixed it for me.
>=20
> kisda
>=20
> --- xenomai-2.5.orig/debian/rules
> +++ xenomai-2.5/debian/rules
> @@ -108,7 +108,7 @@
>  	dh_testdir -i
>  	dh_testroot -i
>  	dh_installdocs -i -A CREDITS README.INSTALL TROUBLESHOOTING
> -	dh_installchangelogs -i ChangeLog
> +	dh_installchangelogs -i
>  	dh_link -i
>  	dh_strip -i
>  	dh_compress -i -X.pdf
> @@ -131,7 +131,7 @@
>  	dh_testroot -s
>  	dh_installman -s
>  	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
> -	dh_installchangelogs -s ChangeLog
> +	dh_installchangelogs -s
>  	dh_link -s
>  	dh_strip -s
>  	dh_compress -s
>=20
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enig9A7B514F0256C61F48A0D473
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKHlUWIPTw9rIdn6oRApmFAJ0falvAQb6yRuce1kuSYAklftgiuQCePRTq
6CNtcFFo2sY7dqr7OAAyTi8=
=Eehx
-----END PGP SIGNATURE-----

--------------enig9A7B514F0256C61F48A0D473--

