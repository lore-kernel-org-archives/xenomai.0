Message-ID: <45A2C3BC.7070705@domain.hid>
Date: Mon, 08 Jan 2007 23:20:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig59DA49578A8D9E50FB67CFBF"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 1/2] various tracer cleanups
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
--------------enig59DA49578A8D9E50FB67CFBF
Content-Type: multipart/mixed; boundary="------------030706010706010400030007"

This is a multi-part message in MIME format.
--------------030706010706010400030007
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The first of the two patches pending in my repos for too long. This one
reformats i386's mcount.S and fixes some comments, turns
mutex-semaphores into real mutexes, and does further minor cleanups.

Jan

--------------030706010706010400030007
Content-Type: text/plain;
 name="tracer-cleanups.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tracer-cleanups.patch"

---
 arch/i386/kernel/mcount.S |   54 +++++++++++++++++++++++----------------=
-------
 kernel/ipipe/core.c       |    2 -
 kernel/ipipe/tracer.c     |   24 ++++++++++----------
 3 files changed, 40 insertions(+), 40 deletions(-)

Index: linux-2.6.19-ipipe/arch/i386/kernel/mcount.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/arch/i386/kernel/mcount.S
+++ linux-2.6.19-ipipe/arch/i386/kernel/mcount.S
@@ -6,38 +6,38 @@
=20
 .globl mcount
 mcount:
-        cmpl $0,ipipe_trace_enable
-        je out
+	cmpl $0,ipipe_trace_enable
+	je out
=20
-        pushl %ebp
-        movl %esp,%ebp
+	pushl %ebp
+	movl %esp,%ebp
=20
-        pushl %eax
-        pushl %ecx
-        pushl %edx
+	pushl %eax
+	pushl %ecx
+	pushl %edx
=20
-        pushl $0                # no additional value (v)
+	pushl $0		# no additional value (v)
 #ifdef CONFIG_REGPARM
-        movl (%ebp),%eax
-        movl 0x4(%ebp),%edx     # __CALLER_ADDR0
-        movl 0x4(%eax),%ecx     # __CALLER_ADDR1
-        movl $0,%eax            # IPIPE_TRACE_FN
-        call __ipipe_trace
-        popl %eax
+	movl (%ebp),%eax
+	movl 0x4(%ebp),%edx	# __CALLER_ADDR0
+	movl 0x4(%eax),%ecx	# __CALLER_ADDR1
+	movl $0,%eax		# IPIPE_TRACE_FUNC
+	call __ipipe_trace
+	popl %eax
 #else /* !CONFIG_REGPARM */
-        movl (%ebp),%eax
-        movl 0x4(%eax),%eax
-        pushl %eax              # __CALLER_ADDR1
-        movl 0x4(%ebp),%eax
-        pushl %eax              # __CALLER_ADDR0
-        pushl $0                # IPIPE_TRACE_FN
-        call __ipipe_trace
-        addl $0x10,%esp
+	movl (%ebp),%eax
+	movl 0x4(%eax),%eax
+	pushl %eax		# __CALLER_ADDR1
+	movl 0x4(%ebp),%eax
+	pushl %eax		# __CALLER_ADDR0
+	pushl $0		# IPIPE_TRACE_FUNC
+	call __ipipe_trace
+	addl $0x10,%esp
 #endif /* CONFIG_REGPARM */
=20
-        popl %edx
-        popl %ecx
-        popl %eax
-        popl %ebp
+	popl %edx
+	popl %ecx
+	popl %eax
+	popl %ebp
 out:
