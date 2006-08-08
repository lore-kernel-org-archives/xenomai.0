Message-ID: <44D8C30D.4020400@domain.hid>
Date: Tue, 08 Aug 2006 18:59:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD615D8F3966906E766C907E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] start tracer disabled
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
--------------enigAD615D8F3966906E766C907E
Content-Type: multipart/mixed; boundary="------------070406020401050506010106"

This is a multi-part message in MIME format.
--------------070406020401050506010106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this tiny patch adds a config option to I-pipe to allow starting the
system with the tracer compiled in but disabled. You can then enabled it
on demand via /proc/ipipe/tracer/enable. This saves a bit time when
booting low-end boxes (I wonder why I didn't hacked this earlier...).

Jan

--------------070406020401050506010106
Content-Type: text/plain;
 name="tracer-default-off.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-default-off.patch"

Index: linux-2.6.17.8/kernel/ipipe/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.8.orig/kernel/ipipe/Kconfig
+++ linux-2.6.17.8/kernel/ipipe/Kconfig
@@ -6,7 +6,7 @@ config IPIPE
 	  compiled in.
=20
 config IPIPE_TRACE
- 	bool "Latency Tracing"
+	bool "Latency tracing"
 	depends on IPIPE && PROC_FS
 	select FRAME_POINTER
 	default n
@@ -18,6 +18,15 @@ config IPIPE_TRACE
 	  in-kernel tracing API. The collected data and runtime control
 	  is available via /proc/ipipe/trace/*.
=20
+config IPIPE_TRACE_ENABLE
+	bool "Enable tracing on boot"
+	depends on IPIPE_TRACE
+	default y
+	---help---
+	  Disable this option if you want to arm the tracer after booting
+	  manually ("echo 1 > /proc/ipipe/tracer/enable"). This can reduce
+	  boot time on slow embedded devices due to the tracer overhead.
+
 config IPIPE_TRACE_IRQSOFF
 	bool "Trace IRQs-off times"
 	depends on IPIPE_TRACE
@@ -44,3 +53,8 @@ config IPIPE_TRACE_VMALLOC
 	  enabled. This can help to start systems that are low on memory,
 	  but it slightly degrades overall performance. Try this option
 	  when a traced kernel hangs unexpectedly at boot time.
+
+config IPIPE_TRACE_ENABLE_VALUE
+	int
+	default 0 if !IPIPE_TRACE_ENABLE
+	default 1 if IPIPE_TRACE_ENABLE
Index: linux-2.6.17.8/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.8.orig/kernel/ipipe/tracer.c
+++ linux-2.6.17.8/kernel/ipipe/tracer.c
@@ -105,7 +105,7 @@ enum ipipe_trace_type
 static struct ipipe_trace_path *trace_paths[NR_CPUS];
=20
 #else /* !CONFIG_IPIPE_TRACE_VMALLOC */
-#define IPIPE_DEFAULT_TRACE_STATE   1
+#define IPIPE_DEFAULT_TRACE_STATE   CONFIG_IPIPE_TRACE_ENABLE_VALUE
=20
 static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =3D=

 	{ [0 ... NR_CPUS-1] =3D
@@ -1217,7 +1217,7 @@ void __init __ipipe_init_tracer(void)
 			trace_paths[cpu][path].end   =3D -1;
 		}
 	}
-	ipipe_trace_enable =3D 1;
+	ipipe_trace_enable =3D CONFIG_IPIPE_TRACE_ENABLE_VALUE;
 #endif /* CONFIG_IPIPE_TRACE_VMALLOC */
=20
 	trace_dir =3D create_proc_entry("trace", S_IFDIR, ipipe_proc_root);

--------------070406020401050506010106--

--------------enigAD615D8F3966906E766C907E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE2MMNniDOoMHTA+kRAnL+AJ9/pbup4Sn0TQkmRp2PgVlsabFNZQCfXGTs
WXKEH2LekgHLwwewfM3/ku0=
=IcZR
-----END PGP SIGNATURE-----

--------------enigAD615D8F3966906E766C907E--

