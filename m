Message-ID: <b647ffbd0603110244y64ff4495t@domain.hid>
Date: Sat, 11 Mar 2006 12:44:27 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1872_11561502.1142073867586"
Subject: [Xenomai-core] [PATCH] shirq correction
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

------=_Part_1872_11561502.1142073867586
Content-Type: multipart/alternative; 
	boundary="----=_Part_1873_452694.1142073867586"

------=_Part_1873_452694.1142073867586
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I overlooked that the logic of decrementing the interrupt nesting count has
been changed recently and
both xnintr_shirq_handler() and xnintr_edge_shirq_handler() behave wrong in
this respect.

The attached patch fixes this misbehavior.

--
Best regards,
Dmitry Adamushko

------=_Part_1873_452694.1142073867586
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hello,<br>
<br>
I overlooked that the logic of decrementing the interrupt nesting count has=
 been changed recently and<br>
both xnintr_shirq_handler() and xnintr_edge_shirq_handler() behave wrong in=
 this respect.<br>
<br>
The attached patch fixes this misbehavior.<br clear=3D"all"><br>
-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_1873_452694.1142073867586--

------=_Part_1872_11561502.1142073867586
Content-Type: application/octet-stream; name=intr.c.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek58ta5t
Content-Disposition: attachment; filename="intr.c.patch"

--- intr.c-old	2006-03-10 11:07:42.000000000 +0100
+++ intr.c	2006-03-10 11:08:47.000000000 +0100
@@ -493,14 +493,12 @@ static void xnintr_shirq_handler (unsign
         }
     xnintr_shirq_unlock(shirq);
 
-    --sched->inesting;
-
     if (s & XN_ISR_PROPAGATE)
 	xnarch_chain_irq(irq);
     else if (!(s & XN_ISR_NOENABLE))
 	xnarch_end_irq(irq);
 
-    if (sched->inesting == 0 && xnsched_resched_p())
+    if (--sched->inesting == 0 && xnsched_resched_p())
 	xnpod_schedule();
 
     xnltt_log_event(xeno_ev_iexit,irq);
@@ -557,8 +555,6 @@ static void xnintr_edge_shirq_handler (u
 
     xnintr_shirq_unlock(shirq);
 
-    --sched->inesting;
-
     if (counter > MAX_EDGEIRQ_COUNTER)
 	xnlogerr("xnintr_edge_shirq_handler() : failed to get the IRQ%d line free.\n", irq);
 
@@ -567,7 +563,7 @@ static void xnintr_edge_shirq_handler (u
     else if (!(s & XN_ISR_NOENABLE))
 	xnarch_end_irq(irq);
 
-    if (sched->inesting == 0 && xnsched_resched_p())
+    if (--sched->inesting == 0 && xnsched_resched_p())
 	xnpod_schedule();
 
     xnltt_log_event(xeno_ev_iexit,irq);

------=_Part_1872_11561502.1142073867586
Content-Type: application/octet-stream; name=ChangeLog
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek58tnb9
Content-Disposition: attachment; filename="ChangeLog"


2006-03-10  Dmitry Adamushko <dmitry.adamushko@domain.hid>

	* ksrc/nucleus/intr.c (xnintr_shirq_handler, xintr_edge_shirq_handler):
	Decrement the interrupt nesting count the same way as xnintr_irq_handler()
	does it.

------=_Part_1872_11561502.1142073867586--

