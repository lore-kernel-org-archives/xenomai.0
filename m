Message-ID: <45A67C77.3070006@domain.hid>
Date: Thu, 11 Jan 2007 19:05:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG?] registry usage + module removal causes
	kernel	oops (xenomai native)
References: <OF4D873F49.344BC96D-ONC1257260.005DC836-C1257260.00617F2A@retarus.de>
In-Reply-To: <OF4D873F49.344BC96D-ONC1257260.005DC836-C1257260.00617F2A@retarus.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB45D2A1B3161E9BFE1BBDC1A"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB45D2A1B3161E9BFE1BBDC1A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Wiedemann wrote:
> Hi again,
>=20
> I observed another wrong(?) behaviour of xenomai, caused by a wrong
> behaviour in our code :) The resources (tested with mutexes) are not
> deleted after the process which created them exits without cleaning up
> (for example, it crashes).
>=20
> For anonymous objects, i don't see a reason why this would be a
> defined behaviour, since there is no way to reuse those objects.
> Therefore, I consider this to be a bug, as it will finally eat up all=20
> memory.
> Or are there any technical reasons for this?

-ENOTIMPLEMENTEDYET

We have this desired auto-cleanup for the POSIX skin already, but we are
lacking it for the others. The native objects should be straightforward,
stalled RTDM handles still require a bit thoughts (and the solution of
another issue). Time will come.

For now we here help ourselves by keeping track of those resources in
userspace at framework level and release them - when required - inside a
SEGFAULT signal handler. Of course, covers not all faults.

>=20
> Another bug appeared for objects registered at the registry. When
> using xeno-native and xeno-rtdm, the order of removal seems to be
> important. I appended a small code sample to register a mutex at
> the registry. After the program exits, the modules can not be unloaded
> in the order
>   1) xeno-native
>   2) xeno-rtdm,
> but the other way around works fine. Instead, rmmod ends up with a
> segmentation fault, dmesg output appended.
>=20
> I tested this on xenomai 2.3.0/linux 2.6.19 and 2.2.5-svn/linux2.6.17.1=
4.
>=20

Looks like it's related to the left-over mutex in the registry. Probably
the other order just papers the issue. $Someone should give your code a
try, maybe I can check later with a debugger.

Jan


--------------enigB45D2A1B3161E9BFE1BBDC1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpnx3niDOoMHTA+kRAvxNAJ4ji8XgZ5PhVNkJWpJzQbXYA9M6LwCfWBE6
avvATYswbKoFaCTubf8pOao=
=WCdk
-----END PGP SIGNATURE-----

--------------enigB45D2A1B3161E9BFE1BBDC1A--

