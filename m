Message-ID: <b647ffbd0602270656m4719d6aes@domain.hid>
Date: Mon, 27 Feb 2006 16:56:23 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3666_8387271.1141052183620"
Subject: [Xenomai-core] [PATCH] Shared interrupts (yet another movie :)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_3666_8387271.1141052183620
Content-Type: multipart/alternative; 
	boundary="----=_Part_3667_2695455.1141052183620"

------=_Part_3667_2695455.1141052183620
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

I have explicitly cc'ed Gilles as this patch affects the posix skin.

In the light of the recent discussions, the AUTOENA flag has been converted
to NOAUTOENA and the IRQ line is re-enabled on return from
xnintr_irq_handler() and shirq brothers by default.
Also XN_ISR_CHAINED -> XN_ISR_PROPAGATE.

I'm still not sutisfied with results, namely - return values of ISR. But,
well, this is a quite separate question to the shirq support so the later
one should not remain in pending status only because of that.

I still would like to see something along scalar values : NONE, HANDLED,
PROPAGATE and xnintr_disable() being called in ISR to defer IRQ line
enabling (not .ending -> PROPAGATE does it).
(*)

Currently, there is a XN_ISR_NOENABLE bit which asks the real-time layer to
defer the IRQ line, Warning!, .ending (and not just enabling) until later.
In common case, xnarch_end_irq() must be called by the rt_task that stands
for a bottom half (and not just xnintr_enable() - this may not work on ppc)=
.
This adds a bit of confusion and we will avoid it with (*) scheme. So this
is a subject to change in the future.
As I pointed out in another message, the implementation for PPC is not yet
clear at the moment. That's it...

Ok, are there any objections as to the current patch? If no, please apply.

CHANGELOG.patch is here
https://mail.gna.org/public/xenomai-core/2006-02/msg00154.html

--
Best regards,
Dmitry Adamushko

------=_Part_3667_2695455.1141052183620
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi there,<br>
<br>
I have explicitly cc'ed Gilles as this patch affects the posix skin.<br>
<br>
In the light of the recent discussions, the AUTOENA flag has been
converted to NOAUTOENA and the IRQ line is re-enabled on return from
xnintr_irq_handler() and shirq brothers by default.<br>
Also XN_ISR_CHAINED -&gt; XN_ISR_PROPAGATE.<br>
<br>
I'm still not sutisfied with results, namely - return values of ISR.
But, well, this is a quite separate question to the shirq support so
the later one should not remain in pending status only because of that.<br>
<br>
I still would like to see something along scalar values : NONE,
HANDLED, PROPAGATE and xnintr_disable() being called in ISR to defer
IRQ line enabling (not .ending -&gt; PROPAGATE does it).<br>
(*)<br>
<br>
Currently, there is a XN_ISR_NOENABLE bit which asks the real-time
layer to defer the IRQ line, Warning!, .ending (and not just enabling)
until later. In common case, xnarch_end_irq() must be called by the
rt_task that stands for a bottom half (and not just xnintr_enable() -
this may not work on ppc).<br>
This adds a bit of confusion and we will avoid it with (*) scheme. So this =
is a subject to change in the future.<br>
As I pointed out in another message, the implementation for PPC is not yet =
clear at the moment. That's it...<br>
<br>
Ok, are there any objections as to the current patch? If no, please apply.<=
br>
<br>
CHANGELOG.patch is here <a href=3D"https://mail.gna.org/public/xenomai-core=
/2006-02/msg00154.html">https://mail.gna.org/public/xenomai-core/2006-02/ms=
g00154.html</a><br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_3667_2695455.1141052183620--

------=_Part_3666_8387271.1141052183620
Content-Type: application/octet-stream; name=shirq-combo.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0fwys1
Content-Disposition: attachment; filename="shirq-combo.patch"

diff -urp xenomai-CVS/include/asm-generic/hal.h xenomai/include/asm-generic/hal.h
--- xenomai-CVS/include/asm-generic/hal.h	2006-02-02 12:17:23.000000000 +0100
+++ xenomai/include/asm-generic/hal.h	2006-02-27 14:42:59.000000000 +0100
@@ -64,6 +64,11 @@
 #define RTHAL_NR_CPUS		IPIPE_NR_CPUS
 #define RTHAL_ROOT_PRIO		IPIPE_ROOT_PRIO
 #define RTHAL_NR_FAULTS		IPIPE_NR_FAULTS
+#define RTHAL_NR_IRQS		IPIPE_NR_IRQS
+#define RTHAL_VIRQ_BASE		IPIPE_VIRQ_BASE
+
+#define rthal_virtual_irq_p(irq)	((irq) >= RTHAL_VIRQ_BASE && \
+					(irq) < RTHAL_NR_IRQS)
 
 #define RTHAL_SERVICE_IPI0	IPIPE_SERVICE_IPI0
 #define RTHAL_SERVICE_VECTOR0	IPIPE_SERVICE_VECTOR0
