Message-ID: <4666D538.8050004@domain.hid>
Date: Wed, 06 Jun 2007 17:39:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060909010404090405090909"
Subject: [Xenomai-core] Bug when closing a busy file descriptor.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060909010404090405090909
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7Bit


Hi,

there is a bug when closing a busy file descriptor: the close function
keeps incrementing the file descriptor reference count making it
impossible to really close the file descriptor.	

The attached patch fixes this.

-- 
                                                 Gilles Chanteperdrix

--------------060909010404090405090909
Content-Type: text/x-patch;
 name="xeno-unlock-context-when-restarting-rtdm-close.diff"
Content-Disposition: inline;
 filename="xeno-unlock-context-when-restarting-rtdm-close.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: ksrc/skins/rtdm/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/core.c	(r=C3=A9vision 2533)
+++ ksrc/skins/rtdm/core.c	(copie de travail)
@@ -340,6 +340,7 @@
     XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable();=
);
=20
     if (unlikely(ret =3D=3D -EAGAIN) && !rtdm_in_rt_context()) {
+	rtdm_context_unlock(context);
         msleep(CLOSURE_RETRY_PERIOD);
         goto again;
     } else if (unlikely(ret < 0))
@@ -354,6 +355,7 @@
             ret =3D -EAGAIN;
             goto unlock_out;
         }
+	rtdm_context_unlock(context);
         msleep(CLOSURE_RETRY_PERIOD);
         goto again;
     }

--------------060909010404090405090909--

