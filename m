Message-ID: <45CDB201.7000408@domain.hid>
Date: Sat, 10 Feb 2007 12:52:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9FF0F000393F4DA90572120C"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] fix typo in tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9FF0F000393F4DA90572120C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

My bad. Affects all recent ipipe releases.

Index: linux-2.6.20/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20/kernel/ipipe/tracer.c
@@ -1209,7 +1209,7 @@ void __init __ipipe_init_tracer(void)
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
 	int cpu, path;
=20
-	foreach_possible_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		trace_paths[cpu] =3D vmalloc(
 			sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
 		if (!trace_paths) {



--------------enig9FF0F000393F4DA90572120C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzbIBniDOoMHTA+kRAmfFAJ91BhoD28qyTp6fKiCB9H4Qw9kGywCfeBtS
eVB9olyAef8RgJfR2kZY6S4=
=vOQW
-----END PGP SIGNATURE-----

--------------enig9FF0F000393F4DA90572120C--

