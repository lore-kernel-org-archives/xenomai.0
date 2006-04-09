Message-ID: <4438F951.5010507@domain.hid>
Date: Sun, 09 Apr 2006 14:08:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C1DD6F78B2806BB5291E961"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] trigger I-pipe trace freezing via proc
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C1DD6F78B2806BB5291E961
Content-Type: multipart/mixed; boundary="------------040808020904040606000605"

This is a multi-part message in MIME format.
--------------040808020904040606000605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

here is a tiny patch to re-trigger trace freezing by writing a positive
number to /proc/ipipe/trace/frozen. Writing 0 provides the old
behaviour, i.e. resets the frozen trace so that ipipe_trace_freeze() can
capture a new trace.

Please apply.

Jan

--------------040808020904040606000605
Content-Type: text/x-patch;
 name="ipipe-trace-trigger.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-trace-trigger.patch"

Index: linux-2.6.15.3-kgdb/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/ipipe/tracer.c
+++ linux-2.6.15.3-kgdb/kernel/ipipe/tracer.c
@@ -1005,11 +1005,28 @@ static int __ipipe_frozen_prtrace_open(s
 }
=20
 static ssize_t
-__ipipe_frozen_reset(struct file *file, const char __user *pbuffer,
-                     size_t count, loff_t *data)
+__ipipe_frozen_ctrl(struct file *file, const char __user *pbuffer,
+                    size_t count, loff_t *data)
 {
+	char *end, buf[16];
+	int val;
+	int n;
+
+	n =3D (count > sizeof(buf) - 1) ? sizeof(buf) - 1 : count;
+
+	if (copy_from_user(buf, pbuffer, n))
+		return -EFAULT;
+
+	buf[n] =3D '\0';
+	val =3D simple_strtol(buf, &end, 0);
+
+	if (((*end !=3D '\0') && !isspace(*end)) || (val < 0))
+		return -EINVAL;
+
 	down(&out_mutex);
 	ipipe_trace_frozen_reset();
+	if (val > 0)
+		ipipe_trace_freeze(-1);
 	up(&out_mutex);
=20
 	return count;
@@ -1018,7 +1035,7 @@ __ipipe_frozen_reset(struct file *file,=20
 struct file_operations __ipipe_frozen_prtrace_fops =3D {
 	.open       =3D __ipipe_frozen_prtrace_open,
 	.read       =3D seq_read,
-	.write      =3D __ipipe_frozen_reset,
+	.write      =3D __ipipe_frozen_ctrl,
 	.llseek     =3D seq_lseek,
 	.release    =3D seq_release,
 };

--------------040808020904040606000605--

--------------enig5C1DD6F78B2806BB5291E961
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEOPlRniDOoMHTA+kRAgcdAJ4vkD9KnFkU7oU8qprIBcMwFlugLQCfeSo8
p9+j31GsK0OS29fpxGbcreU=
=dhmJ
-----END PGP SIGNATURE-----

--------------enig5C1DD6F78B2806BB5291E961--

