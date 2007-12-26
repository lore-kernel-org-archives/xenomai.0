Message-ID: <477275F1.6020708@domain.hid>
Date: Wed, 26 Dec 2007 16:40:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC58314CC8A99BD2C95469E59"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix __ipipe_tick_irq tracking across APIC
	reprogramming
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
--------------enigC58314CC8A99BD2C95469E59
Content-Type: multipart/mixed;
 boundary="------------000405060104030508090808"

This is a multi-part message in MIME format.
--------------000405060104030508090808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As LOCAL_TIMER_VECTOR !=3D RTHAL_APIC_TIMER_VECTOR (Philippe, what was th=
e
motivation for this?), we need to update __ipipe_tick_irq when we
reprogram the APIC. Otherwise, I-pipe will not be able to capture and
forward the related IRQ registers.

At this chance, refactor some references to Xenomai's own APIC timer IRQ.=


Merry Christmas and all the best for 2008 to everyone!

Jan

--------------000405060104030508090808
Content-Type: text/x-patch;
 name="update-ipipe_tick_irq.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="update-ipipe_tick_irq.patch"

Index: xenomai/ksrc/arch/x86/hal-common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai/ksrc/arch/x86/hal-common.c	(Revision 3301)
+++ xenomai/ksrc/arch/x86/hal-common.c	(Arbeitskopie)
@@ -54,7 +54,7 @@
 	case RTHAL_SET_ONESHOT_LINUX:
 		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
 		/* We need to keep the timing cycle alive for the kernel. */
-		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+		rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
 		break;
=20
 	case RTHAL_SET_PERIODIC:
@@ -71,11 +71,14 @@
 	if (rt_mode) {
 		rthal_sync_op =3D RTHAL_SET_ONESHOT_XENOMAI;
 		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
+		if (rthal_ktimer_saved_mode !=3D KTIMER_MODE_UNUSED)
+			__ipipe_tick_irq =3D RTHAL_TIMER_IRQ;
 	} else {
 		rthal_sync_op =3D RTHAL_SET_ONESHOT_LINUX;
 		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
+		__ipipe_tick_irq =3D RTHAL_HOST_TICK_IRQ;
 		/* We need to keep the timing cycle alive for the kernel. */
-		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+		rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
 	}
 	rthal_critical_exit(flags);
 }
@@ -87,6 +90,7 @@
 	flags =3D rthal_critical_enter(&rthal_critical_sync);
 	rthal_sync_op =3D RTHAL_SET_PERIODIC;
 	rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
+	__ipipe_tick_irq =3D RTHAL_HOST_TICK_IRQ;
 	rthal_critical_exit(flags);
 }
=20
@@ -112,7 +116,7 @@
 #ifdef CONFIG_SMP
 	send_IPI_all(LOCAL_TIMER_VECTOR);
 #else
-	rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+	rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
 #endif
 	return IRQ_HANDLED;
 }

--------------000405060104030508090808--

--------------enigC58314CC8A99BD2C95469E59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnXxniDOoMHTA+kRAotfAJ9gmoqZdt26xx8F2Frvb6iHv1Km6ACff/A8
79mHEAP2cpqZA6ROoPyKDxY=
=2tNa
-----END PGP SIGNATURE-----

--------------enigC58314CC8A99BD2C95469E59--

