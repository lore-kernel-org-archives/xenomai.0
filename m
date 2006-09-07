Message-ID: <45003E4E.9060302@domain.hid>
Date: Thu, 07 Sep 2006 17:44:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45003003.7070507@domain.hid>
In-Reply-To: <45003003.7070507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig784C38AA6201FDEE1E73FA43"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [RFC][PATCH] optimise wakeup order in
	xnsynch_flush
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig784C38AA6201FDEE1E73FA43
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> this is so far a mind experiment combined with an untested patch:
>=20
> [Assuming priority lists, the following is irrelevant for O(1) sched-qu=
eues]
>=20
> Consider we have some bulk of threads with varying priorities waiting o=
n
> a xnsynch object. Typically, they are queued in priority order, the
> highest prio thread at the head. When we wake them up all at once via
> xnsynch_flush, we iterate from high to low prio threads.
>=20
> Waking up includes inserting those threads in the ready queue(s), again=

> the highest prio thread first. On wake up of the first waiting thread w=
e
> will only have to skip those threads in the ready queue that have highe=
r
> priorities. For the second thread we already have to skip the first one=

> as well on insert if it isn't of the same priority. One may continue
> this workflow...

Forget about this, there was a sign mistake: ready-queue walk already
takes place in the reverse order (from lower to higher prios), thus with
minimal iterations for the sketched scenario. Time to go home...

Jan


--------------enig784C38AA6201FDEE1E73FA43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFAD5OniDOoMHTA+kRAiTMAJ9cp2lRlMAv5VeWZkYRBVPfD82WOgCeNW1z
eFNF8JMhciafpYaSQmhC0BQ=
=MUnK
-----END PGP SIGNATURE-----

--------------enig784C38AA6201FDEE1E73FA43--

