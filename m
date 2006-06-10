Message-ID: <448AF8B0.4090505@domain.hid>
Date: Sat, 10 Jun 2006 18:52:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF7229B1770FC55CA3821A8F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix breakage by #1185
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
--------------enigCF7229B1770FC55CA3821A8F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I guess this is more like what check-in #1185 wanted to achieve:

--- src/skins/vrtx/task.c       (Revision 1186)
+++ src/skins/vrtx/task.c       (Arbeitskopie)
@@ -247,5 +247,6 @@ void sc_unlock (void)
 void sc_delay (long timeout)
 {
     XENOMAI_SKINCALL1(__vrtx_muxid,
-                     __vrtx_delay);
+                     __vrtx_delay,
+                     timeout);
 }

Jan


PS: Is this distribution of sc_delay() intended: src/skins/vrtx/task.c
vs. ksrc/skins/vrtx/time.c?


--------------enigCF7229B1770FC55CA3821A8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEivi0niDOoMHTA+kRAg3DAJoDfImXYSDP+lGrR17+Tzua3aTn2ACfTlPv
/Ivpgj2B2lcdzxOlqrSbCYE=
=Q4CO
-----END PGP SIGNATURE-----

--------------enigCF7229B1770FC55CA3821A8F--

