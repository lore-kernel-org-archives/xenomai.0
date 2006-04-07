Message-ID: <b647ffbd0604070805k32dc185fu4d3705906ffcbc2f@domain.hid>
Date: Fri, 7 Apr 2006 18:05:04 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20847_8533183.1144422304615"
Subject: [Xenomai-core] [draft PATCH] nested enable/disable irq calls
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

------=_Part_20847_8533183.1144422304615
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

yep, this is yet another draft patch which aims at supporting the
nested irq disable/enable calls for the primary domain.

o  no changes on the adeos-ipipe layer, hence it's much cleaner and
smaller that the one I have posted last time;

o  eliminates the need for XN_ISR_NOENABLE flag;

o  but is based on the presupposition (otherwise it's wrong) that for
all acrhitectures that support Xenomai the following is true :

=09pic_handler->ack :
=09    * mask
=09    * eoi
=09
=09pic_handler->end :
=09    * unmask
=09
Philippe told me some time ago that this is a _must_ now for any arch
to be compatible with adeos-ipipe.

If so, with some minor cleanups (XN_ISR_NOENABLE should be removed all
over the map,
docs fixes, ...) and testing the patch may hopefully find its way into
the codebase.

Any feedback? =09

TIA,

--
Best regards,
Dmitry Adamushko

------=_Part_20847_8533183.1144422304615
Content-Type: application/octet-stream; name=depth.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="depth.patch"

diff -urp xenomai/include/nucleus/intr.h xenomai-depth/include/nucleus/intr.h
--- xenomai/include/nucleus/intr.h	2006-02-28 17:57:22.000000000 +0100
+++ xenomai-depth/include/nucleus/intr.h	2006-04-07 17:21:36.000000000 +0200
@@ -43,6 +43,8 @@ typedef struct xnintr {
 
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
     struct xnintr *next; /* !< Next object in the IRQ-sharing chain. */
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+    int depth;
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
     xnisr_t isr;	/* !< Interrupt service routine. */
diff -urp xenomai/ksrc/nucleus/intr.c xenomai-depth/ksrc/nucleus/intr.c
--- xenomai/ksrc/nucleus/intr.c	2006-03-18 18:29:42.000000000 +0100
+++ xenomai-depth/ksrc/nucleus/intr.c	2006-04-07 17:09:51.000000000 +0200
@@ -41,11 +41,18 @@ xnintr_t nkclock;
 static void xnintr_irq_handler(unsigned irq,
 			       void *cookie);
 
+static int __xnintr_depth(xnintr_t *intr, int diff);
+
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 
 /* Helper functions. */
 static int xnintr_shirq_attach(xnintr_t *intr, void *cookie);
 static int xnintr_shirq_detach(xnintr_t *intr);
+static void xnintr_synchronize(xnintr_t *intr);
+
+#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+
+static inline void xnintr_synchronize(xnintr_t *intr) { xnarch_memory_barrier(); }
 
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
@@ -162,9 +169,6 @@ int xnintr_init (xnintr_t *intr,
     intr->hits = 0;
     intr->name = name;
     intr->flags = flags;
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
-    intr->next = NULL;
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
     return 0;
 }
@@ -245,6 +249,7 @@ int xnintr_attach (xnintr_t *intr,
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
     return xnintr_shirq_attach(intr,cookie);
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+    intr->depth = 0;
     return xnarch_hook_irq(intr->irq,&xnintr_irq_handler,intr->iack,intr);
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 }
@@ -317,7 +322,25 @@ int xnintr_detach (xnintr_t *intr)
 int xnintr_enable (xnintr_t *intr)
 
 {
-    return xnarch_enable_irq(intr->irq);
+    int ret = 0;
+    spl_t s;
+
+    xnlock_get_irqsave(&nklock,s);
+
+    switch (__xnintr_depth(intr,0))
+	{
+	case 0:
+	    xnlogerr("xnintr_enable() : depth == 0. "
+		     "Unbalanced enable/disable calls for IRQ%d!\n",intr->irq);
+	    break;
+	case 1:
+	    ret = xnarch_irq_enable(intr->irq);
+	default:
+	    __xnintr_depth(intr,-1);
+	}
+
+    xnlock_put_irqrestore(&nklock,s);
+    return ret;
 }
 
 /*! 
@@ -345,10 +368,27 @@ int xnintr_enable (xnintr_t *intr)
  * Rescheduling: never.
  */
 
-int xnintr_disable (xnintr_t *intr)
+int xnintr_disable_nosync (xnintr_t *intr)
 
 {
-    return xnarch_disable_irq(intr->irq);
+    int ret = 0;
+    spl_t s;
+    
+    xnlock_get_irqsave(&nklock,s);
+
+    if (!__xnintr_depth(intr,1))
+	ret = xnarch_disable_irq(intr->irq);
+
+    xnlock_put_irqrestore(&nklock,s);
+    return ret;
+}
+
+int xintr_disable (xnintr_t *intr)
+
+{
+    int ret = xintr_disable_nosync(intr);
+    xnintr_synchronize(intr);
+    return ret;
 }
 
 /*! 
@@ -407,7 +447,7 @@ static void xnintr_irq_handler (unsigned
 
     if (s & XN_ISR_PROPAGATE)
 	xnarch_chain_irq(irq);
-    else if (!(s & XN_ISR_NOENABLE))
+    else if (!__xnintr_depth(intr,0))
 	xnarch_end_irq(irq);
 
     if (--sched->inesting == 0 && xnsched_resched_p())
@@ -438,6 +478,7 @@ typedef struct xnintr_shirq {
 #ifdef CONFIG_SMP
     atomic_counter_t active;
 #endif /* CONFIG_SMP */
+    int depth;    
 
 } xnintr_shirq_t;
 
@@ -495,7 +536,7 @@ static void xnintr_shirq_handler (unsign
 
     if (s & XN_ISR_PROPAGATE)
 	xnarch_chain_irq(irq);
-    else if (!(s & XN_ISR_NOENABLE))
+    else if (!shirq->depth)
 	xnarch_end_irq(irq);
 
     if (--sched->inesting == 0 && xnsched_resched_p())
@@ -560,7 +601,7 @@ static void xnintr_edge_shirq_handler (u
 
     if (s & XN_ISR_PROPAGATE)
 	xnarch_chain_irq(irq);
-    else if (!(s & XN_ISR_NOENABLE))
+    else if (!shirq->depth)
 	xnarch_end_irq(irq);
 
     if (--sched->inesting == 0 && xnsched_resched_p())
@@ -624,17 +665,19 @@ static int xnintr_shirq_attach (xnintr_t
 #endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
 	    }
 
+	shirq->depth = 0;
+
 	err = xnarch_hook_irq(intr->irq,handler,intr->iack,intr);
 	if (err)
 	    goto unlock_and_exit;
 	}
 
-    __setbits(intr->flags,XN_ISR_ATTACHED);
-
     /* Add a given interrupt object. */
     intr->next = NULL;
     *p = intr;
 
+    __setbits(intr->flags,XN_ISR_ATTACHED);
+
 unlock_and_exit:
 
     rthal_critical_exit(flags);
@@ -745,6 +788,15 @@ int xnintr_irq_proc(unsigned int irq, ch
     return p - str;
 }
 
+static int __xnintr_depth (xnintr_t *intr, int diff)
+{
+    xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
+    int old = shirq->depth;
+
+    shirq->depth += diff;
+    return old;    
+}
+
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
 
 int xnintr_mount(void)
@@ -757,6 +809,14 @@ int xnintr_irq_proc(unsigned int irq, ch
     return 0;
 }
 
+static int __xnintr_depth (xnintr_t *intr, int diff)
+{
+    int old = intr->depth;
+
+    intr->depth += diff;
+    return old;
+}
+
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
 
 EXPORT_SYMBOL(xnintr_attach);


------=_Part_20847_8533183.1144422304615--

