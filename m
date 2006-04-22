Message-ID: <b647ffbd0604220254l154fcc7dh462c7d45bcd2c441@domain.hid>
Date: Sat, 22 Apr 2006 12:54:22 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <44416943.4070702@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_36665_22526964.1145699662363"
References: <b647ffbd0604120138p5088006aqf074c711a0478487@domain.hid>
	<44416943.4070702@domain.hid>
Subject: [Xenomai-core] Re: [REQUEST] eliminate the
	rthal_critical_enter/exit() from rthal_irq_request()
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
Cc: xenomai@xenomai.org

------=_Part_36665_22526964.1145699662363
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I haven't had access to my laptop during this week so the patches
follow only now.

Yet another issue remains that may lead to a deadlock under some circumstan=
ces:

- rt_intr_delete() calls xnintr_detach() while holding the "nklock".

- xnintr_detach() (with CONFIG_SMP) spins in xnintr_shirq_spin()
when a corresponding ISR is currently running.

- now this ISR calls any function that uses "nklock" (everything make
use of it) ... Bum!

I first thought about moving xnintr_detach() out of the locked section
in rt_intr_delete() but it somewhat breaks interface consistency ---
e.g. xeno_mark_delete() is called before the object is completely
destroyed.

Another approach would be to introduce a service like
xnintr_synchronize() and enfource the upper interfaces (e.g. skins) to
make use of it in their _delete() methods.

The problem here is that the xnintr_shirq - interface is not complete
and safe without xnintr_shirq_spin() on detaching step and it becomes
somewhat blured with the enforcement like "on SMP systems one should
always call xnintr_synchronize() right after calling xnintr_detach()".

So I'm still thinking how to fix it better...


--
Best regards,
Dmitry Adamushko

------=_Part_36665_22526964.1145699662363
Content-Type: application/octet-stream; name=hal.c-irqrequest-noglock.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="hal.c-irqrequest-noglock.patch"

--- hal-CVS.c	2006-02-28 17:57:22.000000000 +0100
+++ hal.c	2006-04-22 12:09:20.000000000 +0200
@@ -160,30 +160,17 @@ int rthal_irq_request (unsigned irq,
 		       rthal_irq_ackfn_t ackfn,
 		       void *cookie)
 {
-    unsigned long flags;
     int err = 0;
 
     if (handler == NULL || irq >= IPIPE_NR_IRQS)
 	return -EINVAL;
 
-    flags = rthal_critical_enter(NULL);
-
-    if (rthal_irq_handler(&rthal_domain, irq) != NULL)
-	{
-	err = -EBUSY;
-	goto unlock_and_exit;
-	}
-
     err = rthal_virtualize_irq(&rthal_domain,
 			       irq,
 			       handler,
 			       cookie,
 			       ackfn,
-			       IPIPE_DYNAMIC_MASK);
-
- unlock_and_exit:
-
-    rthal_critical_exit(flags);
+			       IPIPE_DYNAMIC_MASK | IPIPE_EXCLUSIVE_MASK);
 
     return err;
 }













------=_Part_36665_22526964.1145699662363
Content-Type: application/octet-stream; name=core.c-virtualizeirq.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.2
Content-Disposition: attachment; filename="core.c-virtualizeirq.patch"

--- core-CVS.c	2006-02-27 15:10:41.000000000 +0100
+++ core.c	2006-04-22 11:40:43.000000000 +0200
@@ -412,7 +412,7 @@ int ipipe_virtualize_irq(struct ipipe_do
 	} else
 		modemask &=
 		    ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK |
-		      IPIPE_SHARED_MASK);
+		      IPIPE_SHARED_MASK | IPIPE_EXCLUSIVE_MASK);
 
 	if (acknowledge == NULL) {
 		if ((modemask & IPIPE_SHARED_MASK) == 0)













------=_Part_36665_22526964.1145699662363
Content-Type: application/octet-stream; name=intr.c-noglock.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.3
Content-Disposition: attachment; filename="intr.c-noglock.patch"

--- intr-CVS.c	2006-03-18 18:29:42.000000000 +0100
+++ intr.c	2006-04-22 11:50:35.000000000 +0200
@@ -576,13 +576,13 @@ static int xnintr_shirq_attach (xnintr_t
 {
     xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
     xnintr_t *prev, **p = &shirq->handlers;
-    unsigned long flags;
     int err = 0;
+    spl_t s;
 
     if (intr->irq >= RTHAL_NR_IRQS)
 	return -EINVAL;
 
-    flags = rthal_critical_enter(NULL);
+    xnlock_get_irqsave(&nklock,s);
 
     if (__testbits(intr->flags,XN_ISR_ATTACHED))
 	{
@@ -637,7 +637,7 @@ static int xnintr_shirq_attach (xnintr_t
 
 unlock_and_exit:
 
-    rthal_critical_exit(flags);
+    xnlock_put_irqrestore(&nklock,s);
     return err;
 }
 
@@ -645,17 +645,17 @@ int xnintr_shirq_detach (xnintr_t *intr)
 {
     xnintr_shirq_t *shirq = &xnshirqs[intr->irq];
     xnintr_t *e, **p = &shirq->handlers;
-    unsigned long flags;
     int err = 0;
+    spl_t s;
 
     if (intr->irq >= RTHAL_NR_IRQS)
 	return -EINVAL;
 
-    flags = rthal_critical_enter(NULL);
+    xnlock_get_irqsave(&nklock,s);
 
     if (!__testbits(intr->flags,XN_ISR_ATTACHED))
 	{
-	rthal_critical_exit(flags);
+	xnlock_put_irqrestore(&nklock,s);
 	return -EPERM;
 	}
 
@@ -672,7 +672,7 @@ int xnintr_shirq_detach (xnintr_t *intr)
 	    if (shirq->handlers == NULL)
 		err = xnarch_release_irq(intr->irq);
 
-	    rthal_critical_exit(flags);
+	    xnlock_put_irqrestore(&nklock,s);
 
 	    /* The idea here is to keep a detached interrupt object valid as long
 	       as the corresponding irq handler is running. This is one of the requirements
@@ -685,7 +685,7 @@ int xnintr_shirq_detach (xnintr_t *intr)
 	p = &e->next;
 	}
 
-    rthal_critical_exit(flags);
+    xnlock_put_irqrestore(&nklock,s);
 
     xnlogerr("attempted to detach a non previously attached interrupt object.\n");
     return err;













------=_Part_36665_22526964.1145699662363--

