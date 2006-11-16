Message-ID: <455C8B8A.80105@domain.hid>
Date: Thu, 16 Nov 2006 17:02:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
In-Reply-To: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA1AD1C09C47D440D87067459"
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1AD1C09C47D440D87067459
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> Hello everyone,
>=20
> I finally got my PCI CAN card today. It's an Advantech 1680 and
> provides, as
> far as I'm informed, a memory mapped SJA1000 controller.
> I=B4m trying to load the xeno_rtcan_mem module now, but I'm not sure wh=
at
> parameters I should pass. More specific: What value(s) should I give to=
 the
> 'mem' parameter? Is this an I/O address I found in /proc/pci under the =
1680
> device?

I'm not sure that this will work, but you can give it a try in any case.
Do you have a reference driver for that board? Or some manual describing
the mapping of the SJA1000 into the PCI address space?

AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So far we
only have a driver for the PEAK PCI adapter, but that one is going to be
generalised. So you could become a first-grade test candidate for
another piece of hardware supported by that driver. :)

Wolfgang, what the status?

Jan


--------------enigA1AD1C09C47D440D87067459
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXIuKniDOoMHTA+kRAmCgAJ4kmlbVcAW9xlArJt8MYRUHDp60QACfSDDU
5PsQlA7PDuo6QWIfsLDwPcs=
=hzig
-----END PGP SIGNATURE-----

--------------enigA1AD1C09C47D440D87067459--

