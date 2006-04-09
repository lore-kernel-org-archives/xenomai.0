Message-ID: <4438EB6C.1030607@domain.hid>
Date: Sun, 09 Apr 2006 13:09:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8BD9736BD6B5F6FD43022E4C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] display domain status in I-ipipe tracer
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
--------------enig8BD9736BD6B5F6FD43022E4C
Content-Type: multipart/mixed; boundary="------------020301090803040903080809"

This is a multi-part message in MIME format.
--------------020301090803040903080809
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

as promised, here is the patch to extend the I-ipipe trace so that it
displays also the domain stall flags of the first 4 domains (I don't
expect more in practice yet ;) ). The information is shown if you switch
on the verbose mode (echo 1 > /proc/ipipe/tracer/verbose). Also, more
explanation of the shown columns is given now.

Please apply.

Jan

--------------020301090803040903080809
Content-Type: text/x-patch;
 name="ipipe-dom-state.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-dom-state.patch"

---
 kernel/ipipe/core.c   |    4 --
 kernel/ipipe/tracer.c |   77 +++++++++++++++++++++++++++++++++++++++++++=
++-----
 2 files changed, 71 insertions(+), 10 deletions(-)

Index: linux-2.6.15.3-kgdb/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/ipipe/core.c
+++ linux-2.6.15.3-kgdb/kernel/ipipe/core.c
@@ -40,7 +40,7 @@ struct ipipe_domain *ipipe_percpu_domain
=20
 ipipe_spinlock_t __ipipe_pipelock =3D IPIPE_SPIN_LOCK_UNLOCKED;
=20
-struct list_head __ipipe_pipeline;
+LIST_HEAD(__ipipe_pipeline);
=20
 unsigned long __ipipe_virtual_irq_map =3D 0;
=20
@@ -66,8 +66,6 @@ void ipipe_init(void)
 	 * secondary CPUs are still lost in space.
 	 */
=20
-	INIT_LIST_HEAD(&__ipipe_pipeline);
-
 	ipd->name =3D "Linux";
 	ipd->domid =3D IPIPE_ROOT_ID;
 	ipd->priority =3D IPIPE_ROOT_PRIO;
Index: linux-2.6.15.3-kgdb/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3-kgdb.orig/kernel/ipipe/tracer.c
+++ linux-2.6.15.3-kgdb/kernel/ipipe/tracer.c
@@ -51,6 +51,7 @@
=20
 #define IPIPE_TFLG_HWIRQ_OFF        0x0100
 #define IPIPE_TFLG_FREEZING         0x0200
+#define IPIPE_TFLG_DOMSTATE_SHIFT   12   /* bits 12..15: domain stalled?=
 */
