Message-ID: <b647ffbd0602080212u70ce25d8q@domain.hid>
Date: Wed, 8 Feb 2006 12:12:41 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
In-Reply-To: <43E9AAB3.5020004@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3106_2043373.1139393561101"
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E86F4D.4050400@domain.hid>
	<43E8DFC4.4010805@domain.hid>
	<43E99D2F.6040609@domain.hid>
	<43E9AAB3.5020004@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_3106_2043373.1139393561101
Content-Type: multipart/alternative; 
	boundary="----=_Part_3107_16791080.1139393561101"

------=_Part_3107_16791080.1139393561101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 08/02/06, Jan Kiszka <kiszka@domain.hid> wrote:

> I still prefer configuration options as they also allow to reduce the
> > overall code size (less cache refills and TLB misses). And shared
> > interrupts are for x86 only (approximately), I think. Unfortunately, I
>
> Ok, that's a good argument. Then make the whole IRQ-sharing stuff
> compile-time configurable and see how much we can save.



Anyway, I agree that the code which is supposed to be used by only a
fraction of users (Jan is only interested so far? and esp. in that
"brain-damaged" edge-triggered stuff) and which is a bit too heavy to
guarantee a close-to-zero-overhead should be made optional.

Ok, let's go for it upon getting the test results.

Enclosed a small optimization to reduce the code in (optional in future)
ISR.


Jan
>
>
>


--
Best regards,
Dmitry Adamushko

------=_Part_3107_16791080.1139393561101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br>
<div><span class=3D"gmail_quote">On 08/02/06, <b class=3D"gmail_sendername"=
>Jan Kiszka</b> &lt;<a href=3D"mailto:kiszka@domain.hid">kiszka@domain.hid=
s.uni-hannover.de</a>&gt; wrote:</span> <br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; I still =
prefer configuration options as they also allow to reduce the<br>&gt; overa=
ll code size (less cache refills and TLB misses). And shared
<br>&gt; interrupts are for x86 only (approximately), I think. Unfortunatel=
y, I<br><br>Ok, that's a good argument. Then make the whole IRQ-sharing stu=
ff<br>compile-time configurable and see how much we can save.</blockquote>
<div><br>
<br>
Anyway, I agree that the code which is supposed to be used by only a
fraction of users (Jan is only interested so far? and esp. in that
&quot;brain-damaged&quot; edge-triggered stuff) and which is a bit too heav=
y to
guarantee a close-to-zero-overhead should be made optional.<br>
<br>
Ok, let's go for it upon getting the test results.<br>
<br>
Enclosed a small optimization to reduce the code in (optional in future) IS=
R.<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br>=
<br><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry=
 Adamushko

------=_Part_3107_16791080.1139393561101--

------=_Part_3106_2043373.1139393561101
Content-Type: application/octet-stream; name=shirq-v9.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ehu5mrx9
Content-Disposition: attachment; filename="shirq-v9.patch"

diff -urp xenomai-shirq-ext/include/nucleus/intr.h xenomai-shirq-v9/include/nucleus/intr.h
--- xenomai-shirq-ext/include/nucleus/intr.h	2006-02-06 15:34:24.000000000 +0100
+++ xenomai-shirq-v9/include/nucleus/intr.h	2006-02-08 09:28:36.000000000 +0100
@@ -66,6 +66,8 @@ extern "C" {
 
 int xnintr_mount(void);
 
+void xnintr_clock_attach(xnintr_t *intr);
+void xnintr_clock_detach(xnintr_t *intr);
 void xnintr_clock_handler(void);
 
 int xnintr_irq_proc(unsigned int irq, char *str);
diff -urp xenomai-shirq-ext/ksrc/nucleus/intr.c xenomai-shirq-v9/ksrc/nucleus/intr.c
--- xenomai-shirq-ext/ksrc/nucleus/intr.c	2006-02-06 15:27:47.000000000 +0100
+++ xenomai-shirq-v9/ksrc/nucleus/intr.c	2006-02-08 09:27:29.000000000 +0100
@@ -502,6 +502,16 @@ xnarch_cpumask_t xnintr_affinity (xnintr
     return xnarch_set_irq_affinity(intr->irq,cpumask);
 }
 
+void xnintr_clock_attach(xnintr_t *intr)
+{
+    xnshirqs[intr->irq].handlers = intr;
+}
+
+void xnintr_clock_detach(xnintr_t *intr)
+{
+    xnshirqs[intr->irq].handlers = NULL;
+}
+
 /* Low-level clock irq handler. */
 
 void xnintr_clock_handler (void)
@@ -530,28 +540,19 @@ static void xnintr_irq_handler (unsigned
 
     ++sched->inesting;
 
-    if (irq == XNARCH_TIMER_IRQ)
-	{
-	intr = (xnintr_t*)cookie;
-	s = intr->isr(intr);
-	++intr->hits;
-	}
-    else
-	{
-	shirq = &xnshirqs[irq];
+    shirq = &xnshirqs[irq];
 
-	xnintr_shirq_lock(shirq);
-	intr = shirq->handlers;
+    xnintr_shirq_lock(shirq);
+    intr = shirq->handlers;
 
-	while (intr)
-	    {
-	    s |= intr->isr(intr);
-	    ++intr->hits;
+    while (intr)
+        {
+        s |= intr->isr(intr);
+        ++intr->hits;
 
-	    intr = intr->next;
-	    }
-	xnintr_shirq_unlock(shirq);
-	}
+        intr = intr->next;
+        }
+    xnintr_shirq_unlock(shirq);
 
     --sched->inesting;
 
diff -urp xenomai-shirq-ext/ksrc/nucleus/pod.c xenomai-shirq-v9/ksrc/nucleus/pod.c
--- xenomai-shirq-ext/ksrc/nucleus/pod.c	2006-02-03 15:41:50.000000000 +0100
+++ xenomai-shirq-v9/ksrc/nucleus/pod.c	2006-02-08 09:21:16.000000000 +0100
@@ -3044,6 +3044,7 @@ unlock_and_exit:
        (xnarch_start_timer). */
 
     xnintr_init(&nkclock,NULL,XNARCH_TIMER_IRQ,tickhandler,NULL,0);
+    xnintr_clock_attach(&nkclock);
 
     __setbits(nkpod->status,XNTIMED);
 
@@ -3130,6 +3131,8 @@ void xnpod_stop_timer (void)
 	xntimer_set_aperiodic_mode();
         }
 
+    xnintr_clock_detach(&nkclock);
+
  unlock_and_exit:
 
     xnlock_put_irqrestore(&nklock,s);


------=_Part_3106_2043373.1139393561101--

