Message-ID: <4656E62F.3090603@domain.hid>
Date: Fri, 25 May 2007 15:35:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDED0BD5F2ECD35E31DCD0F03"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] recursive fault on cyclictest termination --
	scalable sched?
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
--------------enigDED0BD5F2ECD35E31DCD0F03
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

People, we have some new troubles:

I'm reproducibly getting recursive faults on termination of cyclictest
via ^C. It's all standard here: ipipe 1.8-02, Xenomai trunk #2469, no
weird patches of mine.

Something goes utterly wrong, the debugger currently points into
xnshadow_relax->rpi_push, and there into some queuing operation. Note
that I have XENO_OPT_SCALABLE_SCHED on in my config, also
XENO_OPT_PRIOCPL. Without XENO_OPT_SCALABLE_SCHED, things seems to work
find. Who did last work on this? What was fixed?

Jan


PS: Found a few more bugs in my latest instrumentation patches. Grmbl.
Fixes will follow.


--------------enigDED0BD5F2ECD35E31DCD0F03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVuYvniDOoMHTA+kRAnC7AJ4o3ZWma0dxnAxva058rO5UWqPgjwCeOZG3
mvQDeaJtbbB/gOrOn7jcElc=
=tp4H
-----END PGP SIGNATURE-----

--------------enigDED0BD5F2ECD35E31DCD0F03--

