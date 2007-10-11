Message-ID: <470E8BFE.4070804@domain.hid>
Date: Thu, 11 Oct 2007 22:47:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F456769DF46710EC7906273"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F456769DF46710EC7906273
Content-Type: multipart/mixed;
 boundary="------------020003020203030805000302"

This is a multi-part message in MIME format.
--------------020003020203030805000302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This patch for SVN trunk fixes most of the current bugs around hardware
timer takeover and release from/to Linux. Tested and found working here
(including SMP):
- 2.6.22, APIC, highres=3Doff, nohz=3Doff
- 2.6.22, APIC, highres=3Don, nohz=3Don
- 2.6.20, APIC

Tests to be done:
- 2.6.22, PIT (currently building...)
- 2.6.20, PIT

Things became quite complex in i386/hal.c now. Some of this complexity
might be avoidable if RTHAL_APIC_TIMER_VECTOR equalled
LOCAL_TIMER_VECTOR. What's the reason for this? Is it something related
to pre-highres times of Linux (ie. 2.6.20 and earlier)? Can we overcome
it, at least for recent kernels?

So, while this patch may work correctly, my feeling is it needs yet
another round of polishing, also looking for now possibly outdated commen=
ts.

Jan

--------------020003020203030805000302
Content-Type: text/x-patch;
 name="fix-timers.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-timers.patch"

Index: xenomai/ksrc/arch/i386/hal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/i386/hal.c	(Revision 3050)
+++ xenomai/ksrc/arch/i386/hal.c	(Arbeitskopie)
@@ -77,7 +77,12 @@ static struct {
 	int count;
 } rthal_linux_irq[IPIPE_NR_XIRQS];
=20
-static int rthal_ktimer_oneshot;
+static enum {
+	KTIMER_MODE_UNUSED =3D 0,
+	KTIMER_MODE_SHUTDOWN,
+	KTIMER_MODE_PERIODIC,
+	KTIMER_MODE_ONESHOT,
+} rthal_ktimer_saved_mode;
=20
 #ifdef CONFIG_X86_LOCAL_APIC
=20
@@ -103,15 +108,24 @@ static inline void rthal_setup_oneshot_a
 	apic_write_around(APIC_LVTT, rthal_set_apic_base(vector));
 }
