Message-ID: <466FF2EA.1000903@domain.hid>
Date: Wed, 13 Jun 2007 15:36:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <op.ttjtqjpgt06gyn@domain.hid>
In-Reply-To: <op.ttjtqjpgt06gyn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB5C950216E7BE990B814F32F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and Busybox
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5C950216E7BE990B814F32F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Axel Beierlein wrote:
> Hello,
>=20
> which minimal requirements are needed when i want to use Xenomai with  =

> Busybox?
>=20
> In my present configuration i have Xenomai 2.3.1 and Busybox 0.60.5 =20
> workin. But when I try to call xeno-info or xeno-config i get informati=
ons =20
> like this:
>=20
>   --If some fields are empty or look unusual you may have an old versio=
n.
>     Compare to the current minimal requirements in Documentation/Change=
s.
>=20
> or i get a message like that:
>=20
> unset: not found
>=20

xeno-test claims:

"BusyBox >=3D 1.1.3 with a make defconfig should provide all needed apple=
ts."

At the same time it includes checkUtilities(), a function to test for
all required tools and report what is missing. Could you dig deeper why
you don't get this?

Jan


--------------enigB5C950216E7BE990B814F32F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGb/LrniDOoMHTA+kRArFYAJ9qY1PdzzSTb8S8VHBFUJl0dwOguACdFsgY
xBnofN4HUGMzzDouCWiOoUw=
=DHFY
-----END PGP SIGNATURE-----

--------------enigB5C950216E7BE990B814F32F--

