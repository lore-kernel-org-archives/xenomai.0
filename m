Message-ID: <b647ffbd0601091221h5596da2fg@domain.hid>
Date: Mon, 9 Jan 2006 22:21:25 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25930_6806060.1136838085708"
Subject: [Xenomai-core] [PATCH, RFC] nucleus:shared irq, draft v.2
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

------=_Part_25930_6806060.1136838085708
Content-Type: multipart/alternative; 
	boundary="----=_Part_25931_2395199.1136838085708"

------=_Part_25931_2395199.1136838085708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm presenting it one last time as a draft, so it's a right time to give al=
l
the remarks concerning design/implementation issues for all interested
parties.

Any feedback is wellcome.

--
Best regards,
Dmitry Adamushko

------=_Part_25931_2395199.1136838085708
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi everybody,<br>
<br>
I'm presenting it one last time as a draft, so it's a right time to
give all the remarks concerning design/implementation issues for all
interested parties.<br>
<br>
Any feedback is wellcome.<br clear=3D"all"><br>-- <br>Best regards,<br>Dmit=
ry Adamushko<br>
<br>
<br>


------=_Part_25931_2395199.1136838085708--

------=_Part_25930_6806060.1136838085708
Content-Type: application/octet-stream; name=shirq_intr.h.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq_intr.h.patch"

--- intr-cvs.h	2005-11-01 23:37:45.000000000 +0100
+++ intr.h	2006-01-09 20:36:11.000000000 +0100
@@ -26,21 +26,31 @@
 #define XN_ISR_CHAINED   0x1
 #define XN_ISR_ENABLE    0x2
 
+/* Creation flags. */
+#define XN_ISR_SHARED	 0x1
+
 #if defined(__KERNEL__) || defined(__XENO_UVM__) || defined(__XENO_SIM__)
 
 struct xnintr;
 
 typedef struct xnintr {
 
-    unsigned irq;	/* !< IRQ number. */
+    xnholder_t link;
 
+#define link2intr(laddr) \
+((xnintr_t *)(((char *)laddr) - (int)(&((xnintr_t *)0)->link)))
+    
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
 


------=_Part_25930_6806060.1136838085708
Content-Type: application/octet-stream; name=shirq_intr.c.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="shirq_intr.c.patch"

--- intr-cvs.c	2005-12-02 19:56:20.000000000 +0100
+++ intr.c	2006-01-09 21:26:44.000000000 +0100
@@ -41,6 +41,42 @@
 static void xnintr_irq_handler(unsigned irq,
 			       void *cookie);
 
+typedef struct xnintr_shirq {
+
+    xnqueue_t handlers;
+    
+#ifdef CONFIG_SMP
+    atomic_counter_t active;
+#endif /* CONFIG_SMP */
+
+} xnintr_shirq_t;
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
 /*! 
  * \fn int xnintr_init (xnintr_t *intr,unsigned irq,xnisr_t isr,xniack_t iack,xnflags_t flags)
  * \brief Initialize an interrupt object.
@@ -130,6 +166,8 @@
     intr->iack = iack;
     intr->cookie = NULL;
     intr->hits = 0;
+    intr->flags = flags;
+    inith(&intr->link);
 
     return 0;
 }
@@ -204,11 +242,66 @@
 int xnintr_attach (xnintr_t *intr,
 		   void *cookie)
 {
+    rthal_irq_handler_t irq_handler;
+    unsigned irq = intr->irq;
+    xnshared_irq_t *shirq;
+    int err = 0;
+    spl_t s;
+
     intr->hits = 0;
     intr->cookie = cookie;
-    return xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
+
+    xnlock_get_irqsave(&nklock,s);
+
+    irq_handler = rthal_irq_handler(&rthal_domain,irq);
+    
+    if (irq_handler)
+	{
+	xnintr_t *old;
+	shirq = rthal_irq_cookie(&rthal_domain,irq);
+	
+	if (irq_handler != &xnintr_irq_handler)
+	    {
+	    err = -EBUSY;
+	    goto unlock_and_exit;
+	    }
+	
+	old = link2intr(getheadq(&shirq->handlers));
+
+	if (!(old->flags & intr->flags & XN_ISR_SHARED))
+	    {
+	    err = -EBUSY;
+	    goto unlock_and_exit;
+	    }
+	
+	appendq(&shirq->handlers,&intr->link);
+	}
+    else
+	{
+	shirq = xnmalloc(sizeof(*shirq));
+	
+	if (!shirq)
+	    {
+	    err = -ENOMEM;
+	    goto unlock_and_exit;
+	    }
+
+	initq(&shirq->handlers);
+	appendq(&shirq->handlers,&intr->link);
+
+	err = xnarch_hook_irq(irq,&xnintr_irq_handler,intr->iack,shirq);
+	
+	if (err)
+	    xnfree(shirq);
+	}
+
+unlock_and_exit:
+    
+    xnlock_put_irqrestore(&nklock,s);
+    return err;
 }
 
+
 /*! 
  * \fn int xnintr_detach (xnintr_t *intr)
  * \brief Detach an interrupt object.
@@ -241,7 +334,32 @@
 int xnintr_detach (xnintr_t *intr)
 
 {
-    return xnarch_release_irq(intr->irq);
+    unsigned irq = intr->irq;
+    xnshared_irq_t *shirq;
+    int cleanup = 0;
+    int err = 0;
+    spl_t s;
+
+    xnlock_get_irqsave(&nklock,s);
+
+    shirq = rthal_irq_cookie(&rthal_domain,irq);
+
+    removeq(&shirq->handlers,&intr->link);
+    
+    if (!countq(&shirq->handlers))
+	{
+	err = xnarch_release_irq(irq);
+	cleanup = 1;
+	}
+
+    xnlock_put_irqrestore(&nklock,s);
+
+    xnintr_shirq_spin(shirq);
+
+    if (cleanup)
+	xnfree(shirq);
+
+    return err;
 }
 
 /*! 
@@ -350,17 +468,45 @@
 
 {
     xnsched_t *sched = xnpod_current_sched();
-    xnintr_t *intr = (xnintr_t *)cookie;
-    int s;
+    xnshared_irq_t *shirq = (xnshared_irq_t *)cookie;
+    xnholder_t holder;
+    spl_t flags;
+    int s = 0;
 
     xnarch_memory_barrier();
 
     xnltt_log_event(xeno_ev_ienter,irq);
 
+    xnlock_get_irqsave(&nklock,flags);
+
+    shirq = rthal_irq_cookie(&rthal_domain,irq);
+    xnintr_shirq_lock(shirq);
+
+    xnlock_put_irqrestore(&nklock,flags);
+    
+    if (!shirq)
+	{
+	xnintr_shirq_unlock(shirq);
+	xnltt_log_event(xeno_ev_iexit,irq);
+    	return;
+	}
+    
     ++sched->inesting;
-    s = intr->isr(intr);
+    
+    holder = getheadq(&shirq->handlers);
+    
+    while (holder)
+	{
+	xnintr_t *intr = link2intr(holder);
+	holder = nextq(&shirq->handlers,holder);
+
+	s |= intr->isr(intr);
+	++intr->hits;
+	}
+
+    xnintr_shirq_unlock(shirq);
+
     --sched->inesting;
-    ++intr->hits;
 
     if (s & XN_ISR_ENABLE)
 	xnarch_enable_irq(irq);
@@ -384,6 +530,7 @@
     xnltt_log_event(xeno_ev_iexit,irq);
 }
 
+
 /*@}*/
 
 EXPORT_SYMBOL(xnintr_attach);


------=_Part_25930_6806060.1136838085708--