=20
=20
 struct ipipe_trace_point{
@@ -118,6 +119,24 @@ __ipipe_trace_point_type(char *buf, stru
 static void __ipipe_print_symname(struct seq_file *m, unsigned long eip)=
;
=20
=20
+static notrace void
+__ipipe_store_domain_states(struct ipipe_trace_point *point, int cpu_id)=

+{
+	int i =3D IPIPE_TFLG_DOMSTATE_SHIFT;
+	struct list_head *pos;
+
+	list_for_each_prev(pos, &__ipipe_pipeline) {
+		struct ipipe_domain *ipd =3D
+			list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpu_id].status))
+			point->flags |=3D (1 << i);
+
+		if (++i > IPIPE_TFLG_DOMSTATE_SHIFT+3)
+			break;
+	}
+}
+
 static notrace int __ipipe_get_free_trace_path(int old, int cpu_id)
 {
 	int new_active =3D old;
@@ -282,6 +301,8 @@ restart:
 	point->v =3D v;
 	ipipe_read_tsc(point->timestamp);
=20
+	__ipipe_store_domain_states(point, cpu_id);
+
 	/* forward to next point buffer */
 	next_pos =3D WRAP_POINT_NO(pos+1);
 	tp->trace_pos =3D next_pos;
@@ -617,6 +638,7 @@ __ipipe_print_pathmark(struct seq_file *
 {
 	char mark =3D ' ';
 	int point_no =3D point - print_path->point;
+	int i;
=20
 	if (print_path->end =3D=3D point_no)
 		mark =3D '<';
@@ -626,6 +648,12 @@ __ipipe_print_pathmark(struct seq_file *
 		mark =3D ':';
 	seq_printf(m, "%c%c", mark,
 	           (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
+
+	if (verbose_trace)
+		for (i =3D IPIPE_TFLG_DOMSTATE_SHIFT + 3;
+		     i >=3D IPIPE_TFLG_DOMSTATE_SHIFT; i--)
+			seq_printf(m, "%c",
+			           (point->flags & (1 << i)) ? '*' : ' ');
 }
=20
 static void
@@ -695,6 +723,9 @@ static void __ipipe_print_dbgwarning(str
 #ifdef CONFIG_XENO_OPT_DEBUG
 		" o CONFIG_XENO_OPT_DEBUG\n"
 #endif /* CONFIG_XENO_OPT_DEBUG */
+#ifdef CONFIG_XENO_OPT_DEBUG_QUEUES
+		" o CONFIG_XENO_OPT_DEBUG_QUEUES (very costly)\n"
+#endif /* CONFIG_XENO_OPT_DEBUG */
 #ifdef CONFIG_DEBUG_PREEMPT
 		" o CONFIG_DEBUG_PREEMPT\n"
 #endif /* CONFIG_DEBUG_PREEMPT */
@@ -706,9 +737,44 @@ static void __ipipe_print_dbgwarning(str
=20
 static void __ipipe_print_headline(struct seq_file *m)
 {
-	seq_puts(m, verbose_trace ?
-		"  Type   User Val.   Time    Delay  Function (Parent)\n" :
-		"  Type    Time   Function (Parent)\n");
+	if (verbose_trace) {
+		const char *name[4] =3D { [0 ... 3] =3D "<unused>" };
+		struct list_head *pos;
+		int i =3D 0;
+
+		list_for_each_prev(pos, &__ipipe_pipeline) {
+			struct ipipe_domain *ipd =3D
+				list_entry(pos, struct ipipe_domain, p_link);
+
+			name[i] =3D ipd->name;
+			if (++i > 3)
+				break;
+		}
+
+		seq_printf(m,
+		           " +----- Hard IRQs ('|': locked)\n"
+		           " |+---- %s\n"
+		           " ||+--- %s\n"
+		           " |||+-- %s\n"
+		           " ||||+- %s%s\n"
+		           " |||||                       +---------- "
+		               "Delay flag ('+': > %d us, '!': > %d us)\n"
+		           " |||||                       |        +- "
+		               "NMI noise ('N')\n"
+		           " |||||                       |        |\n"
+		           "      Type   User Val.   Time    Delay  Function "
+		               "(Parent)\n",
+		           name[3], name[2], name[1], name[0],
+		           name[0] ? " ('*': domain stalled)" : "",
+		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
+	} else
+		seq_printf(m,
+		           " +-------------- Hard IRQs ('|': locked)\n"
+		           " |            +- Delay flag "
+		               "('+': > %d us, '!': > %d us)\n"
+		           " |            |\n"
+		           "  Type    Time   Function (Parent)\n",
+		           IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
 }
=20
 static void *__ipipe_max_prtrace_start(struct seq_file *m, loff_t *pos)
@@ -914,10 +980,7 @@ static void *__ipipe_frozen_prtrace_star
 		seq_printf(m, "Freeze: %lld cycles, Trace Points: %d (+%d)\n\n",
 			print_path->point[print_path->begin].timestamp,
 			print_pre_trace+1, print_post_trace);
-
-		seq_puts(m, verbose_trace ?
-			"  Type   User Val.   Time    Delay  Function (Parent)\n" :
-			"  Type    Time   Function (Parent)\n");
+		__ipipe_print_headline(m);
 	}
=20
 	/* check if we are inside the trace range */

--------------020301090803040903080809--

--------------enig8BD9736BD6B5F6FD43022E4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEOOtsniDOoMHTA+kRAiwYAJ9MX1c50cMpx/NZzkMK/WEOzaiY7ACbBX5g
gAPZ/McSM4Unv6q5ok1wUZs=
=6uNV
-----END PGP SIGNATURE-----

--------------enig8BD9736BD6B5F6FD43022E4C--

