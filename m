Message-ID: <b647ffbd0603010009w717c59fbs@domain.hid>
Date: Wed, 1 Mar 2006 10:09:45 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11867_26897227.1141200585255"
Subject: [Xenomai-core] [PATCH] hal/arm : rthal_irq_enable/disable/end
	corrections
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

------=_Part_11867_26897227.1141200585255
Content-Type: multipart/alternative; 
	boundary="----=_Part_11868_16392010.1141200585255"

------=_Part_11868_16392010.1141200585255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Linux'es enable/disable_irq() should not be called from the primary domain.

In short, they use a normal linux spinlock + irq are off only for the Linux
domain;
the precise description is available here :
https://mail.gna.org/public/xenomai-core/2006-02/msg00213.html


--
Best regards,
Dmitry Adamushko

------=_Part_11868_16392010.1141200585255
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hello,<br>
<br>
Linux'es enable/disable_irq() should not be called from the primary domain.=
<br>
<br>
In short, they use a normal linux spinlock + irq are off only for the Linux=
 domain;<br>
the precise description is available here : <a href=3D"https://mail.gna.org=
/public/xenomai-core/2006-02/msg00213.html">https://mail.gna.org/public/xen=
omai-core/2006-02/msg00213.html</a><br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_11868_16392010.1141200585255--

------=_Part_11867_26897227.1141200585255
Content-Type: application/octet-stream; name=arm-hal.c.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek18gdxj
Content-Disposition: attachment; filename="arm-hal.c.patch"

--- hal.c-CVS	2006-03-01 08:57:40.000000000 +0100
+++ hal.c	2006-03-01 08:59:40.000000000 +0100
@@ -161,7 +161,11 @@ int rthal_irq_enable (unsigned irq)
     if (irq >= IPIPE_NR_XIRQS)
         return -EINVAL;
 
-    enable_irq(irq);
+    if (rthal_irq_descp(irq)->handler == NULL ||
+	rthal_irq_descp(irq)->handler->enable == NULL)
+	return -ENODEV;
+
+    rthal_irq_descp(irq)->handler->enable(irq);
 
     return 0;
 }
@@ -171,19 +175,18 @@ int rthal_irq_disable (unsigned irq)
     if (irq >= IPIPE_NR_XIRQS)
         return -EINVAL;
 
-    disable_irq(irq);
+    if (rthal_irq_descp(irq)->handler == NULL ||
+	rthal_irq_descp(irq)->handler->disable == NULL)
+	return -ENODEV;
+
+    rthal_irq_descp(irq)->handler->disable(irq);
 
     return 0;
 }
 
 int rthal_irq_end (unsigned irq)
 {
-    if (irq >= IPIPE_NR_XIRQS)
-        return -EINVAL;
-
-    enable_irq(irq);
-
-    return 0;
+    return rthal_irq_enable(irq);
 }
 
 static inline int do_exception_event (unsigned event, unsigned domid, void *data)




------=_Part_11867_26897227.1141200585255--

