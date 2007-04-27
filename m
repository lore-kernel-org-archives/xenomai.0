Message-ID: <4631CEAE.6060603@domain.hid>
Date: Fri, 27 Apr 2007 12:21:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4630F284.6040103@domain.hid>
	<b647ffbd0704270306h21a41eadr850567f6c8d58c22@domain.hid>
In-Reply-To: <b647ffbd0704270306h21a41eadr850567f6c8d58c22@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE95E804A4B5C625365A9DDF4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH 7/7] Detect illicit cross-domain calls
	(i386/x86_64)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE95E804A4B5C625365A9DDF4
Content-Type: multipart/mixed;
 boundary="------------080205060601010201000402"

This is a multi-part message in MIME format.
--------------080205060601010201000402
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 26/04/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> [This patch is a remake of
>> https://mail.gna.org/public/adeos-main/2006-09/msg00037.html]
>=20
> one minor issue below..
>=20
>>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.20.orig/include/linux/preempt.h
>> +++ linux-2.6.20/include/linux/preempt.h
>> @@ -8,6 +8,7 @@
>>
>>  #include <linux/thread_info.h>
>>  #include <linux/linkage.h>
>> +#include <linux/preempt.h>
>=20
> includes itself.. is it kindof a new useful trick? if so please educate=

> me :o)

Interesting... I guess someone was trying to type "ipipe_base" while
thinking of "preempt". The former seems to be included implicitly, the
latter caused no harm. Anyway, corrected patch attached.

Thanks for review.

Jan

--------------080205060601010201000402
Content-Type: text/plain;
 name="debug-dom-violation-v4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="debug-dom-violation-v4.patch"

---
 include/linux/ipipe_base.h |    6 ++++
 include/linux/kernel.h     |    8 ++++--
 include/linux/preempt.h    |   59 ++++++++++++++++++--------------------=
-------
 kernel/ipipe/Kconfig.debug |    9 ++++++
 kernel/ipipe/core.c        |   31 +++++++++++++++++++++++
 5 files changed, 76 insertions(+), 37 deletions(-)

Index: linux-2.6.20/include/linux/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe_base.h
+++ linux-2.6.20/include/linux/ipipe_base.h
@@ -75,6 +75,12 @@ void __ipipe_unstall_root(void);
=20
 void __ipipe_restore_root(unsigned long x);
=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void ipipe_check_context(struct ipipe_domain *border_ipd);
+#else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+static inline void ipipe_check_context(struct ipipe_domain *border_ipd) =
{ }
+#endif /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
 #endif	/* CONFIG_IPIPE */
=20
 #endif	/* !__LINUX_IPIPE_BASE_H */
Index: linux-2.6.20/include/linux/kernel.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/kernel.h
+++ linux-2.6.20/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/ipipe_base.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
@@ -72,9 +73,12 @@ struct user;
  */
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 extern int cond_resched(void);
-# define might_resched() cond_resched()
+# define might_resched() do { \
+		ipipe_check_context(ipipe_root_domain); \
+		cond_resched(); \
+	} while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() ipipe_check_context(ipipe_root_domain)
 #endif
=20
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
Index: linux-2.6.20/include/linux/preempt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/preempt.h
+++ linux-2.6.20/include/linux/preempt.h
@@ -8,6 +8,7 @@
=20
 #include <linux/thread_info.h>
 #include <linux/linkage.h>
+#include <linux/ipipe_base.h>
=20
 #ifdef CONFIG_DEBUG_PREEMPT
   extern void fastcall add_preempt_count(int val);
@@ -26,52 +27,40 @@
=20
 asmlinkage void preempt_schedule(void);
