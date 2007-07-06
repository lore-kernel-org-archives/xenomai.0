Message-ID: <468ED509.8060105@domain.hid>
Date: Sat, 07 Jul 2007 01:49:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0408ABC1CDC7E314B45FE918"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] reduce config complexity of intr.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0408ABC1CDC7E314B45FE918
Content-Type: multipart/mixed;
 boundary="------------000509080202070400000702"

This is a multi-part message in MIME format.
--------------000509080202070400000702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here comes an attempt to clean up some of the mess that piled up in
nucleus/intr.c over the time and specifically after our last hot-fixes.

First of all, I think we don't loose much when merging the two separate
switches for level- and edge-triggered shared IRQs into a single one.
That already beatifies some lines, kills conditional code, and removes
one configuration decision the user has to make.

Then I reordered some code to avoid warnings for the non-shared non-SMP
case AND to fix a probable compilation issue of the simulator (due to
unknown ____cacheline_aligned_in_smp).

At this chance, a few redundant conditional lines in rtcan_*_pci.c
drivers were removed as well.

Jan

--------------000509080202070400000702
Content-Type: text/x-patch;
 name="xnintr-cleanups.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xnintr-cleanups.patch"

---
 include/nucleus/intr.h                     |    4=20
 ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c |    4=20
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c  |    4=20
 ksrc/nucleus/Config.in                     |    8 -
 ksrc/nucleus/Kconfig                       |   32 +---
 ksrc/nucleus/intr.c                        |  213 ++++++++++++++--------=
-------
 6 files changed, 116 insertions(+), 149 deletions(-)

