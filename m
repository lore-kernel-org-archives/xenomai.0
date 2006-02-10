Message-ID: <43ECD570.5000704@domain.hid>
Date: Fri, 10 Feb 2006 19:03:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F0A195A7CD72DE6BDA35CE2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [shirq] first test results
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F0A195A7CD72DE6BDA35CE2
Content-Type: multipart/mixed; boundary="------------080808050501090604050301"

This is a multi-part message in MIME format.
--------------080808050501090604050301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

some news from the testing front: It works fairly well - and it doesn't
crash =3D:). We set up a quite demanding test scenario which consists of
two Sick Laser scanners feeding two UART ports at 500 Kbit/s. The UARTs
are on a special PC104 card, sharing the same edge-triggered IRQ line.
We were able to get data from both devices running at the same time. But
we noticed some overruns of MAX_EDGEIRQ_COUNTER (a few per second). The
next step on Monday will be to generate a back-trace with the
ipipe-tracer to see if the system is "just" overloaded or if we are
still facing problems with the driver and/or IRQ layer. Will be very
interesting to see on that radar what's happing.

I attached two patches. One enables xeno_16550A to use the new features,
and the other improves the /proc output of your patch slightly.

Furthermore, we noticed that virtual IRQs (namely the printk forwarder)
get displayed under /proc/xenomai/irq too. Is this useful? We wondered
what IRQ 34 might be until code analysis of Xenomai and Ipipe revealed
it (__ipipe_printk_virq). If it is considered useful, we should at least
mark those irqs virtual in the output or even give them names as well.

Then I stumbled over the xnintr structure. Why do you keep a copy of the
device name? A "const char *" should be enough, we just have to demand
that it will remain valid as long as the xnintr structure itself (i.e.
during the IRQ being attached). Saves a few bytes. :)

Jan

--------------080808050501090604050301
Content-Type: text/plain;
 name="shirq-16550A.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="shirq-16550A.patch"

Index: ksrc/drivers/16550A/16550A.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/16550A/16550A.c	(revision 556)
+++ ksrc/drivers/16550A/16550A.c	(working copy)
@@ -238,7 +238,7 @@
     int                     rbytes =3D 0;
     int                     events =3D 0;
     int                     modem;
-    int                     ret =3D RTDM_IRQ_PROPAGATE;
+    int                     ret =3D RTDM_IRQ_PROPAGATE | RTDM_IRQ_NOINT;=

=20
=20
     ctx =3D rtdm_irq_get_arg(irq_context, struct rt_16550_context);
@@ -446,7 +446,8 @@
     ctx =3D (struct rt_16550_context *)context->dev_private;
=20
     ret =3D rtdm_irq_request(&ctx->irq_handle, irq[dev_id], rt_16550_int=
errupt,
-                           0, context->device->proc_name, ctx);
+                           RTDM_IRQTYPE_SHARED|RTDM_IRQTYPE_EDGE,
+                           context->device->proc_name, ctx);
     if (ret < 0)
         return ret;
=20

--------------080808050501090604050301
Content-Type: text/plain;
 name="shirq-timer-name.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="shirq-timer-name.patch"

--- xenomai/ksrc/nucleus/pod.c.orig	2006-02-10 14:30:32.000000000 +0100
+++ xenomai/ksrc/nucleus/pod.c	2006-02-10 14:30:49.000000000 +0100
@@ -3071,7 +3071,7 @@ unlock_and_exit:
        source will be attached directly by the arch-dependent layer
        (xnarch_start_timer). */
=20
-    xnintr_init(&nkclock,NULL,XNARCH_TIMER_IRQ,tickhandler,NULL,0);
+    xnintr_init(&nkclock,"[timer]",XNARCH_TIMER_IRQ,tickhandler,NULL,0);=

     xnintr_clock_attach(&nkclock);
=20
     __setbits(nkpod->status,XNTIMED);

--------------080808050501090604050301--

--------------enig8F0A195A7CD72DE6BDA35CE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD7NVwniDOoMHTA+kRAq5yAJ0RKqCUQrppxJQCs3wpUSYd2HriUACfcxAV
K35S0jJtdqa/bG9R9TeA9LQ=
=uZ8j
-----END PGP SIGNATURE-----

--------------enig8F0A195A7CD72DE6BDA35CE2--

