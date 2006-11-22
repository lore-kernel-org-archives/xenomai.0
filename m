Message-ID: <456426A7.3030305@domain.hid>
Date: Wed, 22 Nov 2006 11:29:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [Xenomai-help] Limiting Xenomai tasks to one
	certain core in a dual	core system
References: <13096879.1164184060512.JavaMail.ngmail@domain.hid>
	<45640F06.5000005@domain.hid>
In-Reply-To: <45640F06.5000005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig498099C1DCFFAB1B62F86B1E"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig498099C1DCFFAB1B62F86B1E
Content-Type: multipart/mixed; boundary="------------090007040705070401020509"

This is a multi-part message in MIME format.
--------------090007040705070401020509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> M. Koehrer wrote:
>> Is there a possibility to mask the CPUs to be used globally?
>> This could also avoid to pass the CPU number with each rt_task_create(=
) call.
>=20
> Well, that would actually be an additional way. Yeah, maybe some global=

> CPU mask that controls the affinity on future thread creation. We could=

> export it via /proc so that you can set it right before starting a
> specific group of applications and drivers.

Some food for thoughts:

Here is an experimental implementation of such a global mask. Seems to
work, at least I was able to prevent any task creation on a UP box by
setting the mask to 0.

Jan

--------------090007040705070401020509
Content-Type: text/plain;
 name="global-cpu-affinity.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="global-cpu-affinity.patch"

---
 include/nucleus/pod.h |    2 +
 ksrc/nucleus/module.c |   57 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
 ksrc/nucleus/pod.c    |    3 ++
 3 files changed, 62 insertions(+)

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
+	len =3D sprintf(page, "0x%08lx\n", val);
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
@@ -915,6 +917,7 @@ int xnpod_start_thread(xnthread_t *threa
 	xnlock_get_irqsave(&nklock, s);
=20
 	thread->affinity =3D xnarch_cpu_online_map;
+	xnarch_cpus_and(thread->affinity, nkaffinity, thread->affinity);
 	xnarch_cpus_and(thread->affinity, affinity, thread->affinity);
=20
 	if (xnarch_cpus_empty(thread->affinity)) {

--------------090007040705070401020509--

--------------enig498099C1DCFFAB1B62F86B1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFZCanniDOoMHTA+kRAhh8AJwN0v3v8gutl7PL65W1IzWdVRJviQCfS8gm
pmam4e8bTKaDvYMHP+DrI2I=
=UGH9
-----END PGP SIGNATURE-----

--------------enig498099C1DCFFAB1B62F86B1E--

