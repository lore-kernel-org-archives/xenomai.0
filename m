Message-ID: <456D81A0.8000603@domain.hid>
Date: Wed, 29 Nov 2006 13:48:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 2/2] global CPU affinity control
References: <456C3EFB.7030303@domain.hid>
In-Reply-To: <456C3EFB.7030303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC6FD94900945C9069FD660A2"
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
To: xenomai-core <xenomai@xenomai.org>
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6FD94900945C9069FD660A2
Content-Type: multipart/mixed; boundary="------------010507040000070903000401"

This is a multi-part message in MIME format.
--------------010507040000070903000401
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Version 5 is basically a rebase over the first patch of this series. It
also enforces that cpus_allowed of a shadow thread only contains a
single CPU.

Only compile-tested.

Jan

--------------010507040000070903000401
Content-Type: text/plain;
 name="global-cpu-affinity-v5.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="global-cpu-affinity-v5.patch"

---
 include/nucleus/pod.h    |    2 +
 ksrc/nucleus/intr.c      |    3 ++
 ksrc/nucleus/module.c    |   57 ++++++++++++++++++++++++++++++++++++++++=
+++++++
 ksrc/nucleus/pod.c       |    6 +++-
 ksrc/nucleus/shadow.c    |   12 ++++++---
 ksrc/skins/native/task.c |    3 ++
 6 files changed, 77 insertions(+), 6 deletions(-)

Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -253,6 +253,8 @@ extern u_long nktickdef;
=20
 extern char *nkmsgbuf;
=20
+extern xnarch_cpumask_t nkaffinity;
+
 #define xnprintf(fmt,args...)  xnarch_printf(fmt , ##args)
 #define xnloginfo(fmt,args...) xnarch_loginfo(fmt , ##args)
 #define xnlogwarn(fmt,args...) xnarch_logwarn(fmt , ##args)
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -688,6 +688,59 @@ static int heap_read_proc(char *page,
 	return len;
 }
