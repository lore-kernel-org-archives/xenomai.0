Message-ID: <4491426B.50508@domain.hid>
Date: Thu, 15 Jun 2006 13:20:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2AA3949CF4D14B0F8F8DF28"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] use vmalloc'ed trace buffer
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
--------------enigA2AA3949CF4D14B0F8F8DF28
Content-Type: multipart/mixed; boundary="------------090604080803040202080704"

This is a multi-part message in MIME format.
--------------090604080803040202080704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

here is the cleaned up and configurable version of my vmalloc hack for
the I-pipe tracer.

As it has a slight performance impact to use virtual memory for the
trace buffer (running "hackbench 10" in parallel to "latency -p 100" on
a 266 MHz P-MMX: 227 vs. 244 s hackbench runtime), I left this option
off by default. If there is any kind of CONFIG combination that cries
for default on, we can easily add it.

Jan

--------------090604080803040202080704
Content-Type: text/plain;
 name="tracer-dyn-buffer-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-dyn-buffer-v2.patch"

Index: linux-2.6.16.1/kernel/ipipe/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.1.orig/kernel/ipipe/Kconfig
+++ linux-2.6.16.1/kernel/ipipe/Kconfig
@@ -34,3 +34,12 @@ config IPIPE_TRACE_SHIFT
 	---help---
 	  The number of trace points to hold tracing data for each
 	  trace path, as a power of 2.
+
+config IPIPE_TRACE_VMALLOC
+	bool "Use vmalloc'ed trace buffer"
+	depends on IPIPE_TRACE
+	---help---
+	  Instead of reserving static kernel data, the required buffer
+	  is allocated via vmalloc during boot-up when this option is
+	  enabled. This can help to start systems that are low on memory,
+	  but it slightly degrades overall performance.
Index: linux-2.6.16.1/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.1.orig/kernel/ipipe/tracer.c
+++ linux-2.6.16.1/kernel/ipipe/tracer.c
@@ -2,7 +2,7 @@
  * kernel/ipipe/tracer.c
  *
  * Copyright (C) 2005 Luotao Fu.
- *               2005 Jan Kiszka.
+ *               2005, 2006 Jan Kiszka.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 #include <linux/ipipe_trace.h>
 #include <asm/uaccess.h>
=20
@@ -86,7 +87,13 @@ enum ipipe_trace_type
 };
=20
=20
-int ipipe_trace_enable =3D 1;
+#ifdef CONFIG_IPIPE_TRACE_VMALLOC
+#define IPIPE_DEFAULT_TRACE_STATE   0
+
+static struct ipipe_trace_path *trace_paths[NR_CPUS];
+
+#else /* !CONFIG_IPIPE_TRACE_VMALLOC */
+#define IPIPE_DEFAULT_TRACE_STATE   1
=20
 static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =3D=

 	{ [0 ... NR_CPUS-1] =3D
@@ -94,6 +101,10 @@ static struct ipipe_trace_path trace_pat
 			{ .begin =3D -1, .end =3D -1 }
 		}
 	};
+#endif /* CONFIG_IPIPE_TRACE_VMALLOC */
+
+int ipipe_trace_enable =3D IPIPE_DEFAULT_TRACE_STATE;
+
 static int active_path[NR_CPUS] =3D
 	{ [0 ... NR_CPUS-1] =3D IPIPE_DEFAULT_ACTIVE };
 static int max_path[NR_CPUS] =3D
@@ -1097,10 +1108,30 @@ __ipipe_create_trace_proc_val(struct pro
 	}
 }
=20
-void __init __ipipe_init_trace_proc(void)
+void __init __ipipe_init_tracer(void)
 {
 	struct proc_dir_entry *trace_dir;
 	struct proc_dir_entry *entry;
+#ifdef CONFIG_IPIPE_TRACE_VMALLOC
+	int cpu, path;
+
+	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+		trace_paths[cpu] =3D vmalloc(
+			sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
+		if (!trace_paths) {
+			printk(KERN_ERR "I-pipe: "
+			       "insufficient memory for trace buffer.\n");
+			return;
+		}
+		memset(trace_paths[cpu], 0,
+			sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
+		for (path =3D 0; path < IPIPE_TRACE_PATHS; path++) {
+			trace_paths[cpu][path].begin =3D -1;
+			trace_paths[cpu][path].end   =3D -1;
+		}
+	}
+	ipipe_trace_enable =3D 1;
+#endif /* CONFIG_IPIPE_TRACE_VMALLOC */
=20
 	trace_dir =3D create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
=20
Index: linux-2.6.16.1/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.1.orig/include/linux/ipipe.h
+++ linux-2.6.16.1/include/linux/ipipe.h
@@ -329,9 +329,9 @@ void ipipe_init(void);
 void ipipe_init_proc(void);
=20
 #ifdef CONFIG_IPIPE_TRACE
-void __ipipe_init_trace_proc(void);
+void __ipipe_init_tracer(void);
 #else /* !CONFIG_IPIPE_TRACE */
-#define __ipipe_init_trace_proc()   do { } while(0)
+#define __ipipe_init_tracer()       do { } while(0)
 #endif /* CONFIG_IPIPE_TRACE */
=20
 #else	/* !CONFIG_PROC_FS */
Index: linux-2.6.16.1/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.1.orig/kernel/ipipe/core.c
+++ linux-2.6.16.1/kernel/ipipe/core.c
@@ -1012,8 +1012,9 @@ void ipipe_init_proc(void)
 {
 	ipipe_proc_root =3D create_proc_entry("ipipe",S_IFDIR, 0);
 	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_=
info_proc,NULL);
-	__ipipe_init_trace_proc();
 	__ipipe_add_domain_proc(ipipe_root_domain);
+
+	__ipipe_init_tracer();
 }
=20
 #endif	/* CONFIG_PROC_FS */

--------------090604080803040202080704--

--------------enigA2AA3949CF4D14B0F8F8DF28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEkUJrniDOoMHTA+kRAsgOAJ9+wqcPHj4rwTrMWYR88NCJSYUtMACcDmpV
dektwc6L75syA2UqDmT/4Vg=
=0Wyk
-----END PGP SIGNATURE-----

--------------enigA2AA3949CF4D14B0F8F8DF28--

