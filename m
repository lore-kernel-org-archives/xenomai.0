Message-ID: <43C00542.7020501@domain.hid>
Date: Sat, 07 Jan 2006 19:15:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43C004EB.1090702@domain.hid>
In-Reply-To: <43C004EB.1090702@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig42324B8DC7A6A7577B9F966C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [PATCH] reset tracer after timer calibration
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42324B8DC7A6A7577B9F966C
Content-Type: multipart/mixed; boundary="------------010804050505070501020504"

This is a multi-part message in MIME format.
--------------010804050505070501020504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi Philippe,
> 
> this patch is to reset the maximum IRQs-off path after timer calibration
> (will get flooded otherwise). If you have no concerns, please apply.
> 
> Actually, there is another noise source: rthal_timer_request() for the
> APIC case. But I think we should let this one alone as the user may
> trigger millisecond latencies by accidentally restarting the timer while
> some external-IRQ-driven device still depends on low latencies. In that
> case, the tracer can provide helpful hints.
> 
> Therefore, in order to get useful information after starting the timer,
> one always have to run "echo > /proc/ipipe/trace/max" first. Well, if we
> move the timer start to some module init or whatever phase also for the
> native skin, we should reconsider this exclusion.
> 
> Jan

and *with* the attachement...

--------------010804050505070501020504
Content-Type: text/x-patch;
 name="reset-trace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reset-trace.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 388)
+++ ChangeLog	(Arbeitskopie)
@@ -7,6 +7,8 @@
 	src/testsuite/latency/latency.c: Add re-freeze support and make use
 	of it to back-trace always the max latency during benchmarks.
 
+	* ksrc/arch/i386/hal.c: reset tracer after timer calibration.
+
 2006-01-07  Heikki Lindholm <holindho@domain.hid>
 
 	* include/asm-powerpc/system.h: Fix FPU preemption bug.
Index: ksrc/arch/i386/hal.c
===================================================================
--- ksrc/arch/i386/hal.c	(Revision 386)
+++ ksrc/arch/i386/hal.c	(Arbeitskopie)
@@ -61,6 +61,9 @@
 #endif /* CONFIG_X86_LOCAL_APIC */
 #include <asm/xenomai/hal.h>
 #include <stdarg.h>
+#ifdef CONFIG_IPIPE_TRACE
+#include <linux/ipipe_trace.h>
+#endif /* CONFIG_IPIPE_TRACE */
 
 extern struct desc_struct idt_table[];
 
@@ -177,6 +180,11 @@
 
     rthal_critical_exit(flags);
 
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+    /* reset the max trace, it contains the excessive calibration now */
+    ipipe_trace_max_reset();
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
     return rthal_imuldiv(dt,100000,RTHAL_CPU_FREQ);
 }
 
@@ -345,6 +353,11 @@
 
     rthal_critical_exit(flags);
 
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+    /* reset the max trace, it contains the excessive calibration now */
+    ipipe_trace_max_reset();
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
     return rthal_imuldiv(dt,100000,RTHAL_CPU_FREQ);
 }
 

--------------010804050505070501020504--

--------------enig42324B8DC7A6A7577B9F966C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwAVCniDOoMHTA+kRAhOBAJ4plr3BPSdUucdHN0gruJIkjYVaewCdGETZ
vm0PdkEMu7bgKC3WS9f/hQQ=
=xQSa
-----END PGP SIGNATURE-----

--------------enig42324B8DC7A6A7577B9F966C--

