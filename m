Message-ID: <46B1AC78.30109@domain.hid>
Date: Thu, 02 Aug 2007 12:05:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2862c2c80708020225h5acc39axcdf126dd8200259b@domain.hid>
In-Reply-To: <2862c2c80708020225h5acc39axcdf126dd8200259b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC425860221BDEA908C84C6B3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Linux Driver to Real Time Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC425860221BDEA908C84C6B3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yeoh Chun Yeow wrote:
> Dear all,
>=20
> Is there any source of references for migrating the Linux Driver to Rea=
l
> Time Driver?
>=20
> Any hints and tips?

There is no magic instruction list available for this step. Basically,
you can consider this process looking like this:

 1. Analyse the design of the existing Linux driver. Is it RT friendly?
    Means: Are low-latency input/output paths feasible? Can I control
    the priority of requests or are there sources of potential priority
    inversions with other users of the system or the device? Do I have
    to handle concurrent device usages, and how will those users
    influence each other?

 2. Convert to RTDM API. If the design didn't change a lot, this can be
    a fairly mechanical step. General understanding of both the original
    Linux services (=3D> see e.g. "Linux Device Drivers") and RTDM ones
    (API docs) is required.

 3. Test and evaluate the driver properties. Ideally, post it for
    Xenomai inclusion (in that case, posting design considerations and
    partial ports much earlier can be very helpful for you!).

Step 1 is the main reason why there is no simple "How to port a Linux
driver to RTDM?". It can be quite different from driver to driver.
Still, patterns exist, and you may have a look at existing drivers in
Xenomai (including the examples repos) and external projects (see links
on xenomai.org).

Jan


--------------enigC425860221BDEA908C84C6B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGsax5niDOoMHTA+kRAluwAJ9ezrEw+QHC1TDfpqHp3AzIQ9A/qwCeKmhs
DdeXxE5JLgHoYu94rhvTPgo=
=aj2M
-----END PGP SIGNATURE-----

--------------enigC425860221BDEA908C84C6B3--

