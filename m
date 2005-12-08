Message-ID: <43982E88.8080902@domain.hid>
Date: Thu, 08 Dec 2005 14:00:56 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Commercial use of Xenomai
References: <B4D14EA407C38B4DAF92B8EAC9249D7F01788ACA@mspex01.go.mts.com>
In-Reply-To: <B4D14EA407C38B4DAF92B8EAC9249D7F01788ACA@mspex01.go.mts.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51FC3453551E828D778814A7"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51FC3453551E828D778814A7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rosenow, Jim wrote:
> First let me start by saying I apologize if xenomai-help is the wrong
> list, I found a xenomai-main which I though more likely the correct lis=
t
> but it has had no activity.

It's perfectly ok to ask here.

>=20
> I had been following fusion for some time with an eye toward the
> possibility of commercial use due to it being user-space real-time and
> thus more likely to allow protection of intellectual property.  I'm
> pleased to see a continuation of fusion in the Xenomai project.
>=20
> I've searched the archives for license details and have only found
> reference to GPL V2.
>=20
> My primary question is if a user space Xenomai real-time application is=

> considered a derivate work and thus is subject to be GPL'd?
>=20

Take a closer look at the license headers of the userspace library
source code: it's LGPL, thus you may link closed-source against it.

Actually, this option is one of our motivations to move from RTAI kernel
space(*) to Xenomai userspace with our real-time robotic applications.
Also universities like to sell some of their software from time to time. =
:)

Jan


(*) Yes, I know that there is LXRT, but this had some stability and
design issues since recently.


--------------enig51FC3453551E828D778814A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmC6JncNeS9Q0k+IRAsXSAJ9FmjcTJRwWiSCGMzNiHvkV/3452gCcCFn3
OHc6rCfK3KpE6yU3Lu3YGkM=
=Z/Ky
-----END PGP SIGNATURE-----

--------------enig51FC3453551E828D778814A7--

