Message-ID: <47CA838D.4070702@domain.hid>
Date: Sun, 02 Mar 2008 11:38:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C51A34.203@domain.hid>
In-Reply-To: <47C51A34.203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDCAF49CD3A4D1A274FCC3D35"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] [PATCH 2/6] Whitespace fixes for asm-generic/system.h
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCAF49CD3A4D1A274FCC3D35
Content-Type: multipart/mixed;
 boundary="------------070205020309070705080107"

This is a multi-part message in MIME format.
--------------070205020309070705080107
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

No functional changes.

--------------070205020309070705080107
Content-Type: text/x-patch;
 name="system-h-whitespace-cleanups.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="system-h-whitespace-cleanups.patch"

---
 include/asm-generic/system.h |  145 +++++++++++++++++++++---------------=
-------
 1 file changed, 73 insertions(+), 72 deletions(-)

Index: b/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-generic/system.h
+++ b/include/asm-generic/system.h
@@ -56,13 +56,13 @@ extern "C" {
=20
 /* Tracer interface */
 #define xnarch_trace_max_begin(v)		rthal_trace_max_begin(v)
-#define xnarch_trace_max_end(v)		rthal_trace_max_end(v)
+#define xnarch_trace_max_end(v)			rthal_trace_max_end(v)
 #define xnarch_trace_max_reset()		rthal_trace_max_reset()
 #define xnarch_trace_user_start()		rthal_trace_user_start()
 #define xnarch_trace_user_stop(v)		rthal_trace_user_stop(v)
-#define xnarch_trace_user_freeze(v, once) 	rthal_trace_user_freeze(v, on=
ce)
+#define xnarch_trace_user_freeze(v, once)	rthal_trace_user_freeze(v, onc=
e)
 #define xnarch_trace_special(id, v)		rthal_trace_special(id, v)
-#define xnarch_trace_special_u64(id, v)	rthal_trace_special_u64(id, v)
+#define xnarch_trace_special_u64(id, v)		rthal_trace_special_u64(id, v)
 #define xnarch_trace_pid(pid, prio)		rthal_trace_pid(pid, prio)
 #define xnarch_trace_panic_freeze()		rthal_trace_panic_freeze()
 #define xnarch_trace_panic_dump()		rthal_trace_panic_dump()
@@ -94,23 +94,23 @@ static inline unsigned xnarch_current_cp
=20
 typedef struct {
=20
-        unsigned long long spin_time;
-        unsigned long long lock_time;
-        const char *file;
-        const char *function;
-        unsigned line;
+	unsigned long long spin_time;
+	unsigned long long lock_time;
+	const char *file;
+	const char *function;
+	unsigned line;
=20
 } xnlockinfo_t;
=20
 typedef struct {
=20
-    atomic_t owner;
-    const char *file;
-    const char *function;
-    unsigned line;
-    int cpu;
-    unsigned long long spin_time;
-    unsigned long long lock_date;
+	atomic_t owner;
+	const char *file;
+	const char *function;
+	unsigned line;
+	int cpu;
+	unsigned long long spin_time;
+	unsigned long long lock_date;
=20
 } xnlock_t;
=20
@@ -194,7 +194,7 @@ static inline void xnlock_dbg_invalid_re
=20
 typedef struct { atomic_t owner; } xnlock_t;
=20
-#define XNARCH_LOCK_UNLOCKED (xnlock_t) { { ~0 } }
+#define XNARCH_LOCK_UNLOCKED		(xnlock_t) { { ~0 } }
=20
 #define XNLOCK_DBG_CONTEXT
 #define XNLOCK_DBG_CONTEXT_ARGS
@@ -215,49 +215,48 @@ static inline void xnlock_dbg_invalid_re
=20
 #endif /* !(CONFIG_SMP && XENO_DEBUG(NUCLEUS)) */
=20
-#define XNARCH_NR_CPUS               RTHAL_NR_CPUS
+#define XNARCH_NR_CPUS			RTHAL_NR_CPUS
=20
-#define XNARCH_NR_IRQS               RTHAL_NR_IRQS
-#define XNARCH_TIMER_IRQ	     RTHAL_TIMER_IRQ
-#define XNARCH_TIMER_DEVICE          RTHAL_TIMER_DEVICE
-#define XNARCH_CLOCK_DEVICE          RTHAL_CLOCK_DEVICE
+#define XNARCH_NR_IRQS			RTHAL_NR_IRQS
+#define XNARCH_TIMER_IRQ		RTHAL_TIMER_IRQ
+#define XNARCH_TIMER_DEVICE		RTHAL_TIMER_DEVICE
+#define XNARCH_CLOCK_DEVICE		RTHAL_CLOCK_DEVICE
=20
-#define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */
+#define XNARCH_ROOT_STACKSZ		0 /* Only a placeholder -- no stack */
=20
 #define XNARCH_PROMPT "Xenomai: "
