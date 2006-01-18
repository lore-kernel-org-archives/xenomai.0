Message-ID: <b647ffbd0601180617v38c990f0w@domain.hid>
Date: Wed, 18 Jan 2006 16:17:37 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16193_362179.1137593857084"
Subject: [Xenomai-core] [PATCH] Shared irqs v.5
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

------=_Part_16193_362179.1137593857084
Content-Type: multipart/alternative; 
	boundary="----=_Part_16194_13794728.1137593857084"

------=_Part_16194_13794728.1137593857084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Jan,

as I promised earlier today, here is the patch.

hehe.. more comments later together with other explanations I promised. I
have to go now since I have to make a trip and my bus is leaving in 45
minutes :)

--
Best regards,
Dmitry Adamushko

------=_Part_16194_13794728.1137593857084
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hello Jan,<br>
<br>
as I promised earlier today, here is the patch.<br>
<br>
hehe.. more comments later together with other explanations I promised.
I have to go now since I have to make a trip and my bus is leaving in
45 minutes :)<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_16194_13794728.1137593857084--

------=_Part_16193_362179.1137593857084
Content-Type: application/octet-stream; name=shirq-v4.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq-v4.patch"

diff -urp xenomai-cvs/include/asm-generic/hal.h xenomai/include/asm-generic/hal.h
--- xenomai-cvs/include/asm-generic/hal.h	2006-01-13 15:10:23.000000000 +0100
+++ xenomai/include/asm-generic/hal.h	2006-01-18 12:35:49.000000000 +0100
@@ -62,6 +62,7 @@
 #define RTHAL_NR_CPUS		IPIPE_NR_CPUS
 #define RTHAL_ROOT_PRIO		IPIPE_ROOT_PRIO
 #define RTHAL_NR_FAULTS		IPIPE_NR_FAULTS
+#define RTHAL_NR_IRQS		IPIPE_NR_IRQS
 
 #define RTHAL_SERVICE_IPI0	IPIPE_SERVICE_IPI0
 #define RTHAL_SERVICE_VECTOR0	IPIPE_SERVICE_VECTOR0
diff -urp xenomai-cvs/include/asm-generic/system.h xenomai/include/asm-generic/system.h
--- xenomai-cvs/include/asm-generic/system.h	2006-01-03 19:53:37.000000000 +0100
+++ xenomai/include/asm-generic/system.h	2006-01-18 12:13:03.000000000 +0100
@@ -470,6 +470,16 @@ static inline unsigned long long xnarch_
 
 #ifdef XENO_INTR_MODULE
 
