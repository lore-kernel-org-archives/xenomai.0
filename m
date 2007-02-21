Message-ID: <45DC51F8.7090508@domain.hid>
Date: Wed, 21 Feb 2007 15:06:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] real-time ethernet
References: <45DC4C85.8090807@domain.hid>
In-Reply-To: <45DC4C85.8090807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig551A038D497875CD08FED70F"
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig551A038D497875CD08FED70F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
> Again a bit of advice required. I have the choice of interacting with a=

> remoteIO station via ethernet or CAN as well. I need CAN anyway for the=

> sensor but I suspect that communicating with the remote IO station via
> ethernet might be substantially easier programming than doing this with=

> CANOpen.
>=20
> Can anyone confirm this? Does anyone with experience in both prefer one=

> or the other?
>=20
> And what can be said about this and xenomai? Would I use the standard
> sys/socket library or is there a real-time xenomai implementation of th=
e
> same functionality?

Check

http://www.rtnet.org
http://www.xenomai.org/index.php/RTnet:Main.

If it is simple to set up? Well, I'm probably the wrong person to ask...

Jan


--------------enig551A038D497875CD08FED70F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3FH4niDOoMHTA+kRAo33AJ9nty+iQ62V1fbEgeCeQQ1IdTHBHACfbBPV
6suVnAu7jz/PXL517jaoyUs=
=zTwd
-----END PGP SIGNATURE-----

--------------enig551A038D497875CD08FED70F--

