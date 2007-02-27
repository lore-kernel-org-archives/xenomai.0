Message-ID: <45E46D5C.8040001@domain.hid>
Date: Tue, 27 Feb 2007 18:41:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN question
References: <bc4264770702270848t6a65ec84nb72f9df20a52ba8f@domain.hid>
In-Reply-To: <bc4264770702270848t6a65ec84nb72f9df20a52ba8f@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7098261A568AA3EC44D3D37B"
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7098261A568AA3EC44D3D37B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> In choosing listen_only or Loop_back. What am I actually selecting?
> The documentation only tells me that the parameter sets loop_back or
> listen_only mode. Not what the difference is between those modes.
> Again one of those general network programming features I presume.

Both modes affect the controller directly if it supports it. Listen-only
means that this CAN node will not acknowledge incoming frames even if
they are correct, it will just sit there and sniff passively.

Loopback means that the hardware emulates a fully working bus (i.e.
correctly terminated) with only one node that simply receives what it sen=
ds.

[Granted, documentation might be improvable here for CAN beginners.
Still, you need basic some CAN understanding to deal with real-life
issues anyway.]

>=20
> When working with the virtual device. Does it matter which mode is chos=
en?

Nope, none of them is emulated so far.

Jan


--------------enig7098261A568AA3EC44D3D37B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5G1cniDOoMHTA+kRAnChAJ0afDiHIPf65o7KOYlQg9uZWoMR4QCfS1OH
r6hBknL9CkNdNqBxfQVbk/A=
=qKTw
-----END PGP SIGNATURE-----

--------------enig7098261A568AA3EC44D3D37B--

