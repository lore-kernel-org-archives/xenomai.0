Message-ID: <45682250.7070403@domain.hid>
Date: Sat, 25 Nov 2006 12:00:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Limiting Xenomai tasks to one certain core in
	a dual core system
References: <13096879.1164184060512.JavaMail.ngmail@domain.hid>	<45640F06.5000005@domain.hid>
	<456426A7.3030305@domain.hid>
In-Reply-To: <456426A7.3030305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA324033173BB67C7AB63BF12"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA324033173BB67C7AB63BF12
Content-Type: multipart/mixed; boundary="------------040606080506050100020300"

This is a multi-part message in MIME format.
--------------040606080506050100020300
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> M. Koehrer wrote:
>>> Is there a possibility to mask the CPUs to be used globally?
>>> This could also avoid to pass the CPU number with each rt_task_create=
() call.
>> Well, that would actually be an additional way. Yeah, maybe some globa=
l
>> CPU mask that controls the affinity on future thread creation. We coul=
d
>> export it via /proc so that you can set it right before starting a
>> specific group of applications and drivers.
>=20
> Some food for thoughts:
>=20
> Here is an experimental implementation of such a global mask. Seems to
> work, at least I was able to prevent any task creation on a UP box by
> setting the mask to 0.

Even more brain exercises:

This is version 2 of my patch, consequently applying the global mask
idea also on IRQ affinity. I think this simple mechanism can solve quite
a few basic SMP setup issue by forcing all user threads, driver threads,
and IRQs that are created/attached during a certain period to a specific
CPU set.

That's the theory. In practice, things look not that clear ATM. I
noticed some oddity on a 4-way qemu box running the latency test and
hacked the attached enhancement for /proc/xenomai/sched. This is what I
get on that box:

> root@domain.hid :/root# cat /proc/xenomai/sched=20
> CPU  AFFINITY PID    PRI      PERIOD   TIMEOUT    STAT       NAME
>   0  00000001 0       -1      0        0          R          ROOT/0
>   1  00000002 0       -1      0        0          R          ROOT/1
>   2  00000004 0       -1      0        0          R          ROOT/2
>   3  00000008 0       -1      0        0          R          ROOT/3
>   0  0000000c 917      0      0        0          W          display-91=
6
>   2  0000000c 918     99      5000000  1          D          sampling-9=
16
> root@domain.hid :/root# cat /proc/xenomai/affinity=20
> 0x0000000c

Philippe, anyone else: This scheduling of display-916 is not like as it
should be, is it?

Jan


PS: /proc output of IRQ affinities would be nice as well, but we are
lacking the require abstraction by ipipe ATM, something to read out the
currently set affinity.

--------------040606080506050100020300
Content-Type: text/plain;
 name="global-cpu-affinity-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="global-cpu-affinity-v2.patch"

---
 include/nucleus/pod.h |    2 +
 ksrc/nucleus/intr.c   |    3 ++
 ksrc/nucleus/module.c |   57 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
 ksrc/nucleus/pod.c    |    3 ++
 4 files changed, 65 insertions(+)

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
@@ -915,6 +917,7 @@ int xnpod_start_thread(xnthread_t *threa
 	xnlock_get_irqsave(&nklock, s);
=20
 	thread->affinity =3D xnarch_cpu_online_map;
+	xnarch_cpus_and(thread->affinity, nkaffinity, thread->affinity);
 	xnarch_cpus_and(thread->affinity, affinity, thread->affinity);
=20
 	if (xnarch_cpus_empty(thread->affinity)) {

--------------040606080506050100020300
Content-Type: text/plain;
 name="print-thread-affinity.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="print-thread-affinity.patch"

---
 ksrc/nucleus/module.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -103,6 +103,7 @@ struct sched_seq_iterator {
 		xnticks_t period;
 		xnticks_t timeout;
 		xnflags_t status;
+		xnarch_cpumask_t affinity;
 	} sched_info[1];
 };
=20
@@ -145,8 +146,9 @@ static int sched_seq_show(struct seq_fil
 	char sbuf[64], pbuf[16];
=20
 	if (v =3D=3D SEQ_START_TOKEN)
-		seq_printf(seq, "%-3s  %-6s %-8s %-8s %-10s %-10s %s\n",
-			   "CPU", "PID", "PRI", "PERIOD", "TIMEOUT", "STAT", "NAME");
+		seq_printf(seq, "%-3s  %-8s %-6s %-8s %-8s %-10s %-10s %s\n",
+			   "CPU", "AFFINITY", "PID", "PRI", "PERIOD", "TIMEOUT",
+			   "STAT", "NAME");
 	else {
 		struct sched_seq_info *p =3D (struct sched_seq_info *)v;
=20
@@ -156,8 +158,9 @@ static int sched_seq_show(struct seq_fil
 		else
 			snprintf(pbuf, sizeof(pbuf), "%3d", p->cprio);
=20
-		seq_printf(seq, "%3u  %-6d %-8s %-8Lu %-10Lu %-10s %s\n",
+		seq_printf(seq, "%3u  %08x %-6d %-8s %-8Lu %-10Lu %-10s %s\n",
 			   p->cpu,
+			   p->affinity,
 			   p->pid,
 			   pbuf,
 			   p->period,
@@ -237,6 +240,7 @@ static int sched_seq_open(struct inode *
 		iter->sched_info[n].period =3D xnthread_get_period(thread);
 		iter->sched_info[n].timeout =3D xnthread_get_timeout(thread, iter->sta=
rt_time);
 		iter->sched_info[n].status =3D thread->status;
+		iter->sched_info[n].affinity =3D thread->affinity;
=20
 		holder =3D nextq(&nkpod->threadq, holder);
=20

--------------040606080506050100020300--

--------------enigA324033173BB67C7AB63BF12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFaCJQniDOoMHTA+kRAjbcAJ4+N5oekeD6wDYOa/3xneglEi1lfgCfXP//
PC1S5g4jMNP32x/H299yBgo=
=h7yI
-----END PGP SIGNATURE-----

--------------enigA324033173BB67C7AB63BF12--