=20
-#ifdef CONFIG_IPIPE
-#include <asm/ipipe.h>
-DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
-extern struct ipipe_domain ipipe_root;
-#define ipipe_preempt_guard() (per_cpu(ipipe_percpu_domain, ipipe_proces=
sor_id()) =3D=3D &ipipe_root)
-#else  /* !CONFIG_IPIPE */
-#define ipipe_preempt_guard()	1
-#endif /* CONFIG_IPIPE */
-
-#define preempt_disable()						\
-do {									\
-	if (ipipe_preempt_guard()) {					\
-		inc_preempt_count();					\
-		barrier();						\
-	}								\
+#define preempt_disable() \
+do { \
+	ipipe_check_context(ipipe_root_domain); \
+	inc_preempt_count(); \
+	barrier(); \
 } while (0)
=20
-#define preempt_enable_no_resched()					\
-do {									\
-	if (ipipe_preempt_guard()) {					\
-		barrier();						\
-		dec_preempt_count();					\
-	}								\
+#define preempt_enable_no_resched() \
+do { \
+	ipipe_check_context(ipipe_root_domain); \
+	barrier(); \
+	dec_preempt_count(); \
 } while (0)
=20
-#define preempt_check_resched()						\
-do {									\
-	if (ipipe_preempt_guard()) {					\
-		if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))	\
-			preempt_schedule();				\
-	}								\
+#define preempt_check_resched() \
+do { \
+	ipipe_check_context(ipipe_root_domain); \
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
+		preempt_schedule(); \
 } while (0)
=20
-#define preempt_enable()						\
-do {									\
-	preempt_enable_no_resched();					\
+#define preempt_enable() \
+do { \
+	preempt_enable_no_resched(); \
 	barrier(); \
-	preempt_check_resched();					\
+	preempt_check_resched(); \
 } while (0)
=20
 #else
=20
-#define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do { } while (0)
-#define preempt_enable()		do { } while (0)
-#define preempt_check_resched()		do { } while (0)
+#define preempt_disable()		ipipe_check_context(ipipe_root_domain)
+#define preempt_enable_no_resched()	ipipe_check_context(ipipe_root_domai=
n)
+#define preempt_enable()		ipipe_check_context(ipipe_root_domain)
+#define preempt_check_resched()		ipipe_check_context(ipipe_root_domain)
=20
 #endif
=20
Index: linux-2.6.20/kernel/ipipe/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/Kconfig.debug
+++ linux-2.6.20/kernel/ipipe/Kconfig.debug
@@ -2,6 +2,15 @@ config IPIPE_DEBUG
 	bool "I-pipe debugging"
 	depends on IPIPE
=20
+config IPIPE_DEBUG_CONTEXT
+	bool "Check for illicit cross-domain calls"
+	depends on IPIPE_DEBUG
+	---help---
+	  Enable this feature to arm checkpoints in the kernel that
+	  verify the correct invocation context. On entry of critical
+	  Linux services a warning is issued if the caller is not
+	  running over the root domain.
+
 config IPIPE_TRACE
 	bool "Latency tracing"
 	depends on IPIPE_DEBUG
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -33,6 +33,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #endif	/* CONFIG_PROC_FS */
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+#include <linux/ipipe_trace.h>
+#endif	/* CONFIG_IPIPE_TRACE_MCOUNT */
=20
 static int __ipipe_ptd_key_count;
=20
@@ -1383,6 +1386,34 @@ void __init ipipe_init_proc(void)
=20
 #endif	/* CONFIG_PROC_FS */
=20
+#ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+void ipipe_check_context(struct ipipe_domain *border_ipd)
+{
+	static int check_hit;
+
+	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority) ||=

+	    check_hit)
+		return;
+
+	check_hit =3D 1;
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ipipe_trace_panic_freeze();
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+	ipipe_set_printk_sync(ipipe_current_domain);
+	printk(KERN_ERR "I-pipe: Detected illicit call from domain '%s'\n"
+	       KERN_ERR "        into a service reserved for domain '%s' and "
+			"below.\n",
+	       ipipe_current_domain->name, border_ipd->name);
+	show_stack(NULL, NULL);
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+	ipipe_trace_panic_dump();
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
+}
+
+EXPORT_SYMBOL(ipipe_check_context);
+#endif /* CONFIG_IPIPE_DEBUG_CONTEXT */
+
 EXPORT_SYMBOL(ipipe_virtualize_irq);
 EXPORT_SYMBOL(ipipe_control_irq);
 EXPORT_SYMBOL(ipipe_suspend_domain);

--------------080205060601010201000402--

--------------enigE95E804A4B5C625365A9DDF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMc6uniDOoMHTA+kRAsceAJ9qeQcc7wE4znmUrLWpB9nOrVtwawCeOpiG
hiy2F5aqjgEiWcB5J0OKdgI=
=CMHS
-----END PGP SIGNATURE-----

--------------enigE95E804A4B5C625365A9DDF4--

