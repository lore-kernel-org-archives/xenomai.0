Message-ID: <45DD7D07.7090605@domain.hid>
Date: Thu, 22 Feb 2007 12:22:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>	
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>	
	<45DD5DC0.6040402@domain.hid>	
	<bc4264770702220214y697c57abv9d5170b64fad40eb@domain.hid>
	<bc4264770702220240m721de5daw5776883ad47dfa24@domain.hid>
In-Reply-To: <bc4264770702220240m721de5daw5776883ad47dfa24@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF0FC3AD0C0E5B6E7316C8CE"
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
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF0FC3AD0C0E5B6E7316C8CE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi,
>=20
> hope I'm not overloading the list. :)
>=20
> The second thing I notice is that the code in the /src/utils/can
> applications very low level. Admirable to be sure but for lesser
> programming fundi's such as myself higher
> level calls are more useful. What I was kind of hoping for was the typi=
cal
>=20
> can_init(fd)
> can_write(fd,can_mesg)
> can_read(...
> etc
>=20
> API calls.
>=20
> do they exist? If yes how can I incorporate them in my program?

Nope, RT-CAN is incorporating the latest shiny Socket-CAN model which
is, well, socket-based. It's not the n-th specific, incompatible CAN
character device implementation.

>=20
> Continuing my browsing......

Start here regarding the API:

http://www.xenomai.org/documentation/branches/v2.3.x/html/api/group__rtca=
n.html

Jan


--------------enigBF0FC3AD0C0E5B6E7316C8CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3X0HniDOoMHTA+kRAhZKAJ9FpT0Xn/iGX8xCPduoGx5T7Toy3wCcDorE
vIfaGgZoQ2hvNkiiKFfwnHo=
=ensj
-----END PGP SIGNATURE-----

--------------enigBF0FC3AD0C0E5B6E7316C8CE--