+#define XNARCH_NR_IRQS		     RTHAL_NR_IRQS
+
+static inline unsigned long xnarch_critical_enter(void (*synch)(void)) {
+    return rthal_critical_enter(synch);
+}
+
+static inline void xnarch_critical_exit(unsigned long flags) {
+    return rthal_critical_exit(flags);
+}
+
 static inline int xnarch_hook_irq (unsigned irq,
 				   rthal_irq_handler_t handler,
 				   rthal_irq_ackfn_t ackfn,
diff -urp xenomai-cvs/include/asm-sim/system.h xenomai/include/asm-sim/system.h
--- xenomai-cvs/include/asm-sim/system.h	2006-01-03 19:53:37.000000000 +0100
+++ xenomai/include/asm-sim/system.h	2006-01-18 12:30:17.000000000 +0100
@@ -365,6 +365,16 @@ void mvm_tcl_build_pendq(mvm_tcl_listobj
 typedef void (*rthal_irq_handler_t)(unsigned, void *);
 typedef int (*rthal_irq_ackfn_t)(unsigned);
 
+#define XNARCH_NR_IRQS		     MVM_IRQ_LEVELS
+
+static inline unsigned long xnarch_critical_enter(void (*synch)(void)) {
+    return 0;
+}
+
+static inline void xnarch_critical_exit(unsigned long flags) {
+    return;
+}
+
 static inline int xnarch_hook_irq (unsigned irq,
 				   rthal_irq_handler_t handler,
 				   rthal_irq_ackfn_t ackfn, /* Ignored. */
diff -urp xenomai-cvs/include/asm-uvm/system.h xenomai/include/asm-uvm/system.h
--- xenomai-cvs/include/asm-uvm/system.h	2006-01-08 15:35:54.000000000 +0100
+++ xenomai/include/asm-uvm/system.h	2006-01-18 12:17:18.000000000 +0100
@@ -270,6 +270,16 @@ void xnarch_sync_irq (void) /* Synchroni
 typedef void (*rthal_irq_handler_t)(unsigned, void *);
 typedef int (*rthal_irq_ackfn_t)(unsigned);
 
+#define XNARCH_NR_IRQS		     0
+
+static inline unsigned long xnarch_critical_enter(void (*synch)(void)) {
+    return 0;
+}
+
+static inline void xnarch_critical_exit(unsigned long flags) {
+    return;
+}
+
 static inline int xnarch_hook_irq (unsigned irq,
 				   rthal_irq_handler_t handler,
 				   rthal_irq_ackfn_t ackfn,
diff -urp xenomai-cvs/include/nucleus/intr.h xenomai/include/nucleus/intr.h
--- xenomai-cvs/include/nucleus/intr.h	2005-11-01 23:37:45.000000000 +0100
+++ xenomai/include/nucleus/intr.h	2006-01-18 15:32:09.000000000 +0100
@@ -26,21 +26,31 @@
 #define XN_ISR_CHAINED   0x1
 #define XN_ISR_ENABLE    0x2
 
+/* Creation flags. */
+#define XN_ISR_SHARED	 0x1
+
+/* Operational flags. */
+#define XN_ISR_ATTACHED	 0x100
+
 #if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__)
 
 struct xnintr;
 
 typedef struct xnintr {
 
-    unsigned irq;	/* !< IRQ number. */
+    struct xnintr *next;
 
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
 
 } xnintr_t;
 
@@ -50,6 +60,8 @@ extern xnintr_t nkclock;
 extern "C" {
 #endif
 
+int xnintr_mount(void);
+
 void xnintr_clock_handler(void);
 
     /* Public interface. */
Only in xenomai/include/nucleus: shirq-3_intr.h.patch
diff -urp xenomai-cvs/ksrc/nucleus/intr.c xenomai/ksrc/nucleus/intr.c
--- xenomai-cvs/ksrc/nucleus/intr.c	2005-12-02 19:56:20.000000000 +0100
+++ xenomai/ksrc/nucleus/intr.c	2006-01-18 15:32:56.000000000 +0100
@@ -41,6 +41,60 @@ xnintr_t nkclock;
 static void xnintr_irq_handler(unsigned irq,
 			       void *cookie);
 
+static void xnintr_shirq_handler(unsigned irq,
+			       void *cookie);
+
+typedef struct xnintr_shirq {
+
+    xnintr_t *handlers;
+    
+#ifdef CONFIG_SMP
+    atomic_counter_t active;
+#endif /* CONFIG_SMP */
+
+} xnintr_shirq_t;
+
+static xnintr_shirq_t xnshirqs[XNARCH_NR_IRQS];
+
+#ifdef CONFIG_SMP
+
+static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq)
+{
+    xnarch_atomic_inc(&shirq->active);
+}
+
+static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
+{
+    xnarch_atomic_dec(&shirq->active);
+}
+
+static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq)
+{
+    while (xnarch_atomic_get(&shirq->active))
+	cpu_relax();
+}
+
+#else /* !CONFIG_SMP */
+
+static inline void xnintr_shirq_lock(xnintr_shirq_t *shirq) {}
+static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq) {}
+static inline void xnintr_shirq_spin(xnintr_shirq_t *shirq) {}
+
+#endif /* CONFIG_SMP */
+
+int xnintr_mount(void)
+{
+    int i;
+    for (i = 0; i < XNARCH_NR_IRQS; ++i)
+	{
+	xnshirqs[i].handlers = NULL;
+#ifdef CONFIG_SMP
+	atomic_set(&xnshirqs[i].active,0);
+#endif /* CONFIG_SMP */
+	}
+    return 0;
+}
+
 /*! 
  * \fn int xnintr_init (xnintr_t *intr,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
@@ -130,6 +184,8 @@ int xnintr_init (xnintr_t *intr,
     intr->iack = iack;
     intr->cookie = NULL;
     intr->hits = 0;
+    intr->flags = flags;
+    intr->next = NULL;
 
     return 0;
 }
@@ -164,7 +220,8 @@ int xnintr_init (xnintr_t *intr,
 int xnintr_destroy (xnintr_t *intr)
 
 {
-    return xnintr_detach(intr);
+    xnintr_detach(intr);
+    return 0;
 }
 
 /*! 
@@ -181,8 +238,7 @@ int xnintr_destroy (xnintr_t *intr)
  *
  * @param cookie A user-defined opaque value which is stored into the
  * interrupt object descriptor for further retrieval by the ISR/ISR
- * handlers.
- *
+ * handlers. *
  * @return 0 is returned on success. Otherwise, -EINVAL is returned if
  * a low-level error occurred while attaching the interrupt. -EBUSY is
  * specifically returned if the interrupt object was already attached.
@@ -204,11 +260,64 @@ int xnintr_destroy (xnintr_t *intr)
 int xnintr_attach (xnintr_t *intr,
 		   void *cookie)
 {
+    xnintr_shirq_t *shirq;
+    xnintr_t *prev, **p;
+    unsigned long flags;
+    int err = 0;
+
+    if (intr->irq >= XNARCH_NR_IRQS)
+	return -EINVAL;
+
     intr->hits = 0;
+    intr->next = NULL;
     intr->cookie = cookie;
-    return xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
+    shirq = &xnshirqs[intr->irq];
+
+    flags = xnarch_critical_enter(NULL);
+
+    if (test_and_set_bit(XN_ISR_ATTACHED,&intr->flags))
+	{
+	err = -EPERM;
+	goto unlock_and_exit;
+	}
+
+    p = &shirq->handlers;
+
+    if ((prev = *p) != NULL)
+	{
+	/* Check on whether the shared mode is allowed. */
+	if (!(prev->flags & intr->flags & XN_ISR_SHARED) || (prev->iack != intr->iack))
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
+	err = xnarch_hook_irq(intr->irq,&xnintr_shirq_handler,intr->iack,NULL);
+	if (err)
+	    goto unlock_and_exit;
+	}
+
+    /* Add a given interrupt object. */
+    *p = intr;
+
+unlock_and_exit:
+
+    xnarch_critical_exit(flags);
+    return err;
+
 }
 