-#define xnarch_loginfo(fmt,args...)  printk(KERN_INFO XNARCH_PROMPT fmt =
, ##args)
-#define xnarch_logwarn(fmt,args...)  printk(KERN_WARNING XNARCH_PROMPT f=
mt , ##args)
-#define xnarch_logerr(fmt,args...)   printk(KERN_ERR XNARCH_PROMPT fmt ,=
 ##args)
-#define xnarch_printf(fmt,args...)   printk(KERN_INFO XNARCH_PROMPT fmt =
, ##args)
+#define xnarch_loginfo(fmt, args...)	printk(KERN_INFO XNARCH_PROMPT fmt,=
 ##args)
+#define xnarch_logwarn(fmt, args...)	printk(KERN_WARNING XNARCH_PROMPT f=
mt, ##args)
+#define xnarch_logerr(fmt, args...)	printk(KERN_ERR XNARCH_PROMPT fmt, #=
#args)
+#define xnarch_printf(fmt, args...)	printk(KERN_INFO XNARCH_PROMPT fmt, =
##args)
=20
 typedef cpumask_t xnarch_cpumask_t;
=20
 #ifdef CONFIG_SMP
-#define xnarch_cpu_online_map            cpu_online_map
+#define xnarch_cpu_online_map			cpu_online_map
 #else
-#define xnarch_cpu_online_map		 cpumask_of_cpu(0)
+#define xnarch_cpu_online_map			cpumask_of_cpu(0)
 #endif
-#define xnarch_num_online_cpus()          num_online_cpus()
-#define xnarch_cpu_set(cpu, mask)         cpu_set(cpu, (mask))
-#define xnarch_cpu_clear(cpu, mask)       cpu_clear(cpu, (mask))
-#define xnarch_cpus_clear(mask)           cpus_clear(mask)
-#define xnarch_cpu_isset(cpu, mask)       cpu_isset(cpu, (mask))
-#define xnarch_cpus_and(dst, src1, src2)  cpus_and((dst), (src1), (src2)=
)
-#define xnarch_cpus_equal(mask1, mask2)   cpus_equal((mask1), (mask2))
-#define xnarch_cpus_empty(mask)           cpus_empty(mask)
-#define xnarch_cpumask_of_cpu(cpu)        cpumask_of_cpu(cpu)
-#define xnarch_cpu_test_and_set(cpu,mask) cpu_test_and_set(cpu, (mask))
-
-#define xnarch_first_cpu(mask)            first_cpu(mask)
-#define XNARCH_CPU_MASK_ALL               CPU_MASK_ALL
+#define xnarch_num_online_cpus()		num_online_cpus()
+#define xnarch_cpu_set(cpu, mask)		cpu_set(cpu, (mask))
+#define xnarch_cpu_clear(cpu, mask)		cpu_clear(cpu, (mask))
+#define xnarch_cpus_clear(mask)			cpus_clear(mask)
+#define xnarch_cpu_isset(cpu, mask)		cpu_isset(cpu, (mask))
+#define xnarch_cpus_and(dst, src1, src2)	cpus_and((dst), (src1), (src2))=

+#define xnarch_cpus_equal(mask1, mask2)		cpus_equal((mask1), (mask2))
+#define xnarch_cpus_empty(mask)			cpus_empty(mask)
+#define xnarch_cpumask_of_cpu(cpu)		cpumask_of_cpu(cpu)
+#define xnarch_cpu_test_and_set(cpu, mask)	cpu_test_and_set(cpu, (mask))=

+#define xnarch_first_cpu(mask)			first_cpu(mask)
+#define XNARCH_CPU_MASK_ALL			CPU_MASK_ALL
=20
 typedef struct xnarch_heapcb {
=20
-    atomic_t numaps;	/* # of active user-space mappings. */
+	atomic_t numaps;	/* # of active user-space mappings. */
=20
-    int kmflags;	/* Kernel memory flags (0 if vmalloc()). */
+	int kmflags;		/* Kernel memory flags (0 if vmalloc()). */
=20
-    void *heapbase;	/* Shared heap memory base. */
+	void *heapbase;		/* Shared heap memory base. */
=20
 } xnarch_heapcb_t;
=20
@@ -267,7 +266,7 @@ long long xnarch_tsc_to_ns(long long ts)
=20
 static inline long long xnarch_tsc_to_ns_rounded(long long ts)
 {
-    return (xnarch_llimd(ts, 1000000000, RTHAL_CPU_FREQ/2) + 1) / 2;
+	return (xnarch_llimd(ts, 1000000000, RTHAL_CPU_FREQ/2) + 1) / 2;
 }
=20
 long long xnarch_ns_to_tsc(long long ns);
