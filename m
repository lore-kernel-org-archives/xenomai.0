Message-ID: <469F1138.3050705@domain.hid>
Date: Thu, 19 Jul 2007 09:22:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB540FD987E171A99B8F6151E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix regression around one-shot host tick
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB540FD987E171A99B8F6151E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe,

this bug was introduced with recent clock_event modifications:

--- ksrc/nucleus/timer.c	(Revision 2766)
+++ ksrc/nucleus/timer.c	(Arbeitskopie)
@@ -245,7 +245,7 @@ void xntimer_tick_aperiodic(void)
 			   translates into precious microsecs on low-end hw. */
 			__setbits(sched->status, XNHTICK);
 			if (!testbits(timer->status, XNTIMER_PERIODIC))
-				goto out;
+				continue;
 		}
=20
 		do {
@@ -254,7 +254,6 @@ void xntimer_tick_aperiodic(void)
 		xntimer_enqueue_aperiodic(timer);
 	}
=20
-out:
 	__clrbits(sched->status, XNINTCK);
=20
 	xntimer_next_local_shot(sched);


It doesn't look like typo, so what was your original intention? The curre=
nt code at least fails to handle outstanding timers that are enqueued rig=
ht behind a one-shot host-tick timer.

Jan


--------------enigB540FD987E171A99B8F6151E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGnxE5niDOoMHTA+kRAid9AJsF8RhWLMbo+0CyUevSLi/YhaEaIgCeN1Yi
u3Lg1Ki1Y94Jr3kGMMBzYT0=
=LDF0
-----END PGP SIGNATURE-----

--------------enigB540FD987E171A99B8F6151E--

