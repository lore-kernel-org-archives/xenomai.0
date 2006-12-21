Message-ID: <458AC0A3.70700@domain.hid>
Date: Thu, 21 Dec 2006 18:13:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>	
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>	
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>	
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>	
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>	
	<458A4DE0.5030005@domain.hid>	
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>	
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>	
	<1166700491.4936.5.camel@domain.hid>	
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
In-Reply-To: <13574091.1166708188484.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB5F61872D447556A23FC95D0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai
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
--------------enigB5F61872D447556A23FC95D0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi all,
>=20
> some more interesing measurements:
> 1) Even when I remove the printf() completely, the system freezes.
> My realtimetask is then
> static void realtimetask(void *arg)
> {
>     system("ls -l");
>     rt_task_sleep(1000000000ULL);
>=20
> }
>=20
> 2) When I replace the printf() by a gepid() the behaviour is the same.

Hah, it finally oopses! Hurray!! Now the funny part begins...

Jan


--------------enigB5F61872D447556A23FC95D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFisCjniDOoMHTA+kRAqeqAJ9l3jeyhcc+mINT2Zv0fAt2N7Og3QCdF8Iz
FlDSo5XEmxPl+LBg/9aJ5v0=
=nNWb
-----END PGP SIGNATURE-----

--------------enigB5F61872D447556A23FC95D0--

