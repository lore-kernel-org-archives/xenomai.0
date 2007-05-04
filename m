Message-ID: <463B543B.8060008@domain.hid>
Date: Fri, 04 May 2007 17:41:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200705041027.52872.ngustavson@domain.hid>
In-Reply-To: <200705041027.52872.ngustavson@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1DAAE1A11AAD42B943D070A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM problems with structures in headers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: NZG <ngustavson@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1DAAE1A11AAD42B943D070A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

NZG wrote:
> Background
> -------------------------
> I'm developing an rtdm for some simple io inside a PLD.
> This io is detected by a standard linux driver and used to register kob=
ject=20
> classes in the main driver.
> This in turn results in the registration of a named rtdm driver with th=
e same=20
> name as the class, which calls down into the classes standard low level=
=20
> methods using and RTDM atomic lock around the actual memory mapped=20
> manipulation.
> In this way I hope to create a standard, kernel detected,  interface to=
=20
> standard user space and rtdm for simple io devices.
>=20
> The RTDM device has no "private data" pointer for pointing to outside d=
ata=20
> structures. I would like to avoid modifying it's basic structure to mai=
ntain=20
> compatibility with future releases, and in general to avoid modifying t=
he=20
> real time core whenever possible.
>=20
> To get around I have an rtdm device inside the standard class structure=
, and=20
> then use the 2.6 "container of" macro from the rtdm driver to get acces=
s to=20
> the original class. =20
>=20
> Problems=20
> -------------------------
> Placing the rtd device inside the standard structure results in the nee=
d to=20
> add extra flags (-Iinclude/xenomai) to every Makefile which contains a =
device=20
> including the header file reference to xenomai in it.
>=20
> Question
> ------------------------
> Essentially, what is the recommended way to:
>=20
> Pass pointers to a rtdm driver from regular kernel space, which can be =

> maintained into the rtdm fops (without resorting to global variables).
>=20
> Allowing for the assumption that the standard kernel process holding th=
e data=20
> is responsible for registering the real time driver.

Not claiming that I fully understood your problem yet - code talks:

What about putting the rtdm_device and your standard device structure
into a "meta" structure. The type of the latter then only has be known
to those parts that access data "across" the two structure.

Jan


--------------enigD1DAAE1A11AAD42B943D070A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGO1Q7niDOoMHTA+kRAvUjAJ0SSdA5OgCXOkHmtoI+pORYp2ueXQCfdGL/
IPI13v8ascPvaSUnjrjMOW4=
=evqq
-----END PGP SIGNATURE-----

--------------enigD1DAAE1A11AAD42B943D070A--