@@ -276,24 +275,26 @@ unsigned long long xnarch_get_cpu_time(v
=20
 static inline unsigned long long xnarch_get_cpu_freq(void)
 {
-    return RTHAL_CPU_FREQ;
+	return RTHAL_CPU_FREQ;
 }
=20
-#define xnarch_halt(emsg) \
-do { \
-    rthal_emergency_console(); \
-    xnarch_logerr("fatal: %s\n",emsg); \
-    show_stack(NULL,NULL);			\
-    xnarch_trace_panic_dump();			\
-    for (;;) cpu_relax();			\
-} while(0)
+#define xnarch_halt(emsg)				\
+	do {						\
+		rthal_emergency_console();		\
+		xnarch_logerr("fatal: %s\n", emsg);	\
+		show_stack(NULL,NULL);			\
+		xnarch_trace_panic_dump();		\
+		for (;;)				\
+			cpu_relax();			\
+	} while(0)
=20
 static inline int xnarch_setimask (int imask)
 {
-    spl_t s;
-    splhigh(s);
-    splexit(!!imask);
-    return !!s;
+	spl_t s;
+
+	splhigh(s);
+	splexit(!!imask);
+	return !!s;
 }
=20
 #ifdef CONFIG_SMP
@@ -306,7 +307,7 @@ static inline int xnarch_setimask (int i
=20
 static inline void xnlock_init (xnlock_t *lock)
 {
-    *lock =3D XNARCH_LOCK_UNLOCKED;
+	*lock =3D XNARCH_LOCK_UNLOCKED;
 }
=20
 #define DECLARE_XNLOCK(lock)		xnlock_t lock
@@ -375,9 +376,9 @@ static inline void xnlock_put_irqrestore
 	rthal_local_irq_restore(flags & 1);
 }
=20
-static inline int xnarch_send_ipi (xnarch_cpumask_t cpumask)
+static inline int xnarch_send_ipi(xnarch_cpumask_t cpumask)
 {
-    return rthal_send_ipi(RTHAL_SERVICE_IPI0, cpumask);
+	return rthal_send_ipi(RTHAL_SERVICE_IPI0, cpumask);
 }
=20
 static inline int xnlock_is_owner(xnlock_t *lock)
@@ -387,14 +388,14 @@ static inline int xnlock_is_owner(xnlock
=20
 #else /* !CONFIG_SMP */
=20
-#define xnlock_init(lock)              do { } while(0)
-#define xnlock_get(lock)               do { } while(0)
-#define xnlock_put(lock)               do { } while(0)
-#define xnlock_get_irqsave(lock,x)     rthal_local_irq_save(x)
-#define xnlock_put_irqrestore(lock,x)  rthal_local_irq_restore(x)
-#define xnlock_clear_irqoff(lock)      rthal_local_irq_disable()
-#define xnlock_clear_irqon(lock)       rthal_local_irq_enable()
-#define xnlock_is_owner(lock)	       1
+#define xnlock_init(lock)		do { } while(0)
+#define xnlock_get(lock)		do { } while(0)
+#define xnlock_put(lock)		do { } while(0)
+#define xnlock_get_irqsave(lock,x)	rthal_local_irq_save(x)
+#define xnlock_put_irqrestore(lock,x)	rthal_local_irq_restore(x)
+#define xnlock_clear_irqoff(lock)	rthal_local_irq_disable()
+#define xnlock_clear_irqon(lock)	rthal_local_irq_enable()
+#define xnlock_is_owner(lock)		1
=20
 #define DECLARE_XNLOCK(lock)
 #define DECLARE_EXTERN_XNLOCK(lock)
@@ -403,7 +404,7 @@ static inline int xnlock_is_owner(xnlock
=20
 static inline int xnarch_send_ipi (xnarch_cpumask_t cpumask)
 {
-    return 0;
+	return 0;
 }
=20
 #endif /* !CONFIG_SMP */
@@ -418,7 +419,7 @@ static inline int xnarch_remap_vm_page(s
 				       unsigned long from,
 				       unsigned long to)
 {
-    return wrap_remap_vm_page(vma,from,to);
+	return wrap_remap_vm_page(vma, from, to);
 }
=20
 static inline int xnarch_remap_io_page_range(struct vm_area_struct *vma,=

@@ -427,7 +428,7 @@ static inline int xnarch_remap_io_page_r
 					     unsigned long size,
 					     pgprot_t prot)
 {
-    return wrap_remap_io_page_range(vma,from,to,size,prot);
+	return wrap_remap_io_page_range(vma, from, to, size, prot);
 }
=20
 #ifndef xnarch_hisyscall_entry

--------------070205020309070705080107--

--------------enigDCAF49CD3A4D1A274FCC3D35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHyoONniDOoMHTA+kRAiAPAJ9P0Pd6FRfKjPCn3qp4j7X7ornPPgCeMeMg
Rzn85meHHjvyQDKW/grbAwk=
=S1CO
-----END PGP SIGNATURE-----

--------------enigDCAF49CD3A4D1A274FCC3D35--

