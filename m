Message-ID: <4576E1F9.5030707@domain.hid>
Date: Wed, 06 Dec 2006 16:30:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <995989.36703.qm@domain.hid>
In-Reply-To: <995989.36703.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig804071FFA8A4FD791BE3B244"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: problem persists with rt_queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig804071FFA8A4FD791BE3B244
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Hi=20
> I had a problem of rt_queue overflow in xenomai 2.1.Then installed xeno=
mai 2.2.5 but previous poblem with rt_queue is still there.I repeat the p=
roblem that when there is no listener on the queue the sender the sender =
displays the error message=20
>=20
> rt_queue_send(queue_input) failed sent bytes: 0
> rt_queue_send(queue_input) failed sent bytes: 0
> rt_queue_send(queue_input) failed sent bytes: 0
> rt_queue_alloc(queue_inout, 8) failed
>=20
>=20
>  and then stops and if i try to start my program again following messag=
e=20
>=20
> start
> rt_queue_alloc(queue_inout, 8) failed
> Segmentation fault
>=20
> is displayed and program doesnot work at all.I would be very thankful f=
or the correcting me what wrong am i doing.the code for the sender is att=
ached.

=2E..and your code still runs fine (SVN trunk, but the required patch is
in 2.2.5 as well). Moreover, stopping and restarting also causes no probl=
em.

So, please check:

 - content of /proc/xenomai/version

If this actually gives "2.2.5":

 - run the test over SVN trunk (make sure you actually run trunk via
   /proc/xenomai/version, should give "2.3-rc2")

 - report your findings

Again, *precisely* your problem was understood, fixed, and applied to
both branches. It should really not show up the same way as before.

Jan


--------------enig804071FFA8A4FD791BE3B244
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFduH5niDOoMHTA+kRAveuAJ9cvidP6b1mi6V1dC+JE1NNcUUB2QCfW9bO
k3lOxAli2GsLa7LC8CUAWsI=
=wWDb
-----END PGP SIGNATURE-----

--------------enig804071FFA8A4FD791BE3B244--