=20
+#define RTHAL_SET_ONESHOT_RT		1
+#define RTHAL_SET_ONESHOT_LINUX		2
+#define RTHAL_SET_PERIODIC		3
+
 static void rthal_critical_sync(void)
 {
 	switch (rthal_sync_op) {
-	case 1:
+	case RTHAL_SET_ONESHOT_RT:
 		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
 		break;
=20
-	case 2:
+	case RTHAL_SET_ONESHOT_LINUX:
+		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
+		/* We need to keep the timing cycle alive for the kernel. */
+		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+		break;
=20
+	case RTHAL_SET_PERIODIC:
 		rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
 		break;
 	}
@@ -218,13 +232,20 @@ static void rthal_latency_above_max(stru
=20
 #endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
=20
-static void rthal_timer_set_oneshot(void)
+static void rthal_timer_set_oneshot(int rt_mode)
 {
 	unsigned long flags;
=20
 	flags =3D rthal_critical_enter(rthal_critical_sync);
-	rthal_sync_op =3D 1;
-	rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
+	if (rt_mode) {
+		rthal_sync_op =3D RTHAL_SET_ONESHOT_RT;
+		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
+	} else {
+		rthal_sync_op =3D RTHAL_SET_ONESHOT_LINUX;
+		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
+		/* We need to keep the timing cycle alive for the kernel. */
+		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+	}
 	rthal_critical_exit(flags);
 }
=20
@@ -233,7 +254,7 @@ static void rthal_timer_set_periodic(voi
 	unsigned long flags;
=20
 	flags =3D rthal_critical_enter(&rthal_critical_sync);
-	rthal_sync_op =3D 2;
+	rthal_sync_op =3D RTHAL_SET_PERIODIC;
 	rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
 	rthal_critical_exit(flags);
 }
@@ -261,13 +282,16 @@ int rthal_timer_request(
 		 * the caller to start an internal timer for emulating
 		 * a periodic tick. */
 		tickval =3D 1000000000UL / HZ;
-		rthal_ktimer_oneshot =3D 0;
 		break;
=20
-	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_ONESHOT:
+		/* oneshot tick emulation */
+		tickval =3D 1;
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+		/* we don't need to emulate the tick at all. */
 		tickval =3D 0;
-		rthal_ktimer_oneshot =3D 1;
 		break;
=20
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -276,6 +300,8 @@ int rthal_timer_request(
 	default:
 		return err;
 	}
+
+	rthal_ktimer_saved_mode =3D err;
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
 	/*
 	 * When the local APIC is enabled for kernels lacking generic
@@ -285,7 +311,7 @@ int rthal_timer_request(
 	 * APIC-based timer interrupt instead, i.e. RTHAL_APIC_TIMER_IPI).
 	 */
 	tickval =3D 0;
-	rthal_ktimer_oneshot =3D 1;
+	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
 	/*
@@ -295,7 +321,7 @@ int rthal_timer_request(
 	if (cpu > 0)
 		goto out;
=20
-	rthal_timer_set_oneshot();
+	rthal_timer_set_oneshot(1);
=20
 	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
 			  (rthal_irq_handler_t) tick_handler, NULL, NULL);
@@ -335,8 +361,10 @@ void rthal_timer_release(int cpu)
=20
 	rthal_irq_release(RTHAL_APIC_TIMER_IPI);
=20
-	if (!rthal_ktimer_oneshot)
+	if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_PERIODIC)
 		rthal_timer_set_periodic();
+	else if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_ONESHOT)
+		rthal_timer_set_oneshot(0);
 }
=20
 #else /* !CONFIG_X86_LOCAL_APIC */
@@ -445,13 +473,16 @@ int rthal_timer_request(
 		 * the caller to start an internal timer for emulating
 		 * a periodic tick. */
 		tickval =3D 1000000000UL / HZ;
-		rthal_ktimer_oneshot =3D 0;
 		break;
=20
-	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_ONESHOT:
+		/* oneshot tick emulation */
+		tickval =3D 1;
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+		/* we don't need to emulate the tick at all. */
 		tickval =3D 0;
-		rthal_ktimer_oneshot =3D 1;
 		break;
=20
 	case CLOCK_EVT_MODE_SHUTDOWN:
@@ -460,13 +491,15 @@ int rthal_timer_request(
 	default:
 		return err;
 	}
+
+	rthal_ktimer_saved_mode =3D err;
 #else /* !CONFIG_GENERIC_CLOCKEVENTS */
 	/*
 	 * Out caller has to to emulate the periodic host tick by its
 	 * own means once we will have grabbed the PIT.
 	 */
 	tickval =3D 1000000000UL / HZ;
-	rthal_ktimer_oneshot =3D 0;
+	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
 	/*
@@ -489,9 +522,9 @@ void rthal_timer_release(int cpu)
 #endif
 	rthal_irq_release(RTHAL_TIMER_IRQ);
=20
-	if (!rthal_ktimer_oneshot)
+	if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_PERIODIC)
 		rthal_timer_set_periodic();
-	else
+	else if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_ONESHOT)
 		/* We need to keep the timing cycle alive for the kernel. */
 		rthal_trigger_irq(RTHAL_TIMER_IRQ);
 }
@@ -561,16 +594,7 @@ void rthal_timer_notify_switch(enum cloc
 		 */
 		return;
=20
-	switch(mode) {
-	case CLOCK_EVT_MODE_ONESHOT:
-		rthal_ktimer_oneshot =3D 1;
-		break;
-	case CLOCK_EVT_MODE_PERIODIC:
-		rthal_ktimer_oneshot =3D 0;
-		break;
-	default:
-		;
-	}
+	rthal_ktimer_saved_mode =3D mode;
 }
=20
 EXPORT_SYMBOL(rthal_timer_notify_switch);
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/nucleus/pod.c	(Revision 3050)
+++ xenomai/ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -3076,10 +3076,10 @@ int xnpod_enable_timesource(void)
 		 * Linux as needed.
 		 */
=20
-		if (htickval)
+		if (htickval > 1)
 			xntimer_start(&sched->htimer, htickval, htickval, XN_RELATIVE);
-
-		__setbits(sched->status, XNHTICK);
+		else
+			xntimer_start(&sched->htimer, 0, 0, XN_RELATIVE);
=20
 #if defined(CONFIG_XENO_OPT_WATCHDOG)
 		xntimer_start(&sched->wdtimer, 1000000000UL, 1000000000UL, XN_RELATIVE=
);

--------------020003020203030805000302--

--------------enig8F456769DF46710EC7906273
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHDowBniDOoMHTA+kRAug7AJ0ZFrOt2dBU2AYhe+WvxHZgsHa7RgCdHlFn
OxytvgPxTJIdj+GerlpQEP4=
=McPq
-----END PGP SIGNATURE-----

--------------enig8F456769DF46710EC7906273--

