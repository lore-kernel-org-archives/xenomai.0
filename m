Message-ID: <43E1FFAC.3040409@domain.hid>
Date: Thu, 02 Feb 2006 13:48:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM timing problems
References: <200601301611.53089.lbocseg@domain.hid> <43DE5E05.1030302@domain.hid>
	<200602021046.00546.lbocseg@domain.hid>
In-Reply-To: <200602021046.00546.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E6575CA32F23786319B91C3"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E6575CA32F23786319B91C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 30 Janeiro 2006 16:42, Jan Kiszka escreveu:
>=20
>> The point is that rtdm_clock_read() relies on the nucleus timer being
>> started. Otherwise, it just returns plain wrong numbers.
>>
>> This makes me scream again for that damn timer being started
>> AUTOMATICALLY! I guess Philippe knows what I'm talking about... ;)
>> Meanwhile, we should state this in the docs. At least for 2.0.x, this
>> will remain true anyway.
>=20
> What can I do for now? What is the relation between the system time and=
 the=20
> timer?

Just start the timer before using rtdm_clock_read(). This is now also
stated in the docs.

Jan


--------------enig9E6575CA32F23786319B91C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4f+sniDOoMHTA+kRAndkAJ9N9fY/p+9wuAfuBfdT3EopMEiSbwCfXa3s
dscLQi/6pLXFXiTqEx4IAms=
=Jidk
-----END PGP SIGNATURE-----

--------------enig9E6575CA32F23786319B91C3--