=20
+static int affinity_read_proc(char *page,
+			      char **start,
+			      off_t off, int count, int *eof, void *data)
+{
+	unsigned long val =3D 0;
+	int len, cpu;
+
+	for (cpu =3D 0; cpu < sizeof(val) * 8; cpu++)
+		if (xnarch_cpu_isset(cpu, nkaffinity))
+			val |=3D (1 << cpu);
+
+	len =3D sprintf(page, "%08lx\n", val);
+	len -=3D off;
+	if (len <=3D off + count)
+		*eof =3D 1;
+	*start =3D page + off;
+	if (len > count)
+		len =3D count;
+	if (len < 0)
+		len =3D 0;
+
+	return len;
+}
+
+static int affinity_write_proc(struct file *file,
+			       const char __user * buffer,
+			       unsigned long count, void *data)
+{
+	char *end, buf[16];
+	unsigned long val;
+	xnarch_cpumask_t new_affinity;
+	int n, cpu;
+
+	n =3D count > sizeof(buf) - 1 ? sizeof(buf) - 1 : count;
+
+	if (copy_from_user(buf, buffer, n))
+		return -EFAULT;
+
+	buf[n] =3D '\0';
+	val =3D simple_strtol(buf, &end, 0);
+
+	if (*end !=3D '\0' && !isspace(*end))
+		return -EINVAL;
+
+	xnarch_cpus_clear(new_affinity);
+	for (cpu =3D 0; cpu < sizeof(val) * 8; cpu++, val >>=3D 1)
+		if (val & 1)
+			xnarch_cpu_set(cpu, new_affinity);
+	nkaffinity =3D new_affinity;
+
+	return count;
+}
+
 static struct proc_dir_entry *add_proc_leaf(const char *name,
 					    read_proc_t rdproc,
 					    write_proc_t wrproc,
@@ -760,6 +813,9 @@ void xnpod_init_proc(void)
=20
 	add_proc_leaf("heap", &heap_read_proc, NULL, NULL, rthal_proc_root);
=20
+	add_proc_leaf("affinity", &affinity_read_proc, &affinity_write_proc,
+		      NULL, rthal_proc_root);
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	iface_proc_root =3D
 	    create_proc_entry("interfaces", S_IFDIR, rthal_proc_root);
@@ -778,6 +834,7 @@ void xnpod_delete_proc(void)
=20
 	remove_proc_entry("interfaces", rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+	remove_proc_entry("affinity", rthal_proc_root);
 	remove_proc_entry("heap", rthal_proc_root);
 	remove_proc_entry("irq", rthal_proc_root);
 	remove_proc_entry("timer", rthal_proc_root);
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -70,6 +70,8 @@ MODULE_PARM_DESC(tick_arg, "Fixed clock=20
=20
 char *nkmsgbuf =3D NULL;
=20
+xnarch_cpumask_t nkaffinity =3D XNPOD_ALL_CPUS;
+
 const char *xnpod_fatal_helper(const char *format, ...)
 {
 	const unsigned nr_cpus =3D xnarch_num_online_cpus();
@@ -909,8 +911,8 @@ int xnpod_start_thread(xnthread_t *threa
 	if (!testbits(thread->status, XNDORMANT))
 		return -EBUSY;
=20
-	if (xnarch_cpus_empty(affinity))
-		affinity =3D XNARCH_CPU_MASK_ALL;
+	if (xnarch_cpus_equal(affinity, XNPOD_ALL_CPUS))
+		affinity =3D nkaffinity;
=20
 	xnlock_get_irqsave(&nklock, s);
=20
Index: xenomai/ksrc/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/native/task.c
+++ xenomai/ksrc/skins/native/task.c
@@ -255,6 +255,9 @@ int rt_task_create(RT_TASK *task,
 		if (cpumask & 1)
 			xnarch_cpu_set(cpu, task->affinity);
=20
+	if (xnarch_cpus_empty(task->affinity))
+		task->affinity =3D XNPOD_ALL_CPUS;
+
 #ifdef CONFIG_XENO_OPT_NATIVE_MPS
 	xnsynch_init(&task->mrecv, XNSYNCH_FIFO);
 	xnsynch_init(&task->msendq, XNSYNCH_PRIO | XNSYNCH_PIP);
Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -626,6 +626,9 @@ int xnintr_attach(xnintr_t *intr, void *
=20
 	xnlock_get_irqsave(&intrlock, s);
=20
+#ifdef CONFIG_SMP
+	xnarch_set_irq_affinity(intr->irq, nkaffinity);
+#endif /* CONFIG_SMP */
 	err =3D xnintr_irq_attach(intr);
=20
 	xnlock_put_irqrestore(&intrlock, s);
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -797,7 +797,7 @@ int xnshadow_map(xnthread_t *thread, xnc
 {
 	xnarch_cpumask_t affinity;
 	unsigned muxid, magic;
-	int mode, prio, err;
+	int mode, prio, err, cpu;
=20
 	/* Increment the interface reference count. */
 	magic =3D xnthread_get_magic(thread);
@@ -843,9 +843,13 @@ int xnshadow_map(xnthread_t *thread, xnc
 	xnshadow_thrptd(current) =3D thread;
 	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, NULL);
=20
-	/* Restrict affinity to a single CPU of the current set */
-	affinity =3D xnarch_cpumask_of_cpu(
-		xnarch_first_cpu(current->cpus_allowed));
+	/* Restrict affinity to a single CPU of nkaffinity or
+	   the current set. */
+	if (xnarch_cpus_equal(current->cpus_allowed, XNPOD_ALL_CPUS))
+		cpu =3D xnarch_first_cpu(nkaffinity);
+	else
+		cpu =3D xnarch_first_cpu(current->cpus_allowed);
+	affinity =3D xnarch_cpumask_of_cpu(cpu);
 	set_cpus_allowed(current, affinity);
=20
 	if (u_completion) {

--------------010507040000070903000401--

--------------enigC6FD94900945C9069FD660A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbYGgniDOoMHTA+kRArKBAKCBVJzAr7lG6bPcD1baKmFTl2Q8TwCff1KS
+vGg68yxsnGslHiOa3qV//A=
=zpMJ
-----END PGP SIGNATURE-----

--------------enigC6FD94900945C9069FD660A2--

