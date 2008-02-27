Message-ID: <47C51F5B.6090903@domain.hid>
Date: Wed, 27 Feb 2008 09:29:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFC47246420530B625D7916ED"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [RFC][PATCH] Reduce pipeline_head access overhead
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC47246420530B625D7916ED
Content-Type: multipart/mixed;
 boundary="------------090900090702060006090109"

This is a multi-part message in MIME format.
--------------090900090702060006090109
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch is in fact part of my xnlock rework (updates on that one will
follow the next days). I noticed that the complexity of
ipipe_cpudom_var(head_domain, *), normally inlined, is fairly relevant
for the text size of Xenomai and may thus impact the WCET as well.

So I applied the same pattern as already used for ipipe_root_cpudom_var
also to the head domain, ie. assigned a fixed slot, the topmost, in
ipipe_percpu_daddr/darray to the head domain. This gives a nice text
size reduction as we no longer need to go via
__ipipe_pipeline.next->slot (2 memory accesses, even 3 on x867/SMP +
some arithmetics) to look up the address of per-cpu domain variables
like "status".

The drawback is that this introduces an inconsistency to the
ipipe_*_pipeline_head API: It no longer works for head =3D=3D root. While=

this is most probably irrelevant in practice, it remains ugly. I already
thought about renaming the modified services (and deprecating the
original ones), but for now I would like to focus the discussion on the
optimized services.

The patch already survived quite some testing on various real and
virtual boxes with Xenomai. Latency reduction is hard to estimate as
such comparably small optimizations are within the noise range of fast
test boxes. Maybe someone could give this a try on a smaller device (UP
should benefit from this patch as well!).

Jan

--------------090900090702060006090109
Content-Type: text/x-patch;
 name="optimize-head-status.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimize-head-status.patch"

---
 include/linux/ipipe.h        |   13 +++++--------
 include/linux/ipipe_percpu.h |    8 +++++++-
 kernel/ipipe/core.c          |   42 ++++++++++++++++++++++--------------=
------
 3 files changed, 34 insertions(+), 29 deletions(-)

Index: b/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -361,31 +361,29 @@ static inline unsigned long ipipe_test_p
 static inline void ipipe_stall_pipeline_head(void)
 {
 	local_irq_disable_hw();
-	__set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(__ipipe_pipeline_head(), =
status));
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(status));
 }
=20
 static inline unsigned long ipipe_test_and_stall_pipeline_head(void)
 {
 	local_irq_disable_hw();
-	return __test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(__ipipe_p=
ipeline_head(), status));
+	return __test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(stat=
us));
 }
=20
 void ipipe_unstall_pipeline_head(void);
=20
-void fastcall __ipipe_restore_pipeline_head(struct ipipe_domain *head_do=
main,
-					    unsigned long x);
+void fastcall __ipipe_restore_pipeline_head(unsigned long x);
=20
 static inline void ipipe_restore_pipeline_head(unsigned long x)
 {
-	struct ipipe_domain *head_domain =3D __ipipe_pipeline_head();
 	/* On some archs, __test_and_set_bit() might return different
 	 * truth value than test_bit(), so we test the exclusive OR of
 	 * both statuses, assuming that the lowest bit is always set in
 	 * the truth value (if this is wrong, the failed optimization will
 	 * be caught in __ipipe_restore_pipeline_head() if
 	 * CONFIG_DEBUG_KERNEL is set). */
-	if ((x ^ test_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, stat=
us))) & 1)
-		__ipipe_restore_pipeline_head(head_domain, x);
+	if ((x ^ test_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(status))) & =
1)
+		__ipipe_restore_pipeline_head(x);
 }
=20
 #define ipipe_unstall_pipeline() \