+
 /*! 
  * \fn int xnintr_detach (xnintr_t *intr)
  * \brief Detach an interrupt object.
@@ -241,7 +350,51 @@ int xnintr_attach (xnintr_t *intr,
 int xnintr_detach (xnintr_t *intr)
 
 {
-    return xnarch_release_irq(intr->irq);
+    xnintr_shirq_t *shirq;
+    unsigned long flags;
+    xnintr_t *e, **p;
+    int err = 0;
+
+    if (intr->irq >= XNARCH_NR_IRQS)
+	return -EINVAL;
+
+    shirq = &xnshirqs[intr->irq];
+
+    flags = xnarch_critical_enter(NULL);
+
+    if (!test_and_clear_bit(XN_ISR_ATTACHED,&intr->flags))
+	{
+	xnarch_critical_exit(flags);
+	return -EPERM;
+	}
+
+    p = &shirq->handlers;
+
+    while ((e = *p) != NULL)
+	{
+	if (e == intr)
+	    {
+	    /* Remove a given interrupt object from the list. */
+	    if ((*p = e->next) == NULL)
+		err = xnarch_release_irq(intr->irq);
+    
+	    xnarch_critical_exit(flags);
+
+	    /* The idea here is to keep a detached interrupt object valid as long
+	       as the corresponding irq handler is running. This is one of the requirements
+	       to iterate over the xnintr_shirq_t::handlers list in xnintr_irq_handler()
+	       in a lockless way. */
+	    xnintr_shirq_spin(shirq);
+	    return err;
+	    }
+	p = &e->next;
+	}
+
+    xnarch_critical_exit(flags);
+
+    xnlogerr("Attempted to detach a non previously attached interrupt object");
+    return err;
+
 }
 
 /*! 
@@ -384,6 +537,50 @@ static void xnintr_irq_handler (unsigned
     xnltt_log_event(xeno_ev_iexit,irq);
 }
 
+static void xnintr_shirq_handler (unsigned irq, void *cookie)
+
+{
+    xnsched_t *sched = xnpod_current_sched();
+    xnintr_shirq_t *shirq;
+    xnintr_t *intr;
+    int s = 0;
+
+    xnarch_memory_barrier();
+
+    xnltt_log_event(xeno_ev_ienter,irq);
+
+    shirq = &xnshirqs[irq];
+    intr = shirq->handlers;
+
+    ++sched->inesting;
+
+    xnintr_shirq_lock(shirq);
+    
+    while (intr)
+	{
+	s |= intr->isr(intr);
+	++intr->hits;
+
+	intr = intr->next;
+	}
+
+    xnintr_shirq_unlock(shirq);
+
+    --sched->inesting;
+
+    if (s & XN_ISR_ENABLE)
+	xnarch_enable_irq(irq);
+
+    if (s & XN_ISR_CHAINED)
+	xnarch_chain_irq(irq);
+
+    if (sched->inesting == 0 && xnsched_resched_p())
+	xnpod_schedule();
+
+    xnltt_log_event(xeno_ev_iexit,irq);
+}
+
+
 /*@}*/
 
 EXPORT_SYMBOL(xnintr_attach);
diff -urp xenomai-cvs/ksrc/nucleus/module.c xenomai/ksrc/nucleus/module.c
--- xenomai-cvs/ksrc/nucleus/module.c	2005-11-30 10:36:33.000000000 +0100
+++ xenomai/ksrc/nucleus/module.c	2006-01-17 20:42:09.000000000 +0100
@@ -713,6 +713,8 @@ int __init __xeno_sys_init (void)
     xnpod_init_proc();
 #endif /* CONFIG_PROC_FS */
 
+    xnintr_mount();
+
 #ifdef CONFIG_LTT
     xnltt_mount();
 #endif /* CONFIG_LTT */

------=_Part_16193_362179.1137593857084--