diff -urp xenomai-CVS/include/asm-generic/system.h xenomai/include/asm-generic/system.h
--- xenomai-CVS/include/asm-generic/system.h	2006-02-11 20:04:23.000000000 +0100
+++ xenomai/include/asm-generic/system.h	2006-02-27 14:42:59.000000000 +0100
@@ -109,6 +109,8 @@ typedef struct { volatile unsigned long 
 
 #define XNARCH_NR_CPUS               RTHAL_NR_CPUS
 
+#define XNARCH_TIMER_IRQ	     RTHAL_TIMER_IRQ
+
 #define XNARCH_ROOT_STACKSZ   0	/* Only a placeholder -- no stack */
 
 #define XNARCH_PROMPT "Xenomai: "
diff -urp xenomai-CVS/include/asm-i386/hal.h xenomai/include/asm-i386/hal.h
--- xenomai-CVS/include/asm-i386/hal.h	2006-02-04 17:43:38.000000000 +0100
+++ xenomai/include/asm-i386/hal.h	2006-02-27 14:42:59.000000000 +0100
@@ -141,6 +141,9 @@ static inline __attribute_const__ unsign
 #define RTHAL_APIC_TIMER_VECTOR    RTHAL_SERVICE_VECTOR3
 #define RTHAL_APIC_TIMER_IPI       RTHAL_SERVICE_IPI3
 #define RTHAL_APIC_ICOUNT          ((RTHAL_TIMER_FREQ + HZ/2)/HZ)
+#define RTHAL_TIMER_IRQ 	   RTHAL_APIC_TIMER_IPI
+#else  /* !CONFIG_X86_LOCAL_APIC */
+#define RTHAL_TIMER_IRQ		   RTHAL_8254_IRQ
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #define RTHAL_NMICLK_FREQ	RTHAL_CPU_FREQ
diff -urp xenomai-CVS/include/asm-sim/system.h xenomai/include/asm-sim/system.h
--- xenomai-CVS/include/asm-sim/system.h	2006-02-22 18:29:40.000000000 +0100
+++ xenomai/include/asm-sim/system.h	2006-02-27 14:42:59.000000000 +0100
@@ -75,6 +75,9 @@ typedef unsigned long xnlock_t;
 
 #define XNARCH_NR_CPUS              1
 
+/* Should be equal to the value used for creating the mvmtimer object (mvm_start_timer). */
+#define XNARCH_TIMER_IRQ	    1
+
 #define XNARCH_DEFAULT_TICK         10000000 /* ns, i.e. 10ms */
 #define XNARCH_HOST_TICK            0 /* No host ticking service. */
 
diff -urp xenomai-CVS/include/asm-uvm/system.h xenomai/include/asm-uvm/system.h
--- xenomai-CVS/include/asm-uvm/system.h	2006-02-25 13:13:57.000000000 +0100
+++ xenomai/include/asm-uvm/system.h	2006-02-27 14:42:59.000000000 +0100
@@ -74,6 +74,8 @@ typedef unsigned long xnlock_t;
 
 #define XNARCH_NR_CPUS             1
 
+#define XNARCH_TIMER_IRQ	   0
+
 #define XNARCH_DEFAULT_TICK        1000000 /* ns, i.e. 1ms */
 #define XNARCH_SIG_RESTART         SIGUSR1
 #define XNARCH_HOST_TICK           0	/* No host ticking service */
diff -urp xenomai-CVS/include/native/intr.h xenomai/include/native/intr.h
--- xenomai-CVS/include/native/intr.h	2006-02-26 20:20:18.000000000 +0100
+++ xenomai/include/native/intr.h	2006-02-27 14:42:59.000000000 +0100
@@ -27,9 +27,9 @@
 #include <native/types.h>
 
 /* Creation flag. */
-#define I_AUTOENA    XN_ISR_ENABLE /* Auto-enable interrupt channel
-				      after each IRQ. */
-#define I_PROPAGATE  XN_ISR_CHAINED /* Propagate IRQs down the
+#define I_NOAUTOENA  XN_ISR_NOENABLE  /* Do not auto-enable interrupt channel
+				        after each IRQ. */
+#define I_PROPAGATE  XN_ISR_PROPAGATE /* Propagate IRQs down the
 				       pipeline after processing; IOW,
 				       pass them to Linux. */
 typedef struct rt_intr_info {
@@ -50,9 +50,14 @@ typedef struct rt_intr_placeholder {
 
 #define XENO_INTR_MAGIC 0x55550a0a
 
-#define RT_INTR_HANDLED XN_ISR_HANDLED
-#define RT_INTR_CHAINED XN_ISR_CHAINED
-#define RT_INTR_ENABLE  XN_ISR_ENABLE
+/* Creation flags. */
+#define I_SHARED	XN_ISR_SHARED
+#define I_EDGE		XN_ISR_EDGE
+
+#define RT_INTR_HANDLED		XN_ISR_HANDLED
+#define RT_INTR_NONE		XN_ISR_NONE
+#define RT_INTR_PROPAGATE	XN_ISR_PROPAGATE
+#define RT_INTR_NOENABLE	XN_ISR_NOENABLE
 
 #define I_DESC(xintr)  ((RT_INTR *)(xintr)->cookie)
 
@@ -81,7 +86,7 @@ typedef struct rt_intr {
 
     xnsynch_t synch_base; /* !< Base synchronization object. */
 
-    pid_t cpid;			/* !< Creator's pid. */
+    pid_t cpid;		/* !< Creator's pid. */
 
 #endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */
 
@@ -101,9 +106,11 @@ int __native_intr_pkg_init(void);
 void __native_intr_pkg_cleanup(void);
 
 int rt_intr_create(RT_INTR *intr,
+		   const char *name,
 		   unsigned irq,
 		   rt_isr_t isr,
-		   rt_iack_t iack);
+		   rt_iack_t iack,
+		   int mode);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 int rt_intr_handler(xnintr_t *cookie);
@@ -122,7 +129,7 @@ extern "C" {
 #endif
 
 int rt_intr_bind(RT_INTR *intr,
-		 unsigned irq,
+		 const char *name,
 		 RTIME timeout);
 
 static inline int rt_intr_unbind (RT_INTR *intr)
@@ -133,6 +140,7 @@ static inline int rt_intr_unbind (RT_INT
 }
 
 int rt_intr_create(RT_INTR *intr,
+		   const char *name,
 		   unsigned irq,
 		   int mode);
 
diff -urp xenomai-CVS/include/nucleus/intr.h xenomai/include/nucleus/intr.h
--- xenomai-CVS/include/nucleus/intr.h	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/include/nucleus/intr.h	2006-02-27 14:42:59.000000000 +0100
@@ -22,25 +22,42 @@
 
 #include <nucleus/types.h>
 
-#define XN_ISR_HANDLED   0x0
-#define XN_ISR_CHAINED   0x1
-#define XN_ISR_ENABLE    0x2
+/* Possible return values of ISR. */
+#define XN_ISR_NONE   	 0x1
+#define XN_ISR_HANDLED	 0x2
+/* Additional bits. */
+#define XN_ISR_PROPAGATE 0x100
+#define XN_ISR_NOENABLE  0x200
+#define XN_ISR_BITMASK	 ~0xff
+
+/* Creation flags. */
+#define XN_ISR_SHARED	 0x1
+#define XN_ISR_EDGE	 0x2
 
-#if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__)
+/* Operational flags. */
+#define XN_ISR_ATTACHED	 0x10000
 
-struct xnintr;
+#if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__)
 
 typedef struct xnintr {
 
-    unsigned irq;	/* !< IRQ number. */
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+    struct xnintr *next; /* !< Next object in the IRQ-sharing chain. */
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
     xnisr_t isr;	/* !< Interrupt service routine. */
 
-    xniack_t iack;	/* !< Interrupt acknowledge routine. */
+    void *cookie;	/* !< User-defined cookie value. */
 
     unsigned long hits;	/* !< Number of receipts (since attachment). */
 
-    void *cookie;	/* !< User-defined cookie value. */
+    xnflags_t flags; 	/* !< Creation flags. */
+
+    unsigned irq;	/* !< IRQ number. */
+
+    xniack_t iack;	/* !< Interrupt acknowledge routine. */
+
+    const char *name;	/* !< Symbolic name. */
 
 } xnintr_t;
 
@@ -50,11 +67,16 @@ extern xnintr_t nkclock;
 extern "C" {
 #endif
 
+int xnintr_mount(void);
+
 void xnintr_clock_handler(void);
 
+int xnintr_irq_proc(unsigned int irq, char *str);
+
     /* Public interface. */
 
 int xnintr_init(xnintr_t *intr,
+		const char *name,
 		unsigned irq,
 		xnisr_t isr,
 		xniack_t iack,
diff -urp xenomai-CVS/include/posix/pthread.h xenomai/include/posix/pthread.h
--- xenomai-CVS/include/posix/pthread.h	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/include/posix/pthread.h	2006-02-27 14:42:59.000000000 +0100
@@ -146,8 +146,8 @@ typedef unsigned long pthread_intr_t;
 #define PTHREAD_WARNSW  XNTRAPSW
 #define PTHREAD_PRIMARY XNTHREAD_SPARE1
 
-#define PTHREAD_IAUTOENA    XN_ISR_ENABLE
-#define PTHREAD_IPROPAGATE  XN_ISR_CHAINED
+#define PTHREAD_INOAUTOENA  XN_ISR_NOENABLE
+#define PTHREAD_IPROPAGATE  XN_ISR_PROPAGATE
 
 #define PTHREAD_IENABLE     0
 #define PTHREAD_IDISABLE    1
diff -urp xenomai-CVS/include/rtdm/rtdm_driver.h xenomai/include/rtdm/rtdm_driver.h
--- xenomai-CVS/include/rtdm/rtdm_driver.h	2006-02-17 21:18:50.000000000 +0100
+++ xenomai/include/rtdm/rtdm_driver.h	2006-02-27 14:42:59.000000000 +0100
@@ -693,6 +693,17 @@ typedef unsigned long               rtdm
 
 typedef xnintr_t                    rtdm_irq_t;
 
+/*!
+ * @anchor RTDM_IRQTYPE_xxx   @name RTDM_IRQTYPE_xxx
+ * Interrupt registrations flags
+ * @{
+ */
+/** Enable IRQ-sharing with other real-time drivers */
+#define RTDM_IRQTYPE_SHARED         XN_ISR_SHARED
+/** Additional flag to enable IRQ-sharing of edge-triggered interrupts */
+#define RTDM_IRQTYPE_EDGE	    XN_ISR_EDGE
+/** @} */
+
 /**
  * Interrupt handler
  *
@@ -702,16 +713,19 @@ typedef xnintr_t                    rtdm
  */
 typedef int (*rtdm_irq_handler_t)(rtdm_irq_t *irq_handle);
 
-
 /*!
  * @anchor RTDM_IRQ_xxx   @name RTDM_IRQ_xxx
  * Return flags of interrupt handlers
  * @{
  */
+/** Denote handled interrupt */
+#define RTDM_IRQ_HANDLED	    XN_ISR_HANDLED
+/** Unhandled interrupt */
+#define RTDM_IRQ_NONE		    XN_ISR_NONE
 /** Propagate unhandled interrupt to possible other handlers */
-#define RTDM_IRQ_PROPAGATE          XN_ISR_CHAINED
-/** Re-enable interrupt line on return */
-#define RTDM_IRQ_ENABLE             XN_ISR_ENABLE
+#define RTDM_IRQ_PROPAGATE          XN_ISR_PROPAGATE
+/** Interrupt line is not re-enabled on return */
+#define RTDM_IRQ_NOENABLE           XN_ISR_NOENABLE
 /** @} */
 
 /**
@@ -741,7 +755,7 @@ static inline int rtdm_irq_request(rtdm_
                                    const char *device_name,
                                    void *arg)
 {
-    xnintr_init(irq_handle, irq_no, handler, NULL, flags);
+    xnintr_init(irq_handle, device_name, irq_no, handler, NULL, flags);
     return xnintr_attach(irq_handle, arg);
 }
 
diff -urp xenomai-CVS/ksrc/arch/generic/hal.c xenomai/ksrc/arch/generic/hal.c
--- xenomai-CVS/ksrc/arch/generic/hal.c	2006-02-05 14:16:56.000000000 +0100
+++ xenomai/ksrc/arch/generic/hal.c	2006-02-27 14:42:59.000000000 +0100
@@ -697,45 +697,6 @@ static int hal_read_proc (char *page,
     return len;
 }
 
-static int irq_read_proc (char *page,
-			  char **start,
-			  off_t off,
-			  int count,
-			  int *eof,
-			  void *data)
-{
-    int len = 0, cpu, irq;
-    char *p = page;
-
-    p += sprintf(p,"IRQ ");
-
-    for_each_online_cpu(cpu) {
-	p += sprintf(p,"        CPU%d",cpu);
-    }
-
-    for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
-
-	if (rthal_irq_handler(&rthal_domain, irq) == NULL)
-	    continue;
-
-	p += sprintf(p,"\n%3d:",irq);
-
-	for_each_online_cpu(cpu) {
-	    p += sprintf(p,"%12lu",rthal_cpudata_irq_hits(&rthal_domain,cpu,irq));
-	}
-    }
-
-    p += sprintf(p,"\n");
-
-    len = p - page - off;
-    if (len <= off + count) *eof = 1;
-    *start = page + off;
-    if (len > count) len = count;
-    if (len < 0) len = 0;
-
-    return len;
-}
-
 static int faults_read_proc (char *page,
 			     char **start,
 			     off_t off,
@@ -862,12 +823,6 @@ static int rthal_proc_register (void)
 		  NULL,
 		  rthal_proc_root);
 
-    __rthal_add_proc_leaf("irq",
-		  &irq_read_proc,
-		  NULL,
-		  NULL,
-		  rthal_proc_root);
-
     __rthal_add_proc_leaf("faults",
 		  &faults_read_proc,
 		  NULL,
@@ -890,7 +845,6 @@ static void rthal_proc_unregister (void)
 {
     rthal_nmi_proc_unregister();
     remove_proc_entry("hal",rthal_proc_root);
-    remove_proc_entry("irq",rthal_proc_root);
     remove_proc_entry("faults",rthal_proc_root);
     remove_proc_entry("apc",rthal_proc_root);
     remove_proc_entry("xenomai",NULL);
diff -urp xenomai-CVS/ksrc/drivers/16550A/16550A.c xenomai/ksrc/drivers/16550A/16550A.c
--- xenomai-CVS/ksrc/drivers/16550A/16550A.c	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/ksrc/drivers/16550A/16550A.c	2006-02-27 14:42:59.000000000 +0100
@@ -266,7 +266,7 @@ static int rt_16550_interrupt(rtdm_irq_t
                 events |= RTSER_EVENT_MODEMLO;
         }
 
-        ret = RTDM_IRQ_ENABLE;
+        ret = RTDM_IRQ_ENABLE | RTDM_IRQ_HANDLED;
     }
 
     if (ctx->in_nwait > 0) {
@@ -446,7 +446,8 @@ int rt_16550_open(struct rtdm_dev_contex
     ctx = (struct rt_16550_context *)context->dev_private;
 
     ret = rtdm_irq_request(&ctx->irq_handle, irq[dev_id], rt_16550_interrupt,
-                           0, context->device->proc_name, ctx);
+			    RTDM_IRQTYPE_SHARED|RTDM_IRQTYPE_EDGE,
+			    context->device->proc_name, ctx);
     if (ret < 0)
         return ret;
 
diff -urp xenomai-CVS/ksrc/nucleus/intr.c xenomai/ksrc/nucleus/intr.c
--- xenomai-CVS/ksrc/nucleus/intr.c	2006-02-07 18:42:39.000000000 +0100
+++ xenomai/ksrc/nucleus/intr.c	2006-02-27 14:42:59.000000000 +0100
@@ -41,8 +41,16 @@ xnintr_t nkclock;
 static void xnintr_irq_handler(unsigned irq,
 			       void *cookie);
 
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+
+/* Helper functions. */
+static int xnintr_shirq_attach(xnintr_t *intr, void *cookie);
+static int xnintr_shirq_detach(xnintr_t *intr);
+
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+
 /*! 
- * \fn int xnintr_init (xnintr_t *intr,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
+ * \fn int xnintr_init (xnintr_t *intr,const char *name,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
  *
  * Associates an interrupt object with an IRQ line.
@@ -55,22 +63,36 @@ static void xnintr_irq_handler(unsigned 
  * the interrupted stack context, the rescheduling procedure is
  * locked, and the interrupt source is masked at hardware level. The
  * status value returned by the ISR is then checked for the following
- * bits:
+ * values:
+ *
+ * - XN_ISR_HANDLED indicates that the interrupt request has been fulfilled
+ * by the ISR.
+ *
+ * - XN_ISR_NONE indicates the opposite to XN_ISR_HANDLED. The ISR must always
+ * return this value when it determines that the interrupt request has not been
+ * issued by the dedicated hardware device.
  *
- * - XN_ISR_ENABLE asks the nucleus to re-enable the IRQ line. Over
- * some real-time control layers which mask and acknowledge IRQs, this
- * operation is necessary to revalidate the interrupt channel so that
- * more interrupts can be notified. The presence of such bit in the
- * ISR's return code causes the nucleus to ask the real-time control
- * layer to re-enable the interrupt.
+ * In addition, one of the following bits may be set by the ISR :
  *
- * - XN_ISR_CHAINED tells the nucleus to require the real-time control
+ * NOTE: use these bits with care and only when you do understand their effect
+ * on the system.
+ * The ISR is not encouraged to use these bits in case it shares the IRQ line
+ * with other ISRs in the real-time domain.
+ *
+ * - XN_ISR_PROPAGATE tells the nucleus to require the real-time control
  * layer to forward the IRQ. For instance, this would cause the Adeos
  * control layer to propagate the interrupt down the interrupt
  * pipeline to other Adeos domains, such as Linux. This is the regular
- * way to share interrupts between the nucleus and the host system. At
- * the opposite, RT_INTR_HANDLED can be used instead to indicate that
- * the interrupt request has been fulfilled.
+ * way to share interrupts between the nucleus and the host system.
+ *
+ * - XN_ISR_NOENABLE causes the nucleus to ask the real-time control
+ * layer _not_ to re-enable the IRQ line (read the following section).
+ * xnarch_end_irq() must be called to re-enable the IRQ line later.
+ *
+ * The nucleus re-enables the IRQ line by default. Over some real-time
+ * control layers which mask and acknowledge IRQs, this operation is
+ * necessary to revalidate the interrupt channel so that more interrupts
+ * can be notified.
  *
  * A count of interrupt receipts is tracked into the interrupt
  * descriptor, and reset to zero each time the interrupt object is
@@ -82,6 +104,9 @@ static void xnintr_irq_handler(unsigned 
  * descriptor must always be valid while the object is active
  * therefore it must be allocated in permanent memory.
  *
+ * @param name An ASCII string standing for the symbolic name of the
+ * interrupt object.
+ *
  * @param irq The hardware interrupt channel associated with the
  * interrupt object. This value is architecture-dependent. An
  * interrupt object must then be attached to the hardware interrupt
@@ -102,9 +127,13 @@ static void xnintr_irq_handler(unsigned 
  * the interrupt has been properly acknowledged. If @a iack is NULL,
  * the default routine will be used instead.
  *
- * @param flags A set of creation flags affecting the operation. Since
- * no flags are currently defined, zero should be passed for this
- * parameter.
+ * @param flags A set of creation flags affecting the operation. The
+ * valid flags are:
+ *
+ * - XN_ISR_SHARED enables IRQ-sharing with other interrupt objects.
+ *
+ * - XN_ISR_EDGE is an additional flag need to be set together with XN_ISR_SHARED
+ * to enable IRQ-sharing of edge-triggered interrupts.
  *
  * @return No error condition being defined, 0 is always returned.
  *
@@ -120,6 +149,7 @@ static void xnintr_irq_handler(unsigned 
  */
 
 int xnintr_init (xnintr_t *intr,
+		 const char *name,
 		 unsigned irq,
 		 xnisr_t isr,
 		 xniack_t iack,
@@ -130,6 +160,11 @@ int xnintr_init (xnintr_t *intr,
     intr->iack = iack;
     intr->cookie = NULL;
     intr->hits = 0;
+    intr->name = name;
+    intr->flags = flags;
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+    intr->next = NULL;
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
     return 0;
 }
@@ -164,7 +199,8 @@ int xnintr_init (xnintr_t *intr,
 int xnintr_destroy (xnintr_t *intr)
 
 {
-    return xnintr_detach(intr);
+    xnintr_detach(intr);
+    return 0;
 }
 
 /*! 
@@ -206,7 +242,11 @@ int xnintr_attach (xnintr_t *intr,
 {
     intr->hits = 0;
     intr->cookie = cookie;
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+    return xnintr_shirq_attach(intr,cookie);
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
     return xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 }
 
 /*! 
@@ -241,7 +281,11 @@ int xnintr_attach (xnintr_t *intr,
 int xnintr_detach (xnintr_t *intr)
 
 {
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+    return xnintr_shirq_detach(intr);
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
     return xnarch_release_irq(intr->irq);
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 }
 
 /*! 
@@ -361,11 +405,10 @@ static void xnintr_irq_handler (unsigned
     s = intr->isr(intr);
     ++intr->hits;
 
-    if (s & XN_ISR_ENABLE)
-	xnarch_end_irq(irq);
-
-    if (s & XN_ISR_CHAINED)
+    if (s & XN_ISR_PROPAGATE)
 	xnarch_chain_irq(irq);
+    else if (!(s & XN_ISR_NOENABLE))
+	xnarch_end_irq(irq);
 
     if (--sched->inesting == 0 && xnsched_resched_p())
 	xnpod_schedule();
@@ -385,6 +428,341 @@ static void xnintr_irq_handler (unsigned
 
 /*@}*/
 
+/* Optional support for shared interrupts. */
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+
+typedef struct xnintr_shirq {
+
+    xnintr_t *handlers;
+#ifdef CONFIG_SMP
+    atomic_counter_t active;
+#endif /* CONFIG_SMP */
+
+} xnintr_shirq_t;
+
+static xnintr_shirq_t xnshirqs[RTHAL_NR_IRQS];
+
+#ifdef CONFIG_SMP
+static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq) {
+    xnarch_atomic_inc(&shirq->active);
+}
+
+static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq) {
+    xnarch_atomic_dec(&shirq->active);
+}
+
+static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq) {
+    while (xnarch_atomic_get(&shirq->active))
+	cpu_relax();
+}
+#else /* !CONFIG_SMP */
+static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq) {}
+static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq) {}
+static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq) {}
+#endif /* CONFIG_SMP */
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
+
+/*
+ * Low-level interrupt handler dispatching the user-defined ISRs for
+ * shared interrupts -- Called with interrupts off.
+ */
+
+static void xnintr_shirq_handler (unsigned irq, void *cookie)
+{
+    xnsched_t *sched = xnpod_current_sched();
+    xnintr_shirq_t *shirq = &xnshirqs[irq];
+    xnintr_t *intr;
+    int s = 0;
+
+    xnarch_memory_barrier();
+
+    xnltt_log_event(xeno_ev_ienter,irq);
+
+    ++sched->inesting;
+
+    xnintr_shirq_lock(shirq);
+    intr = shirq->handlers;
+
+    while (intr)
+        {
+	s |= intr->isr(intr) & XN_ISR_BITMASK;
+        ++intr->hits;
+        intr = intr->next;
+        }
+    xnintr_shirq_unlock(shirq);
+
+    --sched->inesting;
+
+    if (s & XN_ISR_PROPAGATE)
+	xnarch_chain_irq(irq);
+    else if (!(s & XN_ISR_NOENABLE))
+	xnarch_end_irq(irq);
+
+    if (sched->inesting == 0 && xnsched_resched_p())
+	xnpod_schedule();
+
+    xnltt_log_event(xeno_ev_iexit,irq);
+}
+
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+
+/*
+ * Low-level interrupt handler dispatching the user-defined ISRs for
+ * shared edge-triggered interrupts -- Called with interrupts off.
+ */
+
+static void xnintr_edge_shirq_handler (unsigned irq, void *cookie)
+{
+    const int MAX_EDGEIRQ_COUNTER = 128;
+
+    xnsched_t *sched = xnpod_current_sched();
+    xnintr_shirq_t *shirq = &xnshirqs[irq];
+    xnintr_t *intr, *end = NULL;
+    int s = 0, counter = 0;
+
+    xnarch_memory_barrier();
+
+    xnltt_log_event(xeno_ev_ienter,irq);
+
+    ++sched->inesting;
+
+    xnintr_shirq_lock(shirq);
+    intr = shirq->handlers;
+
+    while (intr != end)
+	{
+	int ret = intr->isr(intr),
+	    code = ret & ~XN_ISR_BITMASK,
+	    bits = ret & XN_ISR_BITMASK;
+
+	if (code == XN_ISR_HANDLED)
+	    {
+	    ++intr->hits;
+	    end = NULL;
+	    s |= bits;	    
+	    }
+	else if (code == XN_ISR_NONE && end == NULL)
+	    end = intr;
+
+	if (counter++ > MAX_EDGEIRQ_COUNTER)
+	    break;
+
+	if (!(intr = intr->next))
+	    intr = shirq->handlers;
+	}
+
+    xnintr_shirq_unlock(shirq);
+
+    --sched->inesting;
+
+    if (counter > MAX_EDGEIRQ_COUNTER)
+	xnlogerr("xnintr_edge_shirq_handler() : failed to get the IRQ%d line free.\n", irq);
+
+    if (s & XN_ISR_PROPAGATE)
+	xnarch_chain_irq(irq);
+    else if (!(s & XN_ISR_NOENABLE))
+	xnarch_end_irq(irq);
+
+    if (sched->inesting == 0 && xnsched_resched_p())
+	xnpod_schedule();
+
+    xnltt_log_event(xeno_ev_iexit,irq);
+}
+
+#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
+
+static int xnintr_shirq_attach (xnintr_t *intr,
+			        void *cookie)
+{
+    xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
+    xnintr_t *prev, **p = &shirq->handlers;
+    unsigned long flags;
+    int err = 0;
+
+    if (intr->irq >= RTHAL_NR_IRQS)
+	return -EINVAL;
+
+    flags = rthal_critical_enter(NULL);
+
+    if (__testbits(intr->flags,XN_ISR_ATTACHED))
+	{
+	err = -EPERM;
+	goto unlock_and_exit;
+	}
+
+    if ((prev = *p) != NULL)
+	{
+	/* Check on whether the shared mode is allowed. */
+	if (!(prev->flags & intr->flags & XN_ISR_SHARED) || (prev->iack != intr->iack)
+	    || ((prev->flags & XN_ISR_EDGE) != (intr->flags & XN_ISR_EDGE)))
+	    {
+	    err = -EBUSY;
+	    goto unlock_and_exit;
+	    }
+
+	/* Get a position at the end of the list to insert the new element. */
+	while (prev) 
+	    {
+	    p = &prev->next;
+	    prev = *p;
+	    }
+	}
+    else
+	{
+	/* Initialize the corresponding interrupt channel */
+	void (*handler)(unsigned, void *) = &xnintr_irq_handler;
+
+	if (intr->flags & XN_ISR_SHARED)
+	    {
+#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
+	    handler = &xnintr_shirq_handler;
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
+
+#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
+	    if (intr->flags & XN_ISR_EDGE)
+		handler = &xnintr_edge_shirq_handler;
+#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
+	    }
+
+	err = xnarch_hook_irq(intr->irq,handler,intr->iack,intr);
+	if (err)
+	    goto unlock_and_exit;
+	}
+
+    __setbits(intr->flags,XN_ISR_ATTACHED);
+
+    /* Add a given interrupt object. */
+    intr->next = NULL;
+    *p = intr;
+
+unlock_and_exit:
+
+    rthal_critical_exit(flags);
+    return err;
+}
+
+int xnintr_shirq_detach (xnintr_t *intr)
+{
+    xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
+    xnintr_t *e, **p = &shirq->handlers;
+    unsigned long flags;
+    int err = 0;
+
+    if (intr->irq >= RTHAL_NR_IRQS)
+	return -EINVAL;
+
+    flags = rthal_critical_enter(NULL);
+
+    if (!__testbits(intr->flags,XN_ISR_ATTACHED))
+	{
+	rthal_critical_exit(flags);
+	return -EPERM;
+	}
+
+    __clrbits(intr->flags,XN_ISR_ATTACHED);
+
+    while ((e = *p) != NULL)
+	{
+	if (e == intr)
+	    {
+	    /* Remove a given interrupt object from the list. */
+	    *p = e->next;
+
+	    /* Release the IRQ line if this was the last user */
+	    if (shirq->handlers == NULL)
+		err = xnarch_release_irq(intr->irq);
+
+	    rthal_critical_exit(flags);
+
+	    /* The idea here is to keep a detached interrupt object valid as long
+	       as the corresponding irq handler is running. This is one of the requirements
+	       to iterate over the xnintr_shirq_t::handlers list in xnintr_irq_handler()
+	       in a lockless way. */
+
+	    xnintr_shirq_spin(shirq);
+	    return err;
+	    }
+	p = &e->next;
+	}
+
+    rthal_critical_exit(flags);
+
+    xnlogerr("Attempted to detach a non previously attached interrupt object");
+    return err;
+}
+
+int xnintr_mount(void)
+{
+    int i;
+    for (i = 0; i < RTHAL_NR_IRQS; ++i)
+	{
+	xnshirqs[i].handlers = NULL;
+#ifdef CONFIG_SMP
+	atomic_set(&xnshirqs[i].active,0);
+#endif /* CONFIG_SMP */
+	}
+    return 0;
+}
+
+int xnintr_irq_proc(unsigned int irq, char *str)
+{
+    xnintr_shirq_t *shirq;
+    xnintr_t *intr;
+    char *p = str;
+
+    if (rthal_virtual_irq_p(irq))
+	{
+	p += sprintf(p, "         [virtual]");
+	return p - str;
+	}
+    else if (irq == XNARCH_TIMER_IRQ)
+	{
+	p += sprintf(p, "         %s", nkclock.name);
+	return p - str;
+	}
+
+    shirq = &xnshirqs[irq];
+
+    xnintr_shirq_lock(shirq);
+    intr = shirq->handlers;
+
+    if (intr)
+	p += sprintf(p, "        ");
+
+    while (intr)
+	{
+	if (*(intr->name))
+	    p += sprintf(p, " %s,", intr->name);
+
+	intr = intr->next;
+	}
+
+    xnintr_shirq_unlock(shirq);
+
+    if (p != str)
+	--p;
+
+    return p - str;
+}
+
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+
+int xnintr_mount(void)
+{
+    return 0;
+}
+
+int xnintr_irq_proc(unsigned int irq, char *str)
+{
+    return 0;
+}
+
+#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+
 EXPORT_SYMBOL(xnintr_attach);
 EXPORT_SYMBOL(xnintr_destroy);
 EXPORT_SYMBOL(xnintr_detach);
diff -urp xenomai-CVS/ksrc/nucleus/module.c xenomai/ksrc/nucleus/module.c
--- xenomai-CVS/ksrc/nucleus/module.c	2006-02-26 20:20:18.000000000 +0100
+++ xenomai/ksrc/nucleus/module.c	2006-02-27 14:42:59.000000000 +0100
@@ -526,6 +526,48 @@ static int timer_read_proc (char *page,
     return len;
 }
 
+static int irq_read_proc (char *page,
+			  char **start,
+			  off_t off,
+			  int count,
+			  int *eof,
+			  void *data)
+{
+    int len = 0, cpu, irq;
+    char *p = page;
+
+    p += sprintf(p,"IRQ ");
+
+    for_each_online_cpu(cpu) {
+	p += sprintf(p,"        CPU%d",cpu);
+    }
+
+    for (irq = 0; irq < RTHAL_NR_IRQS; irq++) {
+
+	if (rthal_irq_handler(&rthal_domain, irq) == NULL)
+	    continue;
+
+	p += sprintf(p,"\n%3d:",irq);
+
+	for_each_online_cpu(cpu) {
+	    p += sprintf(p,"%12lu",rthal_cpudata_irq_hits(&rthal_domain,cpu,irq));
+	}
+
+	p += xnintr_irq_proc(irq, p); 
+    }
+
+    p += sprintf(p,"\n");
+
+    len = p - page - off;
+    if (len <= off + count) *eof = 1;
+    *start = page + off;
+    if (len > count) len = count;
+    if (len < 0) len = 0;
+
+    return len;
+}
+
+
 static struct proc_dir_entry *add_proc_leaf (const char *name,
 					     read_proc_t rdproc,
 					     write_proc_t wrproc,
@@ -614,6 +656,12 @@ void xnpod_init_proc (void)
 		  NULL,
 		  rthal_proc_root);
 
+    add_proc_leaf("irq",
+		  &irq_read_proc,
+		  NULL,
+		  NULL,
+		  rthal_proc_root);
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
     iface_proc_root = create_proc_entry("interfaces",
 					S_IFDIR,
@@ -633,6 +681,7 @@ void xnpod_delete_proc (void)
 
     remove_proc_entry("interfaces",rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+    remove_proc_entry("irq",rthal_proc_root);
     remove_proc_entry("timer",rthal_proc_root);
     remove_proc_entry("version",rthal_proc_root);
     remove_proc_entry("latency",rthal_proc_root);
@@ -713,6 +762,8 @@ int __init __xeno_sys_init (void)
     xnpod_init_proc();
 #endif /* CONFIG_PROC_FS */
 
+    xnintr_mount();
+
 #ifdef CONFIG_LTT
     xnltt_mount();
 #endif /* CONFIG_LTT */
diff -urp xenomai-CVS/ksrc/nucleus/pod.c xenomai/ksrc/nucleus/pod.c
--- xenomai-CVS/ksrc/nucleus/pod.c	2006-02-27 02:17:16.000000000 +0100
+++ xenomai/ksrc/nucleus/pod.c	2006-02-27 14:43:00.000000000 +0100
@@ -3125,11 +3125,10 @@ unlock_and_exit:
 
     /* The clock interrupt does not need to be attached since the
        timer service will handle the arch-dependent setup. The IRQ
-       number (arg #2) is not used since the IRQ source will be
-       attached directly by the arch-dependent layer
+       source will be attached directly by the arch-dependent layer
        (xnarch_start_timer). */
 
-    xnintr_init(&nkclock,0,tickhandler,NULL,0);
+    xnintr_init(&nkclock,"[timer]",XNARCH_TIMER_IRQ,tickhandler,NULL,0);
 
     __setbits(nkpod->status,XNTIMED);
 
diff -urp xenomai-CVS/ksrc/skins/native/intr.c xenomai/ksrc/skins/native/intr.c
--- xenomai-CVS/ksrc/skins/native/intr.c	2006-02-26 20:20:18.000000000 +0100
+++ xenomai/ksrc/skins/native/intr.c	2006-02-27 14:43:00.000000000 +0100
@@ -120,7 +120,7 @@ static xnpnode_t __intr_pnode = {
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
 /*! 
- * \fn int rt_intr_create (RT_INTR *intr,unsigned irq,rt_isr_t isr,rt_iack_t iack)
+ * \fn int rt_intr_create (RT_INTR *intr,const char *name,unsigned irq,rt_isr_t isr,rt_iack_t iack,int mode)
  * \brief Create an interrupt object from kernel space.
  *
  * Initializes and associates an interrupt object with an IRQ line. In
@@ -156,6 +156,11 @@ static xnpnode_t __intr_pnode = {
  * be valid while the object is active therefore it must be allocated
  * in permanent memory.
  *
+ * @param name An ASCII string standing for the symbolic name of the
+ * interrupt object. When non-NULL and non-empty, this string is copied
+ * to a safe place into the descriptor, and passed to the registry package
+ * if enabled for indexing the created interrupt objects.
+ *
  * @param irq The hardware interrupt channel associated with the
  * interrupt object. This value is architecture-dependent.
  *
@@ -174,6 +179,14 @@ static xnpnode_t __intr_pnode = {
  * the interrupt has been properly acknowledged. If @a iack is NULL,
  * the default routine will be used instead.
  *
+ * @param mode The interrupt object creation mode. The following flags can be
+ * OR'ed into this bitmask, each of them affecting the new interrupt object:
+ *
+ * - I_SHARED enables IRQ-sharing with other interrupt objects.
+ *
+ * - I_EDGE is an additional flag need to be set together with I_SHARED
+ * to enable IRQ-sharing of edge-triggered interrupts.
+ *
  * @return 0 is returned upon success. Otherwise:
  *
  * - -ENOMEM is returned if the system fails to get enough dynamic
@@ -206,9 +219,11 @@ static xnpnode_t __intr_pnode = {
  */
 
 int rt_intr_create (RT_INTR *intr,
+		    const char *name,
 		    unsigned irq,
 		    rt_isr_t isr,
-		    rt_iack_t iack)
+		    rt_iack_t iack,
+		    int mode)
 {
     int err;
     spl_t s;
@@ -216,7 +231,8 @@ int rt_intr_create (RT_INTR *intr,
     if (xnpod_asynch_p())
 	return -EPERM;
 
-    xnintr_init(&intr->intr_base,irq,isr,iack,0);
+    xnintr_init(&intr->intr_base,name,irq,isr,iack,mode);
+    xnobject_copy_name(intr->name,name);
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
     xnsynch_init(&intr->synch_base,XNSYNCH_PRIO);
     intr->pending = 0;
@@ -229,7 +245,6 @@ int rt_intr_create (RT_INTR *intr,
     xnlock_get_irqsave(&nklock,s);
     appendq(&__xeno_intr_q,&intr->link);
     xnlock_put_irqrestore(&nklock,s);
-    snprintf(intr->name,sizeof(intr->name),"irq%u",irq);
 
     err = xnintr_attach(&intr->intr_base,intr);
 
@@ -529,15 +544,15 @@ int rt_intr_inquire (RT_INTR *intr,
  * @param mode The interrupt object creation mode. The following flags
  * can be OR'ed into this bitmask:
  *
- * - I_AUTOENA asks Xenomai to re-enable the IRQ line before awakening
+ * - I_NOAUTOENA asks Xenomai not to re-enable the IRQ line before awakening
  * the interrupt server task. This flag is functionally equivalent as
- * always returning RT_INTR_ENABLE from a kernel space interrupt
+ * always returning RT_INTR_NOENABLE from a kernel space interrupt
  * handler.
  *
  * - I_PROPAGATE asks Xenomai to propagate the IRQ down the pipeline; in
  * other words, the interrupt occurrence is chained to Linux after it
  * has been processed by the Xenomai task. This flag is functionally
- * equivalent as always returning RT_INTR_CHAINED from a kernel space
+ * equivalent as always returning RT_INTR_PROPAGATE from a kernel space
  * interrupt handler.
  *
  * @return 0 is returned upon success. Otherwise:
diff -urp xenomai-CVS/ksrc/skins/native/snippets/user_irq.c xenomai/ksrc/skins/native/snippets/user_irq.c
--- xenomai-CVS/ksrc/skins/native/snippets/user_irq.c	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/ksrc/skins/native/snippets/user_irq.c	2006-02-27 14:43:00.000000000 +0100
@@ -33,7 +33,7 @@ int main (int argc, char *argv[])
 
     /* ... */
 
-    err = rt_intr_create(&intr_desc,IRQ_NUMBER,I_AUTOENA);
+    err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,0);
 
     /* ... */
 
diff -urp xenomai-CVS/ksrc/skins/native/syscall.c xenomai/ksrc/skins/native/syscall.c
--- xenomai-CVS/ksrc/skins/native/syscall.c	2006-02-26 20:20:18.000000000 +0100
+++ xenomai/ksrc/skins/native/syscall.c	2006-02-27 14:43:00.000000000 +0100
@@ -2863,16 +2863,17 @@ int rt_intr_handler (xnintr_t *cookie)
     if (xnsynch_nsleepers(&intr->synch_base) > 0)
 	xnsynch_flush(&intr->synch_base,0);
 
-    if (intr->mode & XN_ISR_CHAINED)
-	return XN_ISR_CHAINED|(intr->mode & XN_ISR_ENABLE);
+    if (intr->mode & XN_ISR_PROPAGATE)
+	return XN_ISR_PROPAGATE|(intr->mode & XN_ISR_NOENABLE);
 
-    return XN_ISR_HANDLED|(intr->mode & XN_ISR_ENABLE);
+    return XN_ISR_HANDLED|(intr->mode & XN_ISR_NOENABLE);
 }
 
 EXPORT_SYMBOL(rt_intr_handler);
 
 /*
  * int __rt_intr_create(RT_INTR_PLACEHOLDER *ph,
+ *			const char *name,
  *                      unsigned irq,
  *                      int mode)
  */
@@ -2880,6 +2881,7 @@ EXPORT_SYMBOL(rt_intr_handler);
 static int __rt_intr_create (struct task_struct *curr, struct pt_regs *regs)
 
 {
+    char name[XNOBJECT_NAME_LEN];
     RT_INTR_PLACEHOLDER ph;
     int err, mode;
     RT_INTR *intr;
@@ -2888,13 +2890,24 @@ static int __rt_intr_create (struct task
     if (!__xn_access_ok(curr,VERIFY_WRITE,__xn_reg_arg1(regs),sizeof(ph)))
 	return -EFAULT;
 
+    if (__xn_reg_arg2(regs))
+	{
+	if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),sizeof(name)))
+	    return -EFAULT;
+
+	__xn_strncpy_from_user(curr,name,(const char __user *)__xn_reg_arg2(regs),sizeof(name) - 1);
+	name[sizeof(name) - 1] = '\0';
+	}
+    else
+	*name = '\0';
+
     /* Interrupt line number. */
-    irq = (unsigned)__xn_reg_arg2(regs);
+    irq = (unsigned)__xn_reg_arg3(regs);
 
     /* Interrupt control mode. */
-    mode = (int)__xn_reg_arg3(regs);
+    mode = (int)__xn_reg_arg4(regs);
 
-    if (mode & ~(I_AUTOENA|I_PROPAGATE))
+    if (mode & ~(I_NOAUTOENA|I_PROPAGATE))
 	return -EINVAL;
 
     intr = (RT_INTR *)xnmalloc(sizeof(*intr));
@@ -2902,7 +2915,7 @@ static int __rt_intr_create (struct task
     if (!intr)
 	return -ENOMEM;
 
-    err = rt_intr_create(intr,irq,&rt_intr_handler,NULL);
+    err = rt_intr_create(intr,name,irq,&rt_intr_handler,NULL,0);
 
     if (err == 0)
 	{
diff -urp xenomai-CVS/ksrc/skins/posix/intr.c xenomai/ksrc/skins/posix/intr.c
--- xenomai-CVS/ksrc/skins/posix/intr.c	2006-01-03 21:41:36.000000000 +0100
+++ xenomai/ksrc/skins/posix/intr.c	2006-02-27 14:43:00.000000000 +0100
@@ -27,7 +27,7 @@ int pse51_intr_attach (struct pse51_inte
     int err;
     spl_t s;
 
-    xnintr_init(&intr->intr_base,irq,isr,iack,0);
+    xnintr_init(&intr->intr_base,NULL,irq,isr,iack,0);
 
 #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
     xnsynch_init(&intr->synch_base,XNSYNCH_PRIO);
diff -urp xenomai-CVS/ksrc/skins/posix/intr.h xenomai/ksrc/skins/posix/intr.h
--- xenomai-CVS/ksrc/skins/posix/intr.h	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/ksrc/skins/posix/intr.h	2006-02-27 14:43:00.000000000 +0100
@@ -21,8 +21,8 @@
 #include <nucleus/synch.h>
 #include <nucleus/intr.h>
 
-#define PTHREAD_IAUTOENA    XN_ISR_ENABLE
-#define PTHREAD_IPROPAGATE  XN_ISR_CHAINED
+#define PTHREAD_INOAUTOENA  XN_ISR_NOENABLE
+#define PTHREAD_IPROPAGATE  XN_ISR_PROPAGATE
 
 #define PTHREAD_IENABLE     0
 #define PTHREAD_IDISABLE    1
diff -urp xenomai-CVS/ksrc/skins/posix/syscall.c xenomai/ksrc/skins/posix/syscall.c
--- xenomai-CVS/ksrc/skins/posix/syscall.c	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/ksrc/skins/posix/syscall.c	2006-02-27 14:43:00.000000000 +0100
@@ -1487,10 +1487,10 @@ static int __pse51_intr_handler (xnintr_
     if (xnsynch_nsleepers(&intr->synch_base) > 0)
         xnsynch_flush(&intr->synch_base,0);
 
-    if (intr->mode & XN_ISR_CHAINED)
-        return XN_ISR_CHAINED|(intr->mode & XN_ISR_ENABLE);
+    if (intr->mode & XN_ISR_PROPAGATE)
+        return XN_ISR_PROPAGATE|(intr->mode & XN_ISR_NOENABLE);
 
-    return XN_ISR_HANDLED|(intr->mode & XN_ISR_ENABLE);
+    return XN_ISR_HANDLED|(intr->mode & XN_ISR_NOENABLE);
 }
 
 int __intr_attach (struct task_struct *curr, struct pt_regs *regs)
@@ -1509,7 +1509,7 @@ int __intr_attach (struct task_struct *c
     /* Interrupt control mode. */
     mode = (int)__xn_reg_arg3(regs);
 
-    if (mode & ~(XN_ISR_ENABLE|XN_ISR_CHAINED))
+    if (mode & ~(XN_ISR_NOENABLE|XN_ISR_PROPAGATE))
         return -EINVAL;
 
     intr = (struct pse51_interrupt *)xnmalloc(sizeof(*intr));
diff -urp xenomai-CVS/ksrc/skins/rtdm/drvlib.c xenomai/ksrc/skins/rtdm/drvlib.c
--- xenomai-CVS/ksrc/skins/rtdm/drvlib.c	2006-02-26 20:25:27.000000000 +0100
+++ xenomai/ksrc/skins/rtdm/drvlib.c	2006-02-27 14:43:00.000000000 +0100
@@ -1202,7 +1202,7 @@ EXPORT_SYMBOL(rtdm_mutex_unlock);
  * @param[in,out] irq_handle IRQ handle
  * @param[in] irq_no Line number of the addressed IRQ
  * @param[in] handler Interrupt handler
- * @param[in] flags Currently unused, pass 0
+ * @param[in] flags Registration flags, see @ref RTDM_IRQTYPE_xxx for details
  * @param[in] device_name Optional device name to show up in real-time IRQ
  * lists (not yet implemented)
  * @param[in] arg Pointer to be passed to the interrupt handler on invocation
diff -urp xenomai-CVS/src/skins/native/intr.c xenomai/src/skins/native/intr.c
--- xenomai-CVS/src/skins/native/intr.c	2006-02-04 13:06:50.000000000 +0100
+++ xenomai/src/skins/native/intr.c	2006-02-27 14:43:00.000000000 +0100
@@ -24,24 +24,22 @@
 extern int __native_muxid;
 
 int rt_intr_create (RT_INTR *intr,
+		    const char *name,
 		    unsigned irq,
 		    int mode)
 {
-    return XENOMAI_SKINCALL3(__native_muxid,
+    return XENOMAI_SKINCALL4(__native_muxid,
 			     __native_intr_create,
 			     intr,
+			     name,
 			     irq,
 			     mode);
 }
 
 int rt_intr_bind (RT_INTR *intr,
-		  unsigned irq,
+		  const char *name,
 		  RTIME timeout)
 {
-    char name[XNOBJECT_NAME_LEN];
-
-    snprintf(name,sizeof(name),"irq%u",irq);
-
     return XENOMAI_SKINCALL3(__native_muxid,
 			     __native_intr_bind,
 			     intr,


------=_Part_3666_8387271.1141052183620
Content-Type: application/octet-stream; name=shirq-KConfig.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0fxeud
Content-Disposition: attachment; filename="shirq-KConfig.patch"

diff -ur nucleus-CVS/Config.in nucleus/Config.in
--- nucleus-CVS/Config.in	2005-11-26 17:08:47.000000000 +0100
+++ nucleus/Config.in	2006-02-27 13:05:07.000000000 +0100
@@ -27,6 +27,13 @@
 		int 'Number of priority levels' CONFIG_XENO_OPT_SCALABLE_PRIOS 256
 	fi
 	endmenu
+
+	mainmenu_option next_comment
+	comment 'Shared interrupts'
+		bool 'Level-triggered interrupts' CONFIG_XENO_OPT_SHIRQ_LEVEL
+		bool 'Edge-triggered interrupts' CONFIG_XENO_OPT_SHIRQ_EDGE
+	endmenu
+
 	if [ "$CONFIG_LTT" != "n" ]; then
 		mainmenu_option next_comment
 		comment 'LTT tracepoints filtering'
diff -ur nucleus-CVS/Kconfig nucleus/Kconfig
--- nucleus-CVS/Kconfig	2005-11-01 23:37:45.000000000 +0100
+++ nucleus/Kconfig	2006-02-27 13:10:50.000000000 +0100
@@ -131,6 +131,30 @@
 
 endmenu
 
+menu "Shared interrupts"
+
+config XENO_OPT_SHIRQ_LEVEL
+	bool "Level-triggered interrupts"
+	default n
+	help
+	
+	Enables support for shared level-triggered interrupts, so that
+	multiple real-time interrupt handlers are allowed to control
+	dedicated hardware devices which are configured to share
+	the same interrupt channel.
+
+config XENO_OPT_SHIRQ_EDGE
+	bool "Edge-triggered interrupts"
+	default n
+	help
+
+	Enables support for shared edge-triggered interrupts, so that
+	multiple real-time interrupt handlers are allowed to control
+	dedicated hardware devices which are configured to share
+	the same interrupt channel.
+
+endmenu
+
 menu "LTT tracepoints filtering"
 
 	depends on LTT


------=_Part_3666_8387271.1141052183620--

