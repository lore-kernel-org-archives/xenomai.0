Message-ID: <4647664A.2060309@domain.hid>
Date: Sun, 13 May 2007 21:26:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA152064988339F95B4B925A4"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 1/2] Perform panic traces only once
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
--------------enigA152064988339F95B4B925A4
Content-Type: multipart/mixed;
 boundary="------------040409070905060207030509"

This is a multi-part message in MIME format.
--------------040409070905060207030509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Make sure that only the first panic trace gets frozen and that it is
only dumped once until being reset by turning ipipe_trace_enable on
again. This avoids troubles when multiple ipipe_trace_panic_freeze are
called until the related ipipe_trace_panic_dump has been invoked.
Required for the succeeding patch, but also of generic usefulness IMO.

Jan

--------------040409070905060207030509
Content-Type: text/x-patch;
 name="trace_panic-only-once.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="trace_panic-only-once.patch"

---
 kernel/ipipe/tracer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6.20/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20/kernel/ipipe/tracer.c
@@ -566,6 +566,9 @@ void ipipe_trace_panic_freeze(void)
 	unsigned long flags;
 	int cpu_id;
=20
+	if (!ipipe_trace_enable)
+		return;
+
 	ipipe_trace_enable =3D 0;
 	local_irq_save_hw_notrace(flags);
=20
@@ -615,6 +618,9 @@ void ipipe_trace_panic_dump(void)
 	int start, pos;
 	char task_info[12];
=20
+	if (!panic_path)
+		return;
+
 	printk("I-pipe tracer log (%d points):\n", cnt);
=20
 	start =3D pos =3D WRAP_POINT_NO(panic_path->trace_pos-1);
@@ -668,6 +674,8 @@ void ipipe_trace_panic_dump(void)
 		}
 		pos =3D WRAP_POINT_NO(pos - 1);
 	}
+
+	panic_path =3D NULL;
 }
 EXPORT_SYMBOL(ipipe_trace_panic_dump);
=20

--------------040409070905060207030509--

--------------enigA152064988339F95B4B925A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGR2ZLniDOoMHTA+kRAjBOAKCBPZsLpSFfGWjz+LunssDqtZhJeACfePFN
l9viQDiBnFqN7TZPCxSK7Y4=
=Qt0l
-----END PGP SIGNATURE-----

--------------enigA152064988339F95B4B925A4--

