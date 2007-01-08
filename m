Message-ID: <45A2C3DE.309@domain.hid>
Date: Mon, 08 Jan 2007 23:21:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF95E513E99D61F7846FF5BE0"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 2/2] output minimum function trace overhead
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
--------------enigF95E513E99D61F7846FF5BE0
Content-Type: multipart/mixed; boundary="------------020502030900050405070909"

This is a multi-part message in MIME format.
--------------020502030900050405070909
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch calibrates the best-case overhead a function trace point
introduces and dumps the result at the beginning of each tracer output.
Should give the reader of some trace an idea what the instrumentation
/at least/ costed per entry.

Jan

--------------020502030900050405070909
Content-Type: text/plain;
 name="calc-trace-overhead.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="calc-trace-overhead.patch"

---
 kernel/ipipe/tracer.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

Index: linux-2.6.19-ipipe/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/ipipe/tracer.c
+++ linux-2.6.19-ipipe/kernel/ipipe/tracer.c
@@ -129,6 +129,7 @@ static int pre_trace =3D IPIPE_DEFAULT_PRE
 static int post_trace =3D IPIPE_DEFAULT_POST_TRACE;
 static int back_trace =3D IPIPE_DEFAULT_BACK_TRACE;
 static int verbose_trace;
+static unsigned long trace_overhead;
=20
 static DEFINE_MUTEX(out_mutex);
 static struct ipipe_trace_path *print_path;
@@ -824,6 +825,9 @@ static void __ipipe_print_dbgwarning(str
=20
 static void __ipipe_print_headline(struct seq_file *m)
 {
+	seq_printf(m, "Calibrated minimum trace-point overhead: %lu.%03lu "
+		   "us\n\n", trace_overhead/1000, trace_overhead%1000);
+
 	if (verbose_trace) {
 		const char *name[4] =3D { [0 ... 3] =3D "<unused>" };
 		struct list_head *pos;
@@ -917,7 +921,7 @@ static void *__ipipe_max_prtrace_start(s
 			UTS_RELEASE, IPIPE_ARCH_STRING);
 		__ipipe_print_dbgwarning(m);
 		seq_printf(m, "Begin: %lld cycles, Trace Points: %d (-%d/+%d), "
-			"Length: %lu us\n\n",
+			"Length: %lu us\n",
 			print_path->point[print_path->begin].timestamp,
 			points, print_pre_trace, print_post_trace, length_usecs);
 		__ipipe_print_headline(m);
@@ -1073,7 +1077,7 @@ static void *__ipipe_frozen_prtrace_star
 			"------\n",
 			UTS_RELEASE, IPIPE_ARCH_STRING);
 		__ipipe_print_dbgwarning(m);
-		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n\n",
+		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n",
 			print_path->point[print_path->begin].timestamp,
 			print_pre_trace+1, print_post_trace);
 		__ipipe_print_headline(m);
@@ -1200,6 +1204,8 @@ void __init __ipipe_init_tracer(void)
 {
 	struct proc_dir_entry *trace_dir;
 	struct proc_dir_entry *entry;
+	unsigned long long start, end, min =3D ULLONG_MAX;
+	int i;
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
 	int cpu, path;
=20
@@ -1221,6 +1227,21 @@ void __init __ipipe_init_tracer(void)
 	ipipe_trace_enable =3D CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
=20
+	/* Calculate minimum overhead of __ipipe_trace() */
+	local_irq_disable_hw();
+	for (i =3D 0; i < 100; i++) {
+		ipipe_read_tsc(start);
+		__ipipe_trace(IPIPE_TRACE_FUNC, __BUILTIN_RETURN_ADDRESS0,
+			      __BUILTIN_RETURN_ADDRESS1, 0);
+		ipipe_read_tsc(end);
+
+		end -=3D start;
+		if (end < min)
+			min =3D end;
+	}
+	local_irq_enable_hw();
+	trace_overhead =3D ipipe_tsc2ns(min);
+
 	trace_dir =3D create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
=20
 	entry =3D create_proc_entry("max", 0644, trace_dir);

--------------020502030900050405070909--

--------------enigF95E513E99D61F7846FF5BE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFosPeniDOoMHTA+kRAhJFAJ9nvRYo2vsjrF2c4VTjUzqCxi/xsACfZDSj
m3bWjbK5uPgKx5TgpXsiWdw=
=YzrI
-----END PGP SIGNATURE-----

--------------enigF95E513E99D61F7846FF5BE0--