-        ret
+	ret
Index: linux-2.6.19-ipipe/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/ipipe/tracer.c
+++ linux-2.6.19-ipipe/kernel/ipipe/tracer.c
@@ -128,9 +128,9 @@ static IPIPE_DEFINE_SPINLOCK(global_path
 static int pre_trace =3D IPIPE_DEFAULT_PRE_TRACE;
 static int post_trace =3D IPIPE_DEFAULT_POST_TRACE;
 static int back_trace =3D IPIPE_DEFAULT_BACK_TRACE;
-static int verbose_trace =3D 0;
+static int verbose_trace;
=20
-static DECLARE_MUTEX(out_mutex);
+static DEFINE_MUTEX(out_mutex);
 static struct ipipe_trace_path *print_path;
 static struct ipipe_trace_path *panic_path;
 static int print_pre_trace;
@@ -869,7 +869,7 @@ static void *__ipipe_max_prtrace_start(s
 {
 	loff_t n =3D *pos;
=20
-	down(&out_mutex);
+	mutex_lock(&out_mutex);
=20
 	if (!n) {
 		struct ipipe_trace_path *path;
@@ -951,7 +951,7 @@ static void __ipipe_prtrace_stop(struct=20
 {
 	if (print_path)
 		print_path->dump_lock =3D 0;
-	up(&out_mutex);
+	mutex_unlock(&out_mutex);
 }
=20
 static int __ipipe_prtrace_show(struct seq_file *m, void *p)
@@ -1012,9 +1012,9 @@ static ssize_t
 __ipipe_max_reset(struct file *file, const char __user *pbuffer,
                   size_t count, loff_t *data)
 {
-	down(&out_mutex);
+	mutex_lock(&out_mutex);
 	ipipe_trace_max_reset();
-	up(&out_mutex);
+	mutex_unlock(&out_mutex);
=20
 	return count;
 }
@@ -1031,7 +1031,7 @@ static void *__ipipe_frozen_prtrace_star
 {
 	loff_t n =3D *pos;
=20
-	down(&out_mutex);
+	mutex_lock(&out_mutex);
=20
 	if (!n) {
 		struct ipipe_trace_path *path;
@@ -1119,11 +1119,11 @@ __ipipe_frozen_ctrl(struct file *file, c
 	if (((*end !=3D '\0') && !isspace(*end)) || (val < 0))
 		return -EINVAL;
=20
-	down(&out_mutex);
+	mutex_lock(&out_mutex);
 	ipipe_trace_frozen_reset();
 	if (val > 0)
 		ipipe_trace_freeze(-1);
-	up(&out_mutex);
+	mutex_unlock(&out_mutex);
=20
 	return count;
 }
@@ -1172,9 +1172,9 @@ static int __ipipe_wr_proc_val(struct fi
 	if (((*end !=3D '\0') && !isspace(*end)) || (val < 0))
 		return -EINVAL;
=20
-	down(&out_mutex);
+	mutex_lock(&out_mutex);
 	*(int *)data =3D val;
-	up(&out_mutex);
+	mutex_unlock(&out_mutex);
=20
 	return count;
 }
@@ -1203,7 +1203,7 @@ void __init __ipipe_init_tracer(void)
 #ifdef CONFIG_IPIPE_TRACE_VMALLOC
 	int cpu, path;
=20
-	for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
+	foreach_possible_cpu(cpu) {
 		trace_paths[cpu] =3D vmalloc(
 			sizeof(struct ipipe_trace_path) * IPIPE_TRACE_PATHS);
 		if (!trace_paths) {
Index: linux-2.6.19-ipipe/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-ipipe.orig/kernel/ipipe/core.c
+++ linux-2.6.19-ipipe/kernel/ipipe/core.c
@@ -1374,7 +1374,7 @@ void __ipipe_remove_domain_proc(struct i
 	remove_proc_entry(ipd->name,ipipe_proc_root);
 }
=20
-void ipipe_init_proc(void)
+void __init ipipe_init_proc(void)
 {
 	ipipe_proc_root =3D create_proc_entry("ipipe",S_IFDIR, 0);
 	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_=
info_proc,NULL);

--------------030706010706010400030007--

--------------enig59DA49578A8D9E50FB67CFBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFosO9niDOoMHTA+kRAhzMAJ4k5bYGTVZvpOWDqIo6FQzVbBorLACcDtHu
ujuenzcEsLFkFbVloLwzLZQ=
=06W3
-----END PGP SIGNATURE-----

--------------enig59DA49578A8D9E50FB67CFBF--

