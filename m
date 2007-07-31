Message-ID: <46AF79F7.7080908@domain.hid>
Date: Tue, 31 Jul 2007 20:05:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9C6F497578951D2F5071123"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Revert broken edge_shirq optimisation
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
--------------enigF9C6F497578951D2F5071123
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Oh my dear. The ground may open and swallow me. This crappy piece of
optimisation in xnintr_edge_shirq_handler() I introduced both to 2.4 and
(sadly) the 2.3.x stable series cannot work. It must stay as it used to:

--- ksrc/nucleus/intr.c	(revision 2871)
+++ ksrc/nucleus/intr.c	(working copy)
@@ -296,15 +296,15 @@ static void xnintr_edge_shirq_handler(un
 		s |=3D ret;

 		if (code =3D=3D XN_ISR_HANDLED) {
-			if (!(end =3D (intr->next)))
-				end =3D shirq->handlers;
+			end =3D NULL;
 			xnstat_counter_inc(
 				&intr->stat[xnsched_cpu(sched)].hits);
 			xnstat_runtime_lazy_switch(sched,
 				&intr->stat[xnsched_cpu(sched)].account,
 				start);
 			start =3D xnstat_runtime_now();
-		}
+		} else if (code =3D=3D XN_ISR_NONE && end =3D=3D NULL)
+			end =3D intr;

 		if (counter++ > MAX_EDGEIRQ_COUNTER)
 			break;
(that's for 2.3.x)

Once "end" is moved forward to the next handler in the chain, the loop
termination condition "intr=3D=3Dend" will trigger on the immediately
following round, even if there are still events pending. Utterly broken.

Philippe, please quickly apply -- and don't tell anyone who did this.

Jan


--------------enigF9C6F497578951D2F5071123
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGr3n3niDOoMHTA+kRAmIPAJwPG3iKJHnmjA1RBVg4AQf0xV2wvwCeK4Pi
+wIgvsptch0Y7UKQPerZzG4=
=0PCU
-----END PGP SIGNATURE-----

--------------enigF9C6F497578951D2F5071123--