Index: xenomai/include/nucleus/intr.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/intr.h
+++ xenomai/include/nucleus/intr.h
@@ -45,9 +45,9 @@
=20
 typedef struct xnintr {
=20
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
+#ifdef CONFIG_XENO_OPT_SHIRQ
     struct xnintr *next; /* !< Next object in the IRQ-sharing chain. */
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+#endif /* CONFIG_XENO_OPT_SHIRQ */
=20
     unsigned unhandled;	/* !< Number of consequent unhandled interrupts =
*/
=20
Index: xenomai/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -176,11 +176,7 @@ static int rtcan_ixxat_pci_add_chan(stru
     outb(intcsr, board->conf_addr + IXXAT_INTCSR_OFFSET);
=20
     /* Register and setup interrupt handling */
-#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
     chip->irq_flags =3D RTDM_IRQTYPE_SHARED;
-#else
-    chip->irq_flags =3D 0;
-#endif
     chip->irq_num =3D pdev->irq;
=20
     RTCAN_DBG("%s: base_addr=3D0x%p conf_addr=3D%#x irq=3D%d ocr=3D%#x c=
dr=3D%#x\n",
Index: xenomai/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -230,11 +230,7 @@ static int rtcan_peak_pci_add_chan(struc
     strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
=20
     /* Register and setup interrupt handling */
-#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
     chip->irq_flags =3D RTDM_IRQTYPE_SHARED;
-#else
-    chip->irq_flags =3D 0;
-#endif
     chip->irq_num =3D pdev->irq;
     pita_icr_high =3D readw(board->conf_addr + PITA_ICR + 2);
     if (channel =3D=3D CHANNEL_SLAVE) {
Index: xenomai/ksrc/nucleus/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Config.in
+++ xenomai/ksrc/nucleus/Config.in
@@ -36,6 +36,8 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" !=3D "n" ]
 		bool 'Watchdog support' CONFIG_XENO_OPT_WATCHDOG
 	fi
=20
+	bool 'Shared interrupts' CONFIG_XENO_OPT_SHIRQ
+
 	bool 'Enable periodic timing' CONFIG_XENO_OPT_TIMING_PERIODIC
 	int 'Timer tuning latency (ns)' CONFIG_XENO_OPT_TIMING_TIMERLAT 0
 	int 'Scheduling latency (ns)' CONFIG_XENO_OPT_TIMING_SCHEDLAT 0
@@ -55,12 +57,6 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" !=3D "n" ]
 	fi
 	endmenu
=20
-	mainmenu_option next_comment
-	comment 'Shared interrupts'
-		bool 'Level-triggered interrupts' CONFIG_XENO_OPT_SHIRQ_LEVEL
-		bool 'Edge-triggered interrupts' CONFIG_XENO_OPT_SHIRQ_EDGE
-	endmenu
-
 	if [ "$CONFIG_LTT" !=3D "n" ]; then
 		mainmenu_option next_comment
 		comment 'LTT tracepoints filtering'
Index: xenomai/ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Kconfig
+++ xenomai/ksrc/nucleus/Kconfig
@@ -208,6 +208,15 @@ config XENO_OPT_WATCHDOG
 	behalf of the timer tick handler, thus is only active after
 	the timer has been started.
=20
+config XENO_OPT_SHIRQ
+	bool "Shared interrupts"
+	help
+
+	Enables support for both level- and edge-triggered shared
+	interrupts, so that multiple real-time interrupt handlers
+	are allowed to control dedicated hardware devices which are
+	configured to share the same interrupt line.
+
 menu "Timing"
=20
 config XENO_OPT_TIMING_PERIODIC
@@ -319,29 +328,6 @@ config XENO_OPT_TIMER_WHEEL_STEP
=20
 endmenu
=20
-
-menu "Shared interrupts"
-
-config XENO_OPT_SHIRQ_LEVEL
-	bool "Level-triggered interrupts"
-	help
-
-	Enables support for shared level-triggered interrupts, so that
-	multiple real-time interrupt handlers are allowed to control
-	dedicated hardware devices which are configured to share
-	the same interrupt channel.
-
-config XENO_OPT_SHIRQ_EDGE
-	bool "Edge-triggered interrupts"
-	help
-
-	Enables support for shared edge-triggered interrupts, so that
-	multiple real-time interrupt handlers are allowed to control
-	dedicated hardware devices which are configured to share
-	the same interrupt channel.
-
-endmenu
-
 menu "LTT tracepoints filtering"
=20
 	depends on LTT
Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
  * Copyright (C) 2005,2006 Dmitry Adamushko <dmitry.adamushko@domain.hid>=
=2E
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
  *
  * Xenomai is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published
@@ -41,18 +42,6 @@
=20
 DEFINE_PRIVATE_XNLOCK(intrlock);
=20
-typedef struct xnintr_irq {
-
-	DECLARE_XNLOCK(lock);
-
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
-	xnintr_t *handlers;
-	int unhandled;
-#endif
-} ____cacheline_aligned_in_smp xnintr_irq_t;
-
-static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
-
 #ifdef CONFIG_XENO_OPT_STATS
 xnintr_t nkclock;	/* Only for statistics */
 int xnintr_count =3D 1;	/* Number of attached xnintr objects + nkclock *=
/
@@ -94,71 +83,7 @@ static inline void xnintr_stat_counter_d
 static inline void xnintr_sync_stat_references(xnintr_t *intr) {}
 #endif /* CONFIG_XENO_OPT_STATS */
=20
-/*
- * Low-level interrupt handler dispatching the ISRs -- Called with
- * interrupts off.
- */
-
-static void xnintr_irq_handler(unsigned irq, void *cookie)
-{
-	xnsched_t *sched =3D xnpod_current_sched();
-	xnintr_t *intr;
-	xnstat_runtime_t *prev;
-	xnticks_t start;
-	int s;
-
-	prev  =3D xnstat_runtime_get_current(sched);
-	start =3D xnstat_runtime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
-
-	++sched->inesting;
-
-	xnlock_get(&xnirqs[irq].lock);
-
-#ifdef CONFIG_SMP
-	/* In SMP case, we have to reload the cookie under the per-IRQ lock
-	   to avoid racing with xnintr_detach. */
-	intr =3D rthal_irq_cookie(&rthal_domain, irq);
-	if (unlikely(!intr)) {
-		s =3D 0;
-		goto unlock_and_exit;
-	}
-#else
-	/* cookie always valid, attach/detach happens with IRQs disabled */
-	intr =3D cookie;
-#endif
-	s =3D intr->isr(intr);
-
-	if (unlikely(s =3D=3D XN_ISR_NONE)) {
-		if (++intr->unhandled =3D=3D XNINTR_MAX_UNHANDLED) {
-			xnlogerr("%s: IRQ%d not handled. Disabling IRQ "
-				 "line.\n", __FUNCTION__, irq);
-			s |=3D XN_ISR_NOENABLE;
-		}
-	} else {
-		xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
-		xnstat_runtime_lazy_switch(sched,
-			&intr->stat[xnsched_cpu(sched)].account,
-			start);
-		intr->unhandled =3D 0;
-	}
-
-#ifdef CONFIG_SMP
- unlock_and_exit:
-#endif
-	xnlock_put(&xnirqs[irq].lock);
-
-	if (s & XN_ISR_PROPAGATE)
-		xnarch_chain_irq(irq);
-	else if (!(s & XN_ISR_NOENABLE))
-		xnarch_end_irq(irq);
-
-	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
-		xnpod_schedule();
-
-	xnltt_log_event(xeno_ev_iexit, irq);
-	xnstat_runtime_switch(sched, prev);
-}
+static void xnintr_irq_handler(unsigned irq, void *cookie);
=20
 /* Low-level clock irq handler. */
=20
@@ -205,14 +130,23 @@ void xnintr_clock_handler(void)
=20
 /* Optional support for shared interrupts. */
=20
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
+#ifdef CONFIG_XENO_OPT_SHIRQ
+
+typedef struct xnintr_irq {
+
+	DECLARE_XNLOCK(lock);
+
+	xnintr_t *handlers;
+	int unhandled;
+
+} ____cacheline_aligned_in_smp xnintr_irq_t;
+
+static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
=20
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
 /*
  * Low-level interrupt handler dispatching the user-defined ISRs for
  * shared interrupts -- Called with interrupts off.
  */
-
 static void xnintr_shirq_handler(unsigned irq, void *cookie)
 {
 	xnsched_t *sched =3D xnpod_current_sched();
@@ -272,14 +206,10 @@ static void xnintr_shirq_handler(unsigne
 	xnstat_runtime_switch(sched, prev);
 }
=20
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
-
-#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 /*
  * Low-level interrupt handler dispatching the user-defined ISRs for
  * shared edge-triggered interrupts -- Called with interrupts off.
  */
-
 static void xnintr_edge_shirq_handler(unsigned irq, void *cookie)
 {
 	const int MAX_EDGEIRQ_COUNTER =3D 128;
@@ -356,8 +286,6 @@ static void xnintr_edge_shirq_handler(un
 	xnstat_runtime_switch(sched, prev);
 }
=20
-#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
-
 static inline int xnintr_irq_attach(xnintr_t *intr)
 {
 	xnintr_irq_t *shirq =3D &xnirqs[intr->irq];
@@ -389,17 +317,9 @@ static inline int xnintr_irq_attach(xnin
=20
 		if (intr->flags & XN_ISR_SHARED) {
 			if (intr->flags & XN_ISR_EDGE)
-#if defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 				handler =3D &xnintr_edge_shirq_handler;
-#else /* !CONFIG_XENO_OPT_SHIRQ_EDGE */
-				return -ENOSYS;
-#endif /* CONFIG_XENO_OPT_SHIRQ_EDGE */
 			else
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL)
 				handler =3D &xnintr_shirq_handler;
-#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL */
-				return -ENOSYS;
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL */
=20
 		}
 		shirq->unhandled =3D 0;
@@ -457,7 +377,17 @@ static inline int xnintr_irq_detach(xnin
 	return err;
 }
=20
-#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+#else /* !CONFIG_XENO_OPT_SHIRQ */
+
+#ifdef CONFIG_SMP
+typedef struct xnintr_irq {
+
+	DECLARE_XNLOCK(lock);
+
+} ____cacheline_aligned_in_smp xnintr_irq_t;
+
+static xnintr_irq_t xnirqs[RTHAL_NR_IRQS];
+#endif /* CONFIG_SMP */
=20
 static inline int xnintr_irq_attach(xnintr_t *intr)
 {
@@ -477,7 +407,72 @@ static inline int xnintr_irq_detach(xnin
 	return err;
 }
=20
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+#endif /* !CONFIG_XENO_OPT_SHIRQ */
+
+/*
+ * Low-level interrupt handler dispatching non-shared ISRs -- Called wit=
h
+ * interrupts off.
+ */
+static void xnintr_irq_handler(unsigned irq, void *cookie)
+{
+	xnsched_t *sched =3D xnpod_current_sched();
+	xnintr_t *intr;
+	xnstat_runtime_t *prev;
+	xnticks_t start;
+	int s;
+
+	prev  =3D xnstat_runtime_get_current(sched);
+	start =3D xnstat_runtime_now();
+	xnltt_log_event(xeno_ev_ienter, irq);
+
+	++sched->inesting;
+
+	xnlock_get(&xnirqs[irq].lock);
+
+#ifdef CONFIG_SMP
+	/* In SMP case, we have to reload the cookie under the per-IRQ lock
+	   to avoid racing with xnintr_detach. */
+	intr =3D rthal_irq_cookie(&rthal_domain, irq);
+	if (unlikely(!intr)) {
+		s =3D 0;
+		goto unlock_and_exit;
+	}
+#else
+	/* cookie always valid, attach/detach happens with IRQs disabled */
+	intr =3D cookie;
+#endif
+	s =3D intr->isr(intr);
+
+	if (unlikely(s =3D=3D XN_ISR_NONE)) {
+		if (++intr->unhandled =3D=3D XNINTR_MAX_UNHANDLED) {
+			xnlogerr("%s: IRQ%d not handled. Disabling IRQ "
+				 "line.\n", __FUNCTION__, irq);
+			s |=3D XN_ISR_NOENABLE;
+		}
+	} else {
+		xnstat_counter_inc(&intr->stat[xnsched_cpu(sched)].hits);
+		xnstat_runtime_lazy_switch(sched,
+			&intr->stat[xnsched_cpu(sched)].account,
+			start);
+		intr->unhandled =3D 0;
+	}
+
+#ifdef CONFIG_SMP
+ unlock_and_exit:
+#endif
+	xnlock_put(&xnirqs[irq].lock);
+
+	if (s & XN_ISR_PROPAGATE)
+		xnarch_chain_irq(irq);
+	else if (!(s & XN_ISR_NOENABLE))
+		xnarch_end_irq(irq);
+
+	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
+		xnpod_schedule();
+
+	xnltt_log_event(xeno_ev_iexit, irq);
+	xnstat_runtime_switch(sched, prev);
+}
=20
 int xnintr_mount(void)
 {
@@ -598,9 +593,9 @@ int xnintr_init(xnintr_t *intr,
 	intr->flags =3D flags;
 	intr->unhandled =3D 0;
 	memset(&intr->stat, 0, sizeof(intr->stat));
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
+#ifdef CONFIG_XENO_OPT_SHIRQ
 	intr->next =3D NULL;
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+#endif
=20
 	return 0;
 }
@@ -849,7 +844,7 @@ int xnintr_irq_proc(unsigned int irq, ch
=20
 	xnlock_get_irqsave(&intrlock, s);
=20
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
+#ifdef CONFIG_XENO_OPT_SHIRQ
 	intr =3D xnirqs[irq].handlers;
 	if (intr) {
 		strcpy(p, "        "); p +=3D 8;
@@ -861,13 +856,13 @@ int xnintr_irq_proc(unsigned int irq, ch
 			intr =3D intr->next;
 		} while (intr);
 	}
-#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
+#else /* !CONFIG_XENO_OPT_SHIRQ */
 	intr =3D rthal_irq_cookie(&rthal_domain, irq);
 	if (intr) {
 		strcpy(p, "         "); p +=3D 9;
 		strcpy(p, intr->name); p +=3D strlen(intr->name);
 	}
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+#endif /* !CONFIG_XENO_OPT_SHIRQ */
=20
 	xnlock_put_irqrestore(&intrlock, s);
=20
@@ -897,21 +892,19 @@ int xnintr_query(int irq, int *cpu, xnin
 		goto unlock_and_exit;
 	}
=20
-#if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIR=
Q_EDGE)
-	if (*prev)
-		intr =3D (*prev)->next;
-	else if (irq =3D=3D XNARCH_TIMER_IRQ)
+	if (irq =3D=3D XNARCH_TIMER_IRQ)
 		intr =3D &nkclock;
+#ifdef CONFIG_XENO_OPT_SHIRQ
+	else if (*prev)
+		intr =3D (*prev)->next;
 	else
 		intr =3D xnirqs[irq].handlers;
-#else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
-	if (*prev)
+#else /* !CONFIG_XENO_OPT_SHIRQ */
+	else if (*prev)
 		intr =3D NULL;
-	else if (irq =3D=3D XNARCH_TIMER_IRQ)
-		intr =3D &nkclock;
 	else
 		intr =3D rthal_irq_cookie(&rthal_domain, irq);
-#endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */
+#endif /* !CONFIG_XENO_OPT_SHIRQ */
=20
 	if (!intr) {
 		err =3D -ENODEV;

--------------000509080202070400000702--

--------------enig0408ABC1CDC7E314B45FE918
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGjtUJniDOoMHTA+kRAm1+AJkB8Ki22bH/0W+lT3d7sHf8glHqVwCbBg7i
678b6aytMn6tXddZyoV+IWQ=
=Ohic
-----END PGP SIGNATURE-----

--------------enig0408ABC1CDC7E314B45FE918--

