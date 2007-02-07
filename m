Message-ID: <45CA5C43.4030403@domain.hid>
Date: Thu, 08 Feb 2007 00:09:55 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Linux lock-up with rtcanrecv
References: <45CA5AFD.9020805@domain.hid>
In-Reply-To: <45CA5AFD.9020805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig46F4B6BAC499AF5A84B48F69"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46F4B6BAC499AF5A84B48F69
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi all,
>=20
> fiddling with latest Xenomai trunk and 2.3.x on one of our robots (ther=
e
> is still a bug in trunk /wrt broken timeouts of rt_dev_read on
> xeno_16550A - different issue...), I ran into a weird behaviour of
> rtcanrecv:
>=20
> I have a continuous stream of a few thousand packets/s towards the
> robot. When I start up two "rtcanrecv rtcan0 -p1000" instances (or one =
+
> our own receiver application), the second one causes a Linux lock-up.
> Sometimes this happens during startup of the second rtcanrecv, but at
> latest on its termination. Other RT tasks are still running. I can
> resolve the lock-up by pulling the CAN cable, everyone is fine
> afterwards and can be cleaned up. I played with quite a few combination=
s
> of recent ipipe patches and Xenomai revisions (even back to #1084 in
> v2.3.x), no noticeable difference.
>=20

Forgot to mention one further observation: removing the usleep form
rtcanrecv's cleanup() works around the shutdown lock-up. I can't
interpret this yet. [BTW, Wolfgang, what is it good for?]

Jan


--------------enig46F4B6BAC499AF5A84B48F69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFylxDncNeS9Q0k+IRAum9AJ4q+JxUG4+mPqROOkGETtj8GTSwdwCdH72u
hQ3qGarFYntwUK3W9BX4fDE=
=5OD4
-----END PGP SIGNATURE-----

--------------enig46F4B6BAC499AF5A84B48F69--

