Message-ID: <44A4D586.4080402@domain.hid>
Date: Fri, 30 Jun 2006 09:40:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] pid and current-domain tracing
References: <44A2DB18.9080309@domain.hid>
In-Reply-To: <44A2DB18.9080309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig861A992F74EDDD1C360163CD"
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
--------------enig861A992F74EDDD1C360163CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Grmbl, off-by-one bug. That buffer requires 12 bytes. Add-on patch to
fix this:

--- linux-2.6.16.16.orig/kernel/ipipe/tracer.c
+++ linux-2.6.16.16/kernel/ipipe/tracer.c
@@ -612,7 +612,7 @@ void ipipe_trace_panic_dump(void)
 {
 	int cnt =3D back_trace;
 	int start, pos;
-	char task_info[11];
+	char task_info[12];

 	printk("I-pipe tracer log (%d points):\n", cnt);




--------------enig861A992F74EDDD1C360163CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEpNWKniDOoMHTA+kRAiLYAJ9GQ+SamlSmAu8bqlrUJBAb+uzfjQCfWv2h
3GNonO7XzGhqSzoWw2iAni8=
=UTBp
-----END PGP SIGNATURE-----

--------------enig861A992F74EDDD1C360163CD--

