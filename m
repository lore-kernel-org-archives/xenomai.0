Message-ID: <4AF91F4C.7030003@domain.hid>
Date: Tue, 10 Nov 2009 09:07:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200911101311.12900.anisha.kaul@domain.hid>
In-Reply-To: <200911101311.12900.anisha.kaul@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDA1183FC0F9274AD4BC293D6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] tasklet using Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anisha Kaul <anisha.kaul@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA1183FC0F9274AD4BC293D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anisha Kaul wrote:
> Dear all,
>=20
> How to define a tasklet using Xenomai for a serial port interrupt handl=
er?=20
> Does 'rtdm_event_init()' function work as a tasklet in Xenomai ?

An RTDM event is a binary semaphore for use inside a kernel driver -
probably not what you are looking for. What should be the semantic of
this tasklet, that of old RTAI? And what is the use case behind it?

Jan


--------------enigDA1183FC0F9274AD4BC293D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr5H1MACgkQitSsb3rl5xQYxACg75xXy4CfLIbHKnuTJb5Ducme
3W8AoNmUwLU42E+mq8N766DJSCc9J/UA
=MD4Y
-----END PGP SIGNATURE-----

--------------enigDA1183FC0F9274AD4BC293D6--