@@ -477,7 +475,6 @@ int ipipe_disable_ondemand_mappings(stru
 #define local_irq_disable_hw_cond()		local_irq_disable_hw()
 #define local_irq_save_hw_cond(flags)		local_irq_save_hw(flags)
 #define local_irq_restore_hw_cond(flags)	local_irq_restore_hw(flags)
-#define local_irq_disable_head()		ipipe_stall_pipeline_head()
=20
 #define local_irq_enable_nohead(ipd)			\
 	do {						\
Index: b/include/linux/ipipe_percpu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ipipe_percpu.h
+++ b/include/linux/ipipe_percpu.h
@@ -49,6 +49,9 @@ DECLARE_PER_CPU(struct ipipe_percpu_doma
 	(__raw_get_cpu_var(ipipe_percpu_daddr)[(ipd)->slot]->var)
 #endif
=20
+#define IPIPE_ROOT_SLOT			0
+#define IPIPE_HEAD_SLOT			(CONFIG_IPIPE_DOMAINS - 1)
+
 DECLARE_PER_CPU(struct ipipe_percpu_domain_data, ipipe_percpu_darray[CON=
FIG_IPIPE_DOMAINS]);
=20
 DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
@@ -61,9 +64,12 @@ DECLARE_PER_CPU(int, ipipe_percpu_contex
 #define ipipe_cpu_var(var)		__raw_get_cpu_var(var)
=20
 #define ipipe_root_cpudom_var(var)	\
-	__raw_get_cpu_var(ipipe_percpu_darray)[0].var
+	__raw_get_cpu_var(ipipe_percpu_darray)[IPIPE_ROOT_SLOT].var
=20
 #define ipipe_this_cpudom_var(var)	\
 	ipipe_cpudom_var(ipipe_current_domain, var)
=20
+#define ipipe_head_cpudom_var(var)	\
+	__raw_get_cpu_var(ipipe_percpu_darray)[IPIPE_HEAD_SLOT].var
+
 #endif	/* !__LINUX_IPIPE_PERCPU_H */
Index: b/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -65,17 +65,18 @@ EXPORT_SYMBOL(__ipipe_root_status);
  * Work around a GCC 3.x issue making alias symbols unusable as
  * constant initializers.
  */
-unsigned long *const __ipipe_root_status_addr =3D &__raw_get_cpu_var(ipi=
pe_percpu_darray)[0].status;
+unsigned long *const __ipipe_root_status_addr =3D
+	&__raw_get_cpu_var(ipipe_percpu_darray)[IPIPE_ROOT_SLOT].status;
 EXPORT_SYMBOL(__ipipe_root_status_addr);
 #endif /* __GNUC__ < 4 */
=20
 DEFINE_PER_CPU(struct ipipe_percpu_domain_data *, ipipe_percpu_daddr[CON=
FIG_IPIPE_DOMAINS]) =3D
-{ [0] =3D (struct ipipe_percpu_domain_data *)&__raw_get_cpu_var(ipipe_pe=
rcpu_darray) };
+{ [IPIPE_ROOT_SLOT] =3D (struct ipipe_percpu_domain_data *)&__raw_get_cp=
u_var(ipipe_percpu_darray) };
 EXPORT_PER_CPU_SYMBOL(ipipe_percpu_daddr);
 #endif /* !CONFIG_SMP */
=20
 DEFINE_PER_CPU(struct ipipe_percpu_domain_data, ipipe_percpu_darray[CONF=
IG_IPIPE_DOMAINS]) =3D
-{ [0] =3D { .status =3D IPIPE_STALL_MASK } }; /* Root domain stalled on =
each CPU at startup. */
+{ [IPIPE_ROOT_SLOT] =3D { .status =3D IPIPE_STALL_MASK } }; /* Root doma=
in stalled on each CPU at startup. */
=20
 DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain) =3D { &ipipe_=
root };
=20
@@ -395,14 +396,12 @@ void fastcall ipipe_restore_pipeline_fro
=20
 void ipipe_unstall_pipeline_head(void)
 {
-	struct ipipe_domain *head_domain;
-
 	local_irq_disable_hw();
=20
-	head_domain =3D __ipipe_pipeline_head();
-	__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(status));
=20
-	if (unlikely(ipipe_cpudom_var(head_domain, irqpend_himask) !=3D 0)) {
+	if (unlikely(ipipe_head_cpudom_var(irqpend_himask) !=3D 0)) {
+		struct ipipe_domain *head_domain =3D __ipipe_pipeline_head();
 		if (likely(head_domain =3D=3D ipipe_current_domain))
 			__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 		else
@@ -412,14 +411,14 @@ void ipipe_unstall_pipeline_head(void)
 	local_irq_enable_hw();
 }
=20
-void fastcall __ipipe_restore_pipeline_head(struct ipipe_domain *head_do=
main, unsigned long x)
+void fastcall __ipipe_restore_pipeline_head(unsigned long x)
 {
 	local_irq_disable_hw();
=20
 	if (x) {
 #ifdef CONFIG_DEBUG_KERNEL
 		static int warned;
-		if (!warned && test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(he=
ad_domain, status))) {
+		if (!warned && test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_v=
ar(status))) {
 			/*
 			 * Already stalled albeit ipipe_restore_pipeline_head()
 			 * should have detected it? Send a warning once.
@@ -430,12 +429,13 @@ void fastcall __ipipe_restore_pipeline_h
 			dump_stack();
 		}
 #else /* !CONFIG_DEBUG_KERNEL */
-		set_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));
+		set_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(status));
 #endif /* CONFIG_DEBUG_KERNEL */
 	}
 	else {
-		__clear_bit(IPIPE_STALL_FLAG, &ipipe_cpudom_var(head_domain, status));=

-		if (unlikely(ipipe_cpudom_var(head_domain, irqpend_himask) !=3D 0)) {
+		__clear_bit(IPIPE_STALL_FLAG, &ipipe_head_cpudom_var(status));
+		if (unlikely(ipipe_head_cpudom_var(irqpend_himask) !=3D 0)) {
+			struct ipipe_domain *head_domain =3D __ipipe_pipeline_head();
 			if (likely(head_domain =3D=3D ipipe_current_domain))
 				__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
 			else
@@ -1011,7 +1011,7 @@ int ipipe_register_domain(struct ipipe_d
 			  struct ipipe_domain_attr *attr)
 {
 	struct ipipe_domain *_ipd;
-	struct list_head *pos;
+	struct list_head *pos =3D NULL;
 	unsigned long flags;
=20
 	if (!ipipe_root_domain_p) {
@@ -1020,14 +1020,16 @@ int ipipe_register_domain(struct ipipe_d
 		return -EPERM;
 	}
=20
-	if (attr->priority =3D=3D IPIPE_HEAD_PRIORITY &&
-	    test_bit(IPIPE_AHEAD_FLAG,&__ipipe_pipeline_head()->flags))
-		return -EAGAIN;	/* Cannot override current head. */
-
 	flags =3D ipipe_critical_enter(NULL);
=20
-	pos =3D NULL;
-	ipd->slot =3D ffz(__ipipe_domain_slot_map);
+	if (attr->priority =3D=3D IPIPE_HEAD_PRIORITY) {
+		if (test_bit(IPIPE_HEAD_SLOT, &__ipipe_domain_slot_map)) {
+			ipipe_critical_exit(flags);
+			return -EAGAIN;	/* Cannot override current head. */
+		}
+		ipd->slot =3D IPIPE_HEAD_SLOT;
+	} else
+		ipd->slot =3D ffz(__ipipe_domain_slot_map);
=20
 	if (ipd->slot < CONFIG_IPIPE_DOMAINS) {
 		set_bit(ipd->slot, &__ipipe_domain_slot_map);

--------------090900090702060006090109--

--------------enigFC47246420530B625D7916ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHxR9gniDOoMHTA+kRAhxWAJ9rxAmPYYtmGIW5V9kcDWXA7Z0zeACeNXgl
f8BkZxLIcYORwfqEQ4/AQSk=
=+OJm
-----END PGP SIGNATURE-----

--------------enigFC47246420530B625D7916ED--

