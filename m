Message-ID: <447E2A70.3050102@domain.hid>
Date: Thu, 01 Jun 2006 01:44:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_countat
	kernel/sched.c:2819!
References: <EF12971F23B6EE48803C4991CDAF3C800303BF36@domain.hid>
	<447E1216.8040900@domain.hid>
	<200605312248.k4VMmacw025962@domain.hid>
In-Reply-To: <200605312248.k4VMmacw025962@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig840F15A62411AD7E18877FB7"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wallace@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>, Jim.Rosenow@domain.hid, Harshad.Kharche@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig840F15A62411AD7E18877FB7
Content-Type: multipart/mixed; boundary="------------060504020309030903070903"

This is a multi-part message in MIME format.
--------------060504020309030903070903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gary Wallace wrote:
>   I have determined that the "Uncompressing Linux...inflate returned
> FFFFFFFB" error is caused by the size of the uncompressed image.  I
> was able to shrink the image enough that it would uncompress by
> lowering CONFIG_IPIPE_TRACE_SHIFT to 2 (I had to change the config
> limit to do this) and by building some of the drivers as modules.

2^2 =3D 4 entries for trace points. This renders the tracer useless.

>=20
>   One of the motorola developers also pointed out to me that using
> MOTLoad I could just download and boot the uncompressed image file.  I
> used "netBoot -d/dev/enet1 -c192.168.151.133 -s192.168.151.135
> -fvmlinux.bin".

So this problem melts down to the large static buffer the tracer
introduces. Hmm, by booting with tracing disabled, allocating the buffer
dynamically via vmalloc, and then arming the tracer we may work around
this issue.

Attached is a patch against the applied tracer which hacks in such a
feature. It works on my qemu-i386 box (does anyone know if qemu-ppc
would be usable for us as well?), but I only tested it roughly. Please
give it a try.

>=20
>   Unfortunately, though I now get past the uncompress error my kernel
> is consistently hanging in the boot process instead of generating the
> kernel preempt bug error.  Thus I still haven't been able to get a
> trace.  I haven't had time recently to work on this, but as soon as I
> can I hope to continue attempts to generate a trace of the problem.
> I would suggest you try booting an uncompressed image in the hopes
> that you'll be able to generate a trace.

I'm afraid that this problem has a different reason (and I still wonder
why you needed such a small TRACE_SHIFT...). Anyway, step by step.
Thanks in advance for your patience.

Jan


PS: Re-added the list to CC.

--------------060504020309030903070903
Content-Type: text/x-patch;
 name="tracer-dyn-buffer.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-dyn-buffer.patch"

Index: linux-2.6.16.16/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.16.orig/kernel/ipipe/tracer.c
+++ linux-2.6.16.16/kernel/ipipe/tracer.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
+#include <linux/vmalloc.h>
 #include <linux/ipipe_trace.h>
 #include <asm/uaccess.h>
=20
@@ -86,14 +87,9 @@ enum ipipe_trace_type
 };
=20
=20
-int ipipe_trace_enable =3D 1;
+int ipipe_trace_enable =3D 0;
=20
-static struct ipipe_trace_path trace_paths[NR_CPUS][IPIPE_TRACE_PATHS] =3D=

-	{ [0 ... NR_CPUS-1] =3D
-		{ [0 ... IPIPE_TRACE_PATHS-1] =3D
-			{ .begin =3D -1, .end =3D -1 }
-		}
-	};
+static struct ipipe_trace_path *trace_paths[NR_CPUS];
 static int active_path[NR_CPUS] =3D
 	{ [0 ... NR_CPUS-1] =3D IPIPE_DEFAULT_ACTIVE };
 static int max_path[NR_CPUS] =3D
@@ -1101,6 +1097,18 @@ void __init __ipipe_init_trace_proc(void
 {
 	struct proc_dir_entry *trace_dir;
 	struct proc_dir_entry *entry;
+	int i,j;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		trace_paths[i] =3D vmalloc(sizeof(struct ipipe_trace_path) * IPIPE_TRA=
CE_PATHS);
+		if (!trace_paths)
+			return;
+		for (j =3D 0; j < IPIPE_TRACE_PATHS; j++) {
+			trace_paths[i][j].begin =3D -1;
+			trace_paths[i][j].end   =3D -1;
+		}
+	}
+	ipipe_trace_enable =3D 1;
=20
 	trace_dir =3D create_proc_entry("trace", S_IFDIR, ipipe_proc_root);
=20

--------------060504020309030903070903--

--------------enig840F15A62411AD7E18877FB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEfipxniDOoMHTA+kRAnm3AJ9YrsjRQ6gzAUH9xAsS36MS9MXo3gCaAsHM
+uwhRwoPAwDo4zIHD7c5IoQ=
=ffVK
-----END PGP SIGNATURE-----

--------------enig840F15A62411AD7E18877FB7--

