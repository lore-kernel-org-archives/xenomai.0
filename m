Message-ID: <4572DB9F.7040505@domain.hid>
Date: Sun, 03 Dec 2006 15:13:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2824EB211F9BC7BFB7F3F360"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2824EB211F9BC7BFB7F3F360
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I came across a few things in latest 2.6.19-i386-1.6-01 patch:

The usage of __ipipe_pipelock in __ipipe_common_info_proc is broken (raw =
lock used as
Linux lock here), and I do not see any volatile data it could protect any=
way. So let's
remove it.

--- linux-2.6.19-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.19-ipipe/kernel/ipipe/core.c
@@ -1251,8 +1251,6 @@ static int __ipipe_common_info_proc(char
 	unsigned irq;
 	int len;
=20
-	spin_lock(&__ipipe_pipelock);
-
 	p +=3D sprintf(p, "       +----- Handling ([A]ccepted, [G]rabbed, [W]ir=
ed, [D]iscarded)\n");
 	p +=3D sprintf(p, "       |+---- Sticky\n");
 	p +=3D sprintf(p, "       ||+--- Locked\n");
@@ -1336,8 +1334,6 @@ static int __ipipe_common_info_proc(char
 	else
 		p +=3D sprintf(p, "priority=3D%d\n", ipd->priority);
=20
-	spin_unlock(&__ipipe_pipelock);
-
 	len =3D p - page;
=20
 	if (len <=3D off + count)



The hard IRQ state of the tracer output got inverted during recent restru=
cturing. This
fixes it (and indents a few labels correctly).

--- linux-2.6.19-ipipe.orig/kernel/ipipe/tracer.c
+++ linux-2.6.19-ipipe/kernel/ipipe/tracer.c
@@ -279,7 +279,7 @@ __ipipe_trace(enum ipipe_trace_type type
 	local_irq_save_hw_notrace(flags);
=20
 	cpu_id =3D ipipe_processor_id();
-restart:
+ restart:
 	tp =3D old_tp =3D &trace_paths[cpu_id][active_path[cpu_id]];
=20
 	/* here starts a race window with NMIs - catched below */
@@ -322,7 +322,7 @@ restart:
=20
 	/* store all trace point data */
 	point->type =3D type;
-	point->flags =3D raw_irqs_disabled_flags(flags) ? 0 : IPIPE_TFLG_HWIRQ_=
OFF;
+	point->flags =3D raw_irqs_disabled_flags(flags) ? IPIPE_TFLG_HWIRQ_OFF =
: 0;
 	point->eip =3D eip;
 	point->parent_eip =3D parent_eip;
 	point->v =3D v;
@@ -367,7 +367,7 @@ restart:
 		/* store the path's end (i.e. excluding post-trace) */
 		tp->end =3D WRAP_POINT_NO(pos - post_trace + tp->post_trace);
=20
-enforce_end:
+ enforce_end:
 		if (tp->flags & IPIPE_TFLG_FREEZING)
 			tp =3D __ipipe_trace_freeze(cpu_id, tp, pos);
 		else
@@ -411,7 +411,7 @@ static unsigned long __ipipe_global_path
 	spin_lock_irqsave(&global_path_lock, flags);
=20
 	cpu_id =3D ipipe_processor_id();
-restart:
+ restart:
 	tp =3D &trace_paths[cpu_id][active_path[cpu_id]];
=20
 	/* here is small race window with NMIs - catched below */



And finally, ipipe_init_proc can be moved to the __init section.

--- linux-2.6.19-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.19-ipipe/kernel/ipipe/core.c
@@ -1362,7 +1362,7 @@ void __ipipe_remove_domain_proc(struct i
 	remove_proc_entry(ipd->name,ipipe_proc_root);
 }
=20
-void ipipe_init_proc(void)
+void __init ipipe_init_proc(void)
 {
 	ipipe_proc_root =3D create_proc_entry("ipipe",S_IFDIR, 0);
 	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_=
info_proc,NULL);



There is more cleanup stuff in my pipe, one of it (type-based spinlock se=
lection)
could be helpful for follow-up work on other archs. It's almost done, I w=
ill try to
prepare patch series over the next days.

Jan



--------------enig2824EB211F9BC7BFB7F3F360
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFctufniDOoMHTA+kRAlh9AJ9vbqcCLPEiWPzjXFNMxX+B4FZxJQCffx3M
7PJpfxaYSEYnr+5gHvqeKik=
=yzhP
-----END PGP SIGNATURE-----

--------------enig2824EB211F9BC7BFB7F3F360--

