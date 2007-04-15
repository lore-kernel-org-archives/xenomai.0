Message-ID: <462220E5.4070204@domain.hid>
Date: Sun, 15 Apr 2007 14:56:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46219B08.8060507@domain.hid>
In-Reply-To: <46219B08.8060507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA52130ACAC03E5BF24C7547D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM SPI Driver for Blackfin 537
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Terry Laurenzo <tlaurenzo@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA52130ACAC03E5BF24C7547D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Terry Laurenzo wrote:
> I know its not the best form to reference a blog on a mailing list, but=
=20
> I'm tired and don't want to repeat myself.  I have published informatio=
n=20
> on an RTDM SPI Driver that I have implemented for the Blackfin 537:=20
> http://www.rcode.net/blog/tlaurenzo/category/linux/
>=20
> I needed this for my own project but felt that it could be useful for a=
=20
> larger audience.  This was my first attempt at a "real" RTDM driver, so=
=20
> I by no means claim perfection!  Feedback or pointers are appreciated.
>=20
> This driver has been used extensively on the 06R2 uClinux release.  As =

> of today, I have just verified it with the 07R1 release candidate and=20
> the newly published Adeos patch for it.

Nice work, specifically as it already considers a separation between
hw-specific and generic part. I guess we just need one further SPI
application/hardware driver to get a kick-off for an RTDM profile (I
personally don't feel like I could judge on an SPI API design ATM).
Meanwhile I would suggest to link your work also via the wiki
(=3D>weblinks) so that others can find it that way.

>=20
> I also have a Blackfin port of the RT 16550 Serial driver in the works =

> (targeting Blackfin builtin UARTs instead of 16550) if anyone is intere=
sted.

Yes, that sounds fairly interesting as well. Given that we already have
a profile here and a fair amount of users, integrating some Blackfin
UART RTDM driver into Xenomai mainline wouldn't likely be a big deal.

Once finished, you are welcome to post it, review will be provided ASAP.
Please choose kernel coding style right from the beginning to accelerate
the review.

Thanks for contributing!
Jan


--------------enigA52130ACAC03E5BF24C7547D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIiDlniDOoMHTA+kRAg5oAKCFOTg5lPQasMxZmm37f/gFID1JRACfdbE/
KSZl4jhw+MDBd1AVTUR1IFI=
=kaRY
-----END PGP SIGNATURE-----

--------------enigA52130ACAC03E5BF24C7547D--

