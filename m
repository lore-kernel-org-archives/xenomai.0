Message-ID: <463EEE79.9090409@domain.hid>
Date: Mon, 07 May 2007 11:16:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200705041630.40004.ngustavson@domain.hid>
In-Reply-To: <200705041630.40004.ngustavson@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6423CFC0042373261851E90D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] killing a rt task and closing a rtdm fd
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
--------------enig6423CFC0042373261851E90D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

NZG wrote:
> I've got a user space app that starts a periodic real time task.
> The periodic task opens an rtdm file descriptor and starts writing to i=
t in a=20
> loop.
>=20
> At some point, due to user interaction,  the task needs to be killed an=
d the=20
> file descriptor closed.
>=20
> What's the easiest way to signal it to do so? Anyone have some example =
code=20
> they can point at?
>=20
> I looked through the native docs and the examples at
> http://www.captain.at/xenomai.php
> and
> http://svn.gna.org/svn/xenomai/trunk/examples/rtdm/driver-api/
>=20
> but they don't appear to address this.
>=20
> The captains example uses a global variable, but this doesn't actually =
seem to=20
> work.
>=20
> I suspect the task is operating on a copied set of variables, so some s=
ort of=20
> message passing is going to be involved, but I don't want to slow down =
the=20
> main task to wait for a message.
>=20

Check examples under src/utils/can, src/testsuite/switchtest, or
irqbench. [And please post help requests on xenomai-help :)]

Jan


--------------enig6423CFC0042373261851E90D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGPu56niDOoMHTA+kRAj43AJ9XE+YwnTaRkQ+l9ozmUhIc5LzDNgCfRZ1l
c5N5YUXuuxuUU3jFm9A8Ga0=
=7LW8
-----END PGP SIGNATURE-----

--------------enig6423CFC0042373261851E90D--

