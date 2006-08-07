Message-ID: <44D75BF8.5080303@domain.hid>
Date: Mon, 07 Aug 2006 17:27:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
References: <1903864415@domain.hid>
In-Reply-To: <1903864415@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1660F16546DC9D42493E7308"
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
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1660F16546DC9D42493E7308
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steve Kreyer wrote:
> Ok problem fixed,
>=20
> the last email was a typo by me :)
> If I increase the period to 1000 ns I get a system crash, when its 1us =
the task work like expected.
                                                                     ^^^
I assume you mean 1 *ms* here, don't you?

> But what does explain the System crash if the period is around 1000 ns?=


Please use the term "crash" carefully. Preferred terms: crash =3D=3D kern=
el
oops, lock-up =3D=3D doesn't react on inputs anymore. ;)

1 us is still way too fast, even for the latest high-end GHz monster.
Your system entered an endless loop while trying to satisfy this request.=


Jan


--------------enig1660F16546DC9D42493E7308
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE11v4niDOoMHTA+kRAr+hAJ4zfKcO2y/QLe5cwzAwmPCnZcTGcwCeKqai
CdOavdvZlEr/8sz1Lqhzpeo=
=kRNi
-----END PGP SIGNATURE-----

--------------enig1660F16546DC9D42493E7308--

