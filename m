Message-ID: <451C48CF.4010108@domain.hid>
Date: Fri, 29 Sep 2006 00:12:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fix for kgbd patch
References: <4510E84C.90807@domain.hid>
In-Reply-To: <4510E84C.90807@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF24CC27D4A966B99D3B9AA22"
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
To: xenomai-core <xenomai@xenomai.org>, adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF24CC27D4A966B99D3B9AA22
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> the kgdb-over-ipipe add-on patches available from gna.org contain two
> bugs that prevents stepping through Xenomai kernel threads. The attache=
d
> update fixes them. It also contains the workaround to build kgdb with
> gcc-3.4 (before 3.4.4) and 4.1 (before 4.1.2).
>=20
> Tested on 2.6.17.13 with latest kgdb from CVS.
>=20

It turned out (*) that kgdb over I-pipe only works reliably for
!CONFIG_PREEMPT (e.g. due to rcu_read_lock in the int3 notifier path).
Until some solution has been worked out, switch preemption off when you
use the debugger.

Jan


(*) Ever tried to debug a debugger? Here is one way to do this without
special hardware: Xenomai in qemu, one ddd attached to kgdb over
emulated serial port on /dev/pts/X, another ddd attached to qemu as
debugger back-end ("-s"). Sounds like fun? It isn't.


--------------enigF24CC27D4A966B99D3B9AA22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFHEjPniDOoMHTA+kRApF/AJkBYzR4+UvOkszjiIDHTf2whI1gAACfYJBq
fDh4buHZPRdb8ESnreValmI=
=bz4o
-----END PGP SIGNATURE-----

--------------enigF24CC27D4A966B99D3B9AA22--

