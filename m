Message-ID: <45CC68F3.1000003@domain.hid>
Date: Fri, 09 Feb 2007 13:28:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid>
In-Reply-To: <45CC651C.6060402@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A97B6F88168DCF969333BDD"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A97B6F88168DCF969333BDD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Hi,
> I just saw the following errormessages while running some tests with my=

> application.
>=20
> "Xenoami: fatal: removing non-linked element, holder=3Def9a5794
> qslot=3Df96f70d0 at include/xenoami/nucleus/queue.h:422"
> "Xenomai: Stuck on nucleus lock f96f6380"

I guess you had to hand-copy the message. There should be some back
trace following that is annoying to type. Maybe you can capture it with
a serial console (if your machine still has "legacy" interfaces). Or,
even better, you try to derive a demo code for triggering the bug.

>=20
> Followed by pressing the reset-button...
>=20
> I Run Xenomai 2.3 rev 2139 on AMD X2, kernel 2.6.17.14, debian sarge.
>=20
> May this be due to an misbehaviour in my app, or does it look like
> something xenomai related? I am not sure how to interpret these message=
s.

This is nothing your application should be allowed to cause.

Jan


--------------enig0A97B6F88168DCF969333BDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFzGjzniDOoMHTA+kRAvw1AJ9Xs3Wnq/f6/wF737sKssxx7skmWwCfcBF4
m8qCqruKG80JBn1SJgEqbI0=
=fV9p
-----END PGP SIGNATURE-----

--------------enig0A97B6F88168DCF969333BDD--

