Message-ID: <452F5D95.6090402@domain.hid>
Date: Fri, 13 Oct 2006 11:34:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] SPI and I2C
References: <452F54A1.7060401@domain.hid>
In-Reply-To: <452F54A1.7060401@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig702D463FF69A47A3DBFD291D"
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
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig702D463FF69A47A3DBFD291D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> Hello,
>=20
> has anybody already thought about RTDM drivers for SPI and I2C? Is ther=
e
> any development for a generic solution in progress?

I haven't heard of any activity or thoughts yet (at least I do not
recall them right now).

While reading some related SPI patch on LKML, I once thought about this
issue for a (short) while. I didn't grabbed immediately how the
execution model of the vanilla SPI framework precisely looks like, but
it seemed to involve quite some queueing and IRQ handling. And this
smelled like reusing code or even just the design may not be
straightforward.

Did you already have a look at the related Linux frameworks? I think the
first step should be to collect requirements of a generic
real-time-capable SPI and I2C infrastructure and compare them with the
existing stack designs. Maybe one can at least reuse the API to make
driver migration as smooth as possible.

Jan


--------------enig702D463FF69A47A3DBFD291D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFL12VniDOoMHTA+kRAiCOAJoDHgBdqgbnAN1RLGe4pA5p4WK4OgCfWbr9
iRbmummdt72jm4K1PwmD0qg=
=We5E
-----END PGP SIGNATURE-----

--------------enig702D463FF69A47A3DBFD291D--

