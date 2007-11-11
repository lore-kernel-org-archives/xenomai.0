Message-ID: <47373D04.90308@domain.hid>
Date: Sun, 11 Nov 2007 18:33:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC30E49D95186B537B1F67F1F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] reset trace when setting new trigger
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC30E49D95186B537B1F67F1F
Content-Type: multipart/mixed;
 boundary="------------000709010709030207080403"

This is a multi-part message in MIME format.
--------------000709010709030207080403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For convenience: When the user sets a new triggering point via
/proc/ipipe/trace/trigger, also reset the currently frozen path so that
the new trigger can fire ASAP.

Jan

--------------000709010709030207080403
Content-Type: text/x-patch;
 name="reset-trace-on-new-trigger.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="reset-trace-on-new-trigger.patch"

---
 kernel/ipipe/tracer.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.23.1-xeno_64/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno_64.orig/kernel/ipipe/tracer.c
+++ linux-2.6.23.1-xeno_64/kernel/ipipe/tracer.c
@@ -1244,6 +1244,8 @@ static int __ipipe_wr_trigger(struct fil
 	/* invalidate the current range before setting a new one */
 	trigger_end =3D 0;
 	wmb();
+	ipipe_trace_frozen_reset();
+
 	/* set new range */
 	trigger_begin =3D begin;
 	wmb();

--------------000709010709030207080403--

--------------enigC30E49D95186B537B1F67F1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHNz0EniDOoMHTA+kRAhaAAJ4lRVh3Iyi9qY5pVrXVZ0EptSOs1ACeJBZm
lynpX7I5pk6HvRc2WWHsAjc=
=r4GX
-----END PGP SIGNATURE-----

--------------enigC30E49D95186B537B1F67F1F--

