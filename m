Message-ID: <472ED13D.4050703@domain.hid>
Date: Mon, 05 Nov 2007 09:15:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4717D8AC.8000900@domain.hid>	<FDBBB5CC70676540B3EF7CFE83FD94E0999445@domain.hid>
	<4718670D.6000008@domain.hid>
In-Reply-To: <4718670D.6000008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig558D4841D937C4B487026519"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] LTTng for Xenomai - next round
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
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig558D4841D937C4B487026519
Content-Type: multipart/mixed;
 boundary="------------060401040507050709090303"

This is a multi-part message in MIME format.
--------------060401040507050709090303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> Regarding the instrumentation: My latest Xenomai patch changed the
> marker arguments even more away from your original patch. Not looking a=
t
> the plugin for this, I may have removed useful information. Please let
> us know what you would like to see in the trace points so that this par=
t
> can quickly stabilise, maybe even go into the next Xenomai release.

I decided to accelerate the core instrumentation as it looks like I will
need it sooner than expected. So here comes another version of the
Xenomai-part of the patch series, changing the following:

 - Full conversion to trace_mark, no intermediate xnltt_log_event
   anymore. Unsupported kernel versions are caught by the wrapping layer
   instead. Thus, also ltt.h is obsolete now (bootstrap run is required
   for user land).

 - Refactoring of all pre-existing trace points, currently focusing on
   making text dumps of Xenomai LTTng events more readable. This
   definitely breaks the older LTTV plugin for Xenomai in various ways.

 - New trace points for the timer subsystem and for RTDM.

My personal plan would be to merge something like this patch before 2.4
release. The trace points should be declared as preliminary though,
because I bet we will stumble over a few suboptimal or lacking
instrumentations later on when starting to use this service on
development and production systems.

Jan

--------------060401040507050709090303
Content-Type: text/x-patch;
 name="lttng-v5.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="lttng-v5.patch"

---
 include/asm-generic/wrappers.h |    6 +
 include/nucleus/Makefile.am    |    1=20
 include/nucleus/ltt.h          |  140 ------------------------------
 include/rtdm/rtdm_driver.h     |    7 +
 ksrc/nucleus/Config.in         |    9 -
 ksrc/nucleus/Kconfig           |   36 -------
 ksrc/nucleus/Makefile          |    3=20
 ksrc/nucleus/intr.c            |   32 ++++---
 ksrc/nucleus/ltt.c             |  186 ----------------------------------=
-------
 ksrc/nucleus/module.c          |    8 -
 ksrc/nucleus/pod.c             |  126 +++++++++++++++++++--------
 ksrc/nucleus/shadow.c          |   48 +++++++---
 ksrc/nucleus/synch.c           |   20 +++-
 ksrc/nucleus/timebase.c        |   27 +++--
 ksrc/nucleus/timer.c           |   25 +++++
 ksrc/skins/rtdm/core.c         |   33 +++++++
 ksrc/skins/rtdm/device.c       |   21 ++++
 ksrc/skins/rtdm/drvlib.c       |   25 +++++
 18 files changed, 286 insertions(+), 467 deletions(-)

Index: xenomai/include/nucleus/ltt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/ltt.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
=2Enet>
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#ifndef _XENO_NUCLEUS_LTT_H
-#define _XENO_NUCLEUS_LTT_H
-
-#include <nucleus/types.h>
-
-#ifdef CONFIG_LTT
-
-#include <linux/ltt-core.h>
-
-struct xnltt_evmap {
-
-    char *ltt_label;	/* !< Event label (creation time). */
-    char *ltt_format;	/* !< Event format (creation time). */
-    int ltt_evid;	/* !< LTT custom event id. */
-    int ltt_filter;	/* !< Event filter. */
-};
-
-#define xeno_ev_ienter       0
-#define xeno_ev_iexit        1
-#define xeno_ev_resched      2
-#define xeno_ev_smpsched     3
-#define xeno_ev_fastsched    4
-#define xeno_ev_switch       5
-#define xeno_ev_fault        6
-#define xeno_ev_callout      7
-#define xeno_ev_finalize     8
-#define xeno_ev_thrinit      9
-#define xeno_ev_thrstart     10
-#define xeno_ev_threstart    11
-#define xeno_ev_thrdelete    12
-#define xeno_ev_thrsuspend   13
-#define xeno_ev_thresume     14
-#define xeno_ev_thrunblock   15
-#define xeno_ev_threnice     16
-#define xeno_ev_cpumigrate   17
-#define xeno_ev_sigdispatch  18
-#define xeno_ev_thrboot      19
-#define xeno_ev_tstick       20
-#define xeno_ev_sleepon      21
-#define xeno_ev_wakeup1      22
-#define xeno_ev_wakeupx      23
-#define xeno_ev_syncflush    24
-#define xeno_ev_syncforget   25
-#define xeno_ev_lohandler    26
-#define xeno_ev_primarysw    27
-#define xeno_ev_primary      28
-#define xeno_ev_secondarysw  29
-#define xeno_ev_secondary    30
-#define xeno_ev_shadowmap    31
-#define xeno_ev_shadowunmap  32
-#define xeno_ev_shadowstart  33
-#define xeno_ev_syscall      34
-#define xeno_ev_shadowexit   35
-#define xeno_ev_thrsetmode   36
-#define xeno_ev_rdrotate     37
-#define xeno_ev_rractivate   38
-#define xeno_ev_rrdeactivate 39
-#define xeno_ev_timeset      40
-#define xeno_ev_addhook      41
-#define xeno_ev_remhook      42
-#define xeno_ev_thrperiodic  43
-#define xeno_ev_thrwait      44
-#define xeno_ev_tsenable     45
-#define xeno_ev_tsdisable    46
-#define xeno_ev_mark         47
-#define xeno_ev_watchdog     48
-
-#define xeno_evthr  0x1
-#define xeno_evirq  0x2
-#define xeno_evsys  0x4
-#define xeno_evall  0x7
-
-#define XNLTT_MAX_EVENTS 64
-
-extern struct xnltt_evmap xnltt_evtable[];
-
-extern int xnltt_filter;
-
-#define xnltt_log_event(ev, args...) \
-do { \
-  if (xnltt_evtable[ev].ltt_filter & xnltt_filter) \
-    ltt_log_std_formatted_event(xnltt_evtable[ev].ltt_evid, ##args); \
-} while(0)
-
-static inline void xnltt_set_filter (int mask)
-{
-    xnltt_filter =3D mask;
-}
-
-static inline void xnltt_stop_tracing (void)
-{
-    xnltt_set_filter(0);
-}
-
-void xnltt_log_mark(const char *fmt,
-		    ...);
-
-int xnltt_mount(void);
-
-void xnltt_umount(void);
-
-#else /* !CONFIG_LTT */
-
-#define xnltt_log_event(ev, args...); /* Eat the semi-colon. */
-
-static inline void xnltt_log_mark (const char *fmt, ...)
-{
-}
-
-static inline void xnltt_set_filter (int mask)
-{
-}
-
-static inline void xnltt_stop_tracing (void)
-{
-}
-
-#endif /* CONFIG_LTT */
-
-#endif /* !_XENO_NUCLEUS_LTT_H_ */
Index: xenomai/ksrc/nucleus/intr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -34,7 +34,6 @@
=20
 #include <nucleus/pod.h>
 #include <nucleus/intr.h>
-#include <nucleus/ltt.h>
 #include <nucleus/stat.h>
 #include <asm/xenomai/bits/intr.h>
=20
@@ -98,9 +97,8 @@ void xnintr_clock_handler(void)
=20
 	xnarch_announce_tick();
=20
-	xnltt_log_event(xeno_ev_ienter, XNARCH_TIMER_IRQ);
-	xnltt_log_event(xeno_ev_tstick, nktbase.name,
-			xnpod_current_thread()->name);
+	trace_mark(xn_nucleus_irq_enter, "irq %d", XNARCH_TIMER_IRQ);
+	trace_mark(xn_nucleus_tbase_tick, "base %s", nktbase.name);
=20
 	++sched->inesting;
=20
@@ -124,7 +122,7 @@ void xnintr_clock_handler(void)
 		xnarch_relay_tick();
 	}
=20
-	xnltt_log_event(xeno_ev_iexit, XNARCH_TIMER_IRQ);
+	trace_mark(xn_nucleus_irq_exit, "irq %d", XNARCH_TIMER_IRQ);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -168,7 +166,7 @@ static void xnintr_shirq_handler(unsigne
=20
 	prev  =3D xnstat_exectime_get_current(sched);
 	start =3D xnstat_exectime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
+	trace_mark(xn_nucleus_irq_enter, "irq %d", irq);
=20
 	++sched->inesting;
=20
@@ -212,7 +210,7 @@ static void xnintr_shirq_handler(unsigne
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	trace_mark(xn_nucleus_irq_exit, "irq %d", irq);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -233,7 +231,7 @@ static void xnintr_edge_shirq_handler(un
=20
 	prev  =3D xnstat_exectime_get_current(sched);
 	start =3D xnstat_exectime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
+	trace_mark(xn_nucleus_irq_enter, "irq %d", irq);
=20
 	++sched->inesting;
=20
@@ -292,7 +290,7 @@ static void xnintr_edge_shirq_handler(un
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	trace_mark(xn_nucleus_irq_exit, "irq %d", irq);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -443,7 +441,7 @@ static void xnintr_irq_handler(unsigned=20
=20
 	prev  =3D xnstat_exectime_get_current(sched);
 	start =3D xnstat_exectime_now();
-	xnltt_log_event(xeno_ev_ienter, irq);
+	trace_mark(xn_nucleus_irq_enter, "irq %d", irq);
=20
 	++sched->inesting;
=20
@@ -490,7 +488,7 @@ static void xnintr_irq_handler(unsigned=20
 	if (--sched->inesting =3D=3D 0 && xnsched_resched_p())
 		xnpod_schedule();
=20
-	xnltt_log_event(xeno_ev_iexit, irq);
+	trace_mark(xn_nucleus_irq_exit, "irq %d", irq);
 	xnstat_exectime_switch(sched, prev);
 }
=20
@@ -695,6 +693,9 @@ int xnintr_attach(xnintr_t *intr, void *
 	int err;
 	spl_t s;
=20
+	trace_mark(xn_nucleus_irq_attach, "irq %u name %s",
+		   intr->irq, intr->name);
+
 	intr->cookie =3D cookie;
 	memset(&intr->stat, 0, sizeof(intr->stat));
=20
@@ -750,6 +751,8 @@ int xnintr_detach(xnintr_t *intr)
 	int err;
 	spl_t s;
=20
+	trace_mark(xn_nucleus_irq_detach, "irq %u", intr->irq);
+
 	xnlock_get_irqsave(&intrlock, s);
=20
 	err =3D xnintr_irq_detach(intr);
@@ -790,6 +793,8 @@ int xnintr_detach(xnintr_t *intr)
=20
 int xnintr_enable(xnintr_t *intr)
 {
+	trace_mark(xn_nucleus_irq_enable, "irq %u", intr->irq);
+
 	return xnarch_enable_irq(intr->irq);
 }
=20
@@ -820,6 +825,8 @@ int xnintr_enable(xnintr_t *intr)
=20
 int xnintr_disable(xnintr_t *intr)
 {
+	trace_mark(xn_nucleus_irq_disable, "irq %u", intr->irq);
+
 	return xnarch_disable_irq(intr->irq);
 }
=20
@@ -844,6 +851,9 @@ int xnintr_disable(xnintr_t *intr)
=20
 xnarch_cpumask_t xnintr_affinity(xnintr_t *intr, xnarch_cpumask_t cpumas=
k)
 {
+	trace_mark(xn_nucleus_irq_affinity, "irq %u %lu",
+		   intr->irq, *(unsigned long *)&cpumask);
+
 	return xnarch_set_irq_affinity(intr->irq, cpumask);
 }
=20
Index: xenomai/ksrc/nucleus/ltt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/ltt.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
=2Enet>
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA
- * 02139, USA; either version 2 of the License, or (at your option)
- * any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <stdarg.h>
-#include <nucleus/ltt.h>
-
-void xnltt_log_mark(const char *fmt, ...)
-{
-	char markbuf[64];	/* Don't eat too much stack space. */
-	va_list ap;
-
-	if (xnltt_evtable[xeno_ev_mark].ltt_filter & xnltt_filter) {
-		va_start(ap, fmt);
-		vsnprintf(markbuf, sizeof(markbuf), fmt, ap);
-		va_end(ap);
-		ltt_log_std_formatted_event(xnltt_evtable[xeno_ev_mark].
-					    ltt_evid, markbuf);
-	}
-}
-
-int __init xnltt_mount(void)
-{
-	int ev, evid;
-
-	/* Create all custom LTT events we need. */
-
-	for (ev =3D 0; xnltt_evtable[ev].ltt_label !=3D NULL; ev++) {
-		evid =3D ltt_create_event(xnltt_evtable[ev].ltt_label,
-					xnltt_evtable[ev].ltt_format,
-					LTT_CUSTOM_EV_FORMAT_TYPE_STR, NULL);
-		if (evid < 0) {
-			while (--ev >=3D 0) {
-				xnltt_evtable[ev].ltt_evid =3D -1;
-				ltt_destroy_event(xnltt_evtable[ev].ltt_evid);
-			}
-
-			return evid;
-		}
-
-		xnltt_evtable[ev].ltt_evid =3D evid;
-	}
-
-#ifdef CONFIG_XENO_OPT_FILTER_EVALL
-	xnltt_filter =3D ~xeno_evall;
-#else /* !CONFIG_XENO_OPT_FILTER_EVALL */
-#ifdef CONFIG_XENO_OPT_FILTER_EVIRQ
-	xnltt_filter &=3D ~xeno_evirq;
-#endif /* CONFIG_XENO_OPT_FILTER_EVIRQ */
-#ifdef CONFIG_XENO_OPT_FILTER_EVTHR
-	xnltt_filter &=3D ~xeno_evthr;
-#endif /* CONFIG_XENO_OPT_FILTER_EVTHR */
-#ifdef CONFIG_XENO_OPT_FILTER_EVSYS
-	xnltt_filter &=3D ~xeno_evthr;
-#endif /* CONFIG_XENO_OPT_FILTER_EVSYS */
-#endif /* CONFIG_XENO_OPT_FILTER_EVALL */
-
-	return 0;
-}
-
-void __exit xnltt_umount(void)
-{
-	int ev;
-
-	for (ev =3D 0; xnltt_evtable[ev].ltt_evid !=3D -1; ev++)
-		ltt_destroy_event(xnltt_evtable[ev].ltt_evid);
-}
-
-struct xnltt_evmap xnltt_evtable[] =3D {
-
-	[xeno_ev_ienter] =3D {"Xenomai i-enter", "irq=3D%d", -1, xeno_evirq},
-	[xeno_ev_iexit] =3D {"Xenomai i-exit", "irq=3D%d", -1, xeno_evirq},
-	[xeno_ev_resched] =3D {"Xenomai resched", NULL, -1, xeno_evthr},
-	[xeno_ev_smpsched] =3D {"Xenomai smpsched", NULL, -1, xeno_evthr},
-	[xeno_ev_fastsched] =3D {"Xenomai fastsched", NULL, -1, xeno_evthr},
-	[xeno_ev_switch] =3D {"Xenomai ctxsw", "%s -> %s", -1, xeno_evthr},
-	[xeno_ev_fault] =3D
-	    {"Xenomai fault", "thread=3D%s, location=3D%p, trap=3D%d", -1,
-	     xeno_evall},
-	[xeno_ev_callout] =3D
-	    {"Xenomai callout", "type=3D%s, thread=3D%s", -1, xeno_evall},
-	[xeno_ev_finalize] =3D {"Xenomai finalize", "%s -> %s", -1, xeno_evall}=
,
-	[xeno_ev_thrinit] =3D
-	    {"Xenomai thread init", "thread=3D%s, flags=3D0x%x", -1, xeno_evthr=
},
-	[xeno_ev_thrstart] =3D
-	    {"Xenomai thread start", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_threstart] =3D
-	    {"Xenomai thread restart", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_thrdelete] =3D
-	    {"Xenomai thread delete", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_thrsuspend] =3D {"Xenomai thread suspend",
-				"thread=3D%s, mask=3D0x%x, timeout=3D%Lu, wchan=3D%p",
-				-1, xeno_evthr},
-	[xeno_ev_thresume] =3D
-	    {"Xenomai thread resume", "thread=3D%s, mask=3D0x%x", -1, xeno_evth=
r},
-	[xeno_ev_thrunblock] =3D
-	    {"Xenomai thread unblock", "thread=3D%s, status=3D0x%x", -1,
-	     xeno_evthr},
-	[xeno_ev_threnice] =3D
-	    {"Xenomai thread renice", "thread=3D%s, prio=3D%d", -1, xeno_evthr}=
,
-	[xeno_ev_cpumigrate] =3D
-	    {"Xenomai CPU migrate", "thread=3D%s, cpu=3D%d", -1, xeno_evthr},
-	[xeno_ev_sigdispatch] =3D
-	    {"Xenomai sigdispatch", "thread=3D%s, sigpend=3D0x%x", -1, xeno_eva=
ll},
-	[xeno_ev_thrboot] =3D
-	    {"Xenomai thread begin", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_tstick] =3D {"Xenomai time source tick",
-			    "base=3D%s, runthread=3D%s", -1, xeno_evirq},
-	[xeno_ev_sleepon] =3D
-	    {"Xenomai sleepon", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_wakeup1] =3D
-	    {"Xenomai wakeup1", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_wakeupx] =3D
-	    {"Xenomai wakeupx", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_syncflush] =3D
-	    {"Xenomai syncflush", "sync=3D%p, reason=3D0x%x", -1, xeno_evthr},
-	[xeno_ev_syncforget] =3D
-	    {"Xenomai syncforget", "thread=3D%s, sync=3D%p", -1, xeno_evthr},
-	[xeno_ev_lohandler] =3D
-	    {"Xenomai lohandler", "type=3D%d, task=3D%s, pid=3D%d", -1, xeno_ev=
all},
-	[xeno_ev_primarysw] =3D {"Xenomai modsw1", "thread=3D%s", -1, xeno_evth=
r},
-	[xeno_ev_primary] =3D {"Xenomai modex1", "thread=3D%s", -1, xeno_evthr}=
,
-	[xeno_ev_secondarysw] =3D {"Xenomai modsw2", "thread=3D%s", -1, xeno_ev=
thr},
-	[xeno_ev_secondary] =3D {"Xenomai modex2", "thread=3D%s", -1, xeno_evth=
r},
-	[xeno_ev_shadowmap] =3D
-	    {"Xenomai shadow map", "thread=3D%s, pid=3D%d, prio=3D%d", -1,
-	     xeno_evthr},
-	[xeno_ev_shadowunmap] =3D
-	    {"Xenomai shadow unmap", "thread=3D%s, pid=3D%d", -1, xeno_evthr},
-	[xeno_ev_shadowstart] =3D
-	    {"Xenomai shadow start", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_syscall] =3D
-	    {"Xenomai syscall", "thread=3D%s, skin=3D%d, call=3D%d", -1, xeno_e=
vsys},
-	[xeno_ev_shadowexit] =3D
-	    {"Xenomai shadow exit", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_thrsetmode] =3D
-	    {"Xenomai thread setmode", "thread=3D%s, clrmask=3D0x%x, setmask=3D=
0x%x",
-	     -1,
-	     xeno_evthr},
-	[xeno_ev_rdrotate] =3D
-	    {"Xenomai rotate readyq", "thread=3D%s, prio=3D%d", -1, xeno_evthr}=
,
-	[xeno_ev_rractivate] =3D {"Xenomai RR on", "quantum=3D%Lu", -1, xeno_ev=
thr},
-	[xeno_ev_rrdeactivate] =3D {"Xenomai RR off", NULL, -1, xeno_evthr},
-	[xeno_ev_timeset] =3D {"Xenomai set time", "newtime=3D%Lu", -1, xeno_ev=
all},
-	[xeno_ev_addhook] =3D
-	    {"Xenomai add hook", "type=3D%d, routine=3D%p", -1, xeno_evall},
-	[xeno_ev_remhook] =3D
-	    {"Xenomai remove hook", "type=3D%d, routine=3D%p", -1, xeno_evall},=

-	[xeno_ev_thrperiodic] =3D
-	    {"Xenomai thread speriod", "thread=3D%s, idate=3D%Lu, period=3D%Lu"=
, -1,
-	     xeno_evthr},
-	[xeno_ev_thrwait] =3D
-	    {"Xenomai thread wperiod", "thread=3D%s", -1, xeno_evthr},
-	[xeno_ev_tsenable] =3D
-	    {"Xenomai enable time source", "tick=3D%u ns", -1, xeno_evall},
-	[xeno_ev_tsdisable] =3D {"Xenomai disable time source", NULL, -1, xeno_=
evall},
-	[xeno_ev_mark] =3D {"Xenomai **mark**", "%s", -1, xeno_evall},
-	[xeno_ev_watchdog] =3D
-	    {"Xenomai watchdog", "runthread=3D%s", -1, xeno_evall},
-	{NULL, NULL, -1, 0},
-};
-
-int xnltt_filter =3D xeno_evall;
-
-EXPORT_SYMBOL(xnltt_evtable);
-EXPORT_SYMBOL(xnltt_filter);
-EXPORT_SYMBOL(xnltt_log_mark);
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -40,7 +40,6 @@
 #include <nucleus/intr.h>
 #include <nucleus/registry.h>
 #include <nucleus/module.h>
-#include <nucleus/ltt.h>
 #include <nucleus/stat.h>
 #include <asm/xenomai/bits/pod.h>
=20
@@ -167,9 +166,10 @@ void xnpod_watchdog_handler(xntimer_t *t
 	}
 	=09
 	if (unlikely(++sched->wdcount >=3D CONFIG_XENO_OPT_WATCHDOG_TIMEOUT)) {=

-		xnltt_log_event(xeno_ev_watchdog, thread->name);
+		trace_mark(xn_nucleus_watchdog, "thread %p thread_name %s",
+			   thread, xnthread_name(thread));
 		xnprintf("watchdog triggered -- killing runaway thread '%s'\n",
-			 thread->name);
+			 xnthread_name(thread));
 		xnpod_delete_thread(thread);
 		xnpod_reset_watchdog(sched);
 	}
@@ -181,7 +181,7 @@ void xnpod_schedule_handler(void) /* Cal
 {
 	xnsched_t *sched =3D xnpod_current_sched();
=20
-	xnltt_log_event(xeno_ev_smpsched);
+	trace_mark(xe_nucleus_sched_remote, MARK_NOARGS);
 #if defined(CONFIG_SMP) && defined(CONFIG_XENO_OPT_PRIOCPL)
 	if (testbits(sched->status, XNRPICK)) {
 		clrbits(sched->status, XNRPICK);
@@ -549,11 +549,16 @@ static inline void xnpod_switch_zombie(x
 	int shadow =3D xnthread_test_state(threadout, XNSHADOW);
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
-	xnltt_log_event(xeno_ev_finalize, threadout->name, threadin->name);
+	trace_mark(xn_nucleus_sched_finalize,
+		   "thread_out %p thread_out_name %s "
+		   "thread_in %p thread_in_name %s",
+		   threadout, xnthread_name(threadout),
+		   threadin, xnthread_name(threadin));
=20
 	if (!emptyq_p(&nkpod->tdeleteq) && !xnthread_test_state(threadout, XNRO=
OT)) {
-		xnltt_log_event(xeno_ev_callout, "SELF-DELETE",
-				threadout->name);
+		trace_mark(xn_nucleus_thread_callout,
+			   "thread %p thread_name %s hook %s",
+			   threadout, xnthread_name(threadout), "DELETE");
 		xnpod_fire_callouts(&nkpod->tdeleteq, threadout);
 	}
=20
@@ -703,7 +708,9 @@ int xnpod_init_thread(xnthread_t *thread
 	if (err)
 		return err;
=20
-	xnltt_log_event(xeno_ev_thrinit, thread->name, flags);
+	trace_mark(xn_nucleus_thread_init,
+		   "thread %p thread_name %s flags %lu priority %d",
+		   thread, xnthread_name(thread), flags, prio);
=20
 	xnlock_get_irqsave(&nklock, s);
 	thread->sched =3D xnpod_current_sched();
@@ -835,7 +842,8 @@ int xnpod_start_thread(xnthread_t *threa
 	if (xnthread_test_state(thread, XNRRB))
 		thread->rrcredit =3D thread->rrperiod;
=20
-	xnltt_log_event(xeno_ev_thrstart, thread->name);
+	trace_mark(xn_nucleus_thread_start, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnthread_test_state(thread, XNSHADOW)) {
@@ -859,7 +867,9 @@ int xnpod_start_thread(xnthread_t *threa
 #endif /* __XENO_SIM__ */
=20
 	if (!emptyq_p(&nkpod->tstartq) && !xnthread_test_state(thread, XNROOT))=
 {
-		xnltt_log_event(xeno_ev_callout, "START", thread->name);
+		trace_mark(xn_nucleus_thread_callout,
+			   "thread %p thread_name %s hook %s",
+			   thread, xnthread_name(thread), "START");
 		xnpod_fire_callouts(&nkpod->tstartq, thread);
 	}
=20
@@ -916,7 +926,8 @@ void xnpod_restart_thread(xnthread_t *th
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_threstart, thread->name);
+	trace_mark(xn_nucleus_thread_restart, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
=20
 	/* Break the thread out of any wait it is currently in. */
 	xnpod_unblock_thread(thread);
@@ -1032,7 +1043,9 @@ xnflags_t xnpod_set_thread_mode(xnthread
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrsetmode, thread->name, clrmask, setmask);
+	trace_mark(xn_nucleus_thread_setmode,
+		   "thread %p thread_name %s clrmask %lu setmask %lu",
+		   thread, xnthread_name(thread), clrmask, setmask);
=20
 #ifndef CONFIG_XENO_OPT_ISHIELD
 	setmask &=3D ~XNSHIELD;
@@ -1165,7 +1178,8 @@ void xnpod_delete_thread(xnthread_t *thr
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20
-	xnltt_log_event(xeno_ev_thrdelete, thread->name);
+	trace_mark(xn_nucleus_thread_delete, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
=20
 	removeq(&nkpod->threadq, &thread->glink);
 	nkpod->threadq_rev++;
@@ -1202,8 +1216,9 @@ void xnpod_delete_thread(xnthread_t *thr
 	} else {
 		if (!emptyq_p(&nkpod->tdeleteq)
 		    && !xnthread_test_state(thread, XNROOT)) {
-			xnltt_log_event(xeno_ev_callout, "DELETE",
-					thread->name);
+			trace_mark(xn_nucleus_thread_callout,
+				   "thread %p thread_name %s hook %s",
+				   thread, xnthread_name(thread), "DELETE");
 			xnpod_fire_callouts(&nkpod->tdeleteq, thread);
 		}
=20
@@ -1350,7 +1365,11 @@ void xnpod_suspend_thread(xnthread_t *th
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrsuspend, thread->name, mask, timeout, wchan)=
;
+	trace_mark(xn_nucleus_thread_suspend,
+		   "thread %p thread_name %s mask %lu timeout %Lu "
+		   "timeout_mode %d wchan %p",
+		   thread, xnthread_name(thread), mask, timeout,
+		   timeout_mode, wchan);
=20
 	sched =3D thread->sched;
=20
@@ -1530,7 +1549,9 @@ void xnpod_resume_thread(xnthread_t *thr
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thresume, thread->name, mask);
+	trace_mark(xn_nucleus_thread_resume,
+		   "thread %p thread_name %s mask %lu",
+		   thread, xnthread_name(thread), mask);
 	xnarch_trace_pid(xnthread_user_task(thread) ?
 			 xnarch_user_pid(xnthread_archtcb(thread)) : -1,
 			 xnthread_current_priority(thread));
@@ -1671,7 +1692,10 @@ int xnpod_unblock_thread(xnthread_t *thr
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrunblock, xnthread_name(thread), xnthread_sta=
te_flags(thread));
+	trace_mark(xn_nucleus_thread_unblock,
+		   "thread %p thread_name %s state %lu",
+		   thread, xnthread_name(thread),
+		   xnthread_state_flags(thread));
=20
 	if (xnthread_test_state(thread, XNDELAY))
 		xnpod_resume_thread(thread, XNDELAY);
@@ -1754,7 +1778,9 @@ void xnpod_renice_thread_inner(xnthread_
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_threnice, thread->name, prio);
+	trace_mark(xn_nucleus_thread_renice,
+		   "thread %p thread_nmae %s priority %d",
+		   thread, xnthread_name(thread), prio);
=20
 	oldprio =3D thread->cprio;
=20
@@ -1835,7 +1861,9 @@ int xnpod_migrate_thread(int cpu)
 	if (cpu =3D=3D xnarch_current_cpu())
 		goto unlock_and_exit;
=20
-	xnltt_log_event(xeno_ev_cpumigrate, thread->name, cpu);
+	trace_mark(xn_nucleus_thread_migrate,
+		   "thread %p thread_name %s cpu %d",
+		   thread, xnthread_name(thread), cpu);
=20
 #ifdef CONFIG_XENO_HW_FPU
 	if (xnthread_test_state(thread, XNFPU)) {
@@ -1920,7 +1948,7 @@ void xnpod_rotate_readyq(int prio)
 	if (sched_emptypq_p(&sched->readyq))
 		goto unlock_and_exit;	/* Nobody is ready. */
=20
-	xnltt_log_event(xeno_ev_rdrotate, sched->runthread, prio);
+	trace_mark(xn_nucleus_sched_rotate, "priority %d", prio);
=20
 	/* There is _always_ a running thread, ultimately the root
 	   one. Use the base priority, not the priority boost. */
@@ -1974,7 +2002,7 @@ void xnpod_activate_rr(xnticks_t quantum
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_rractivate, quantum);
+	trace_mark(xn_nucleus_sched_rractivate, "quantum %Lu", quantum);
=20
 	holder =3D getheadq(&nkpod->threadq);
=20
@@ -2019,7 +2047,7 @@ void xnpod_deactivate_rr(void)
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_rrdeactivate);
+	trace_mark(xn_nucleus_sched_rrdeactivate, MARK_NOARGS);
=20
 	holder =3D getheadq(&nkpod->threadq);
=20
@@ -2061,7 +2089,8 @@ void xnpod_dispatch_signals(void)
 	    || thread->asr =3D=3D XNTHREAD_INVALID_ASR)
 		return;
=20
-	xnltt_log_event(xeno_ev_sigdispatch, thread->name, thread->signals);
+	trace_mark(xn_nucleus_sched_sigdispatch, "signals %lu",
+		   thread->signals);
=20
 	/* Start the asynchronous service routine */
 	oldmode =3D xnthread_test_state(thread, XNTHREAD_MODE_BITS);
@@ -2102,7 +2131,8 @@ void xnpod_dispatch_signals(void)
=20
 void xnpod_welcome_thread(xnthread_t *thread, int imask)
 {
-	xnltt_log_event(xeno_ev_thrboot, thread->name);
+	trace_mark(xn_nucleus_thread_boot, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
=20
 	xnarch_trace_pid(-1, xnthread_current_priority(thread));
=20
@@ -2346,7 +2376,7 @@ void xnpod_schedule(void)
 	if (xnarch_escalate())
 		return;
=20
-	xnltt_log_event(xeno_ev_resched);
+	trace_mark(xn_nucleus_sched, MARK_NOARGS);
 #endif /* __KERNEL__ */
=20
 	/* No immediate rescheduling is possible if an ISR or callout
@@ -2442,7 +2472,11 @@ void xnpod_schedule(void)
 	    !xnthread_test_state(threadout, XNRESTART))
 		goto signal_unlock_and_exit;
=20
-	xnltt_log_event(xeno_ev_switch, threadout->name, threadin->name);
+	trace_mark(xn_nucleus_sched_switch,
+		   "thread_out %p thread_out_name %s "
+		   "thread_in %p thread_in_name %s",
+		   threadout, xnthread_name(threadout),
+		   threadin, xnthread_name(threadin));
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	shadow =3D xnthread_test_state(threadout, XNSHADOW);
@@ -2509,7 +2543,9 @@ void xnpod_schedule(void)
 #endif /* __XENO_SIM__ */
=20
 	if (!emptyq_p(&nkpod->tswitchq) && !xnthread_test_state(runthread, XNRO=
OT)) {
-		xnltt_log_event(xeno_ev_callout, "SWITCH", runthread->name);
+		trace_mark(xn_nucleus_thread_callout,
+			   "thread %p thread_name %s hook %s",
+			   runthread, xnthread_name(runthread), "SWITCH");
 		xnpod_fire_callouts(&nkpod->tswitchq, runthread);
 	}
=20
@@ -2553,7 +2589,7 @@ void xnpod_schedule_runnable(xnthread_t=20
 	xnsched_t *sched =3D thread->sched;
 	xnthread_t *runthread =3D sched->runthread, *threadin;
=20
-	xnltt_log_event(xeno_ev_fastsched);
+	trace_mark(xn_nucleus_sched_fast, MARK_NOARGS);
 	xnarch_trace_pid(xnthread_user_task(thread) ?
 			 xnarch_user_pid(xnthread_archtcb(thread)) : -1,
 			 xnthread_current_priority(thread));
@@ -2719,7 +2755,8 @@ int xnpod_add_hook(int type, void (*rout
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_addhook, type, routine);
+	trace_mark(xn_nucleus_sched_addhook, "type %d routine %p",
+		   type, routine);
=20
 	switch (type) {
 	case XNHOOK_THREAD_START:
@@ -2789,7 +2826,8 @@ int xnpod_remove_hook(int type, void (*r
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_remhook, type, routine);
+	trace_mark(xn_nucleus_sched_removehook, "type %d routine %p",
+		   type, routine);
=20
 	switch (type) {
 	case XNHOOK_THREAD_START:
@@ -2873,9 +2911,10 @@ int xnpod_trap_fault(xnarch_fltinfo_t *f
=20
 	thread =3D xnpod_current_thread();
=20
-	xnltt_log_event(xeno_ev_fault,
-			thread->name,
-			xnarch_fault_pc(fltinfo), xnarch_fault_trap(fltinfo));
+	trace_mark(xn_nucleus_thread_fault,
+		   "thread %p thread_name %s address %lu type %d",
+		   thread, xnthread_name(thread), xnarch_fault_pc(fltinfo),
+		   xnarch_fault_trap(fltinfo));
=20
 #ifdef __KERNEL__
 	if (xnarch_fault_fpu_p(fltinfo)) {
@@ -3012,7 +3051,7 @@ int xnpod_enable_timesource(void)
 		return err;
 	}
=20
-	xnltt_log_event(xeno_ev_tsenable);
+	trace_mark(xn_nucleus_tbase_start, "base %s", nktbase.name);
=20
 #ifdef CONFIG_XENO_OPT_STATS
 	/*
@@ -3111,7 +3150,7 @@ void xnpod_disable_timesource(void)
 	spl_t s;
 	int cpu;
=20
-	xnltt_log_event(xeno_ev_tsdisable);
+	trace_mark(xn_nucleus_tbase_stop, "base %s", nktbase.name);
=20
 	xnlock_get_irqsave(&nklock, s);
=20
@@ -3201,7 +3240,10 @@ int xnpod_set_thread_periodic(xnthread_t
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_thrperiodic, thread->name, idate, period);
+	trace_mark(xn_nucleus_thread_setperiodic,
+		   "thread %p thread_name %s idate %Lu period %Lu timer %p",
+		   thread, xnthread_name(thread), idate, period,
+		   &thread->ptimer);
=20
 	if (period =3D=3D XN_INFINITE) {
 		if (xntimer_running_p(&thread->ptimer))
@@ -3304,7 +3346,8 @@ int xnpod_wait_thread_period(unsigned lo
 		goto unlock_and_exit;
 	}
=20
-	xnltt_log_event(xeno_ev_thrwait, thread->name);
+	trace_mark(xn_nucleus_thread_waitperiod, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
=20
 	/* Work with either TSC or periodic ticks. */
 	tbase =3D xnthread_time_base(thread);
@@ -3322,9 +3365,14 @@ int xnpod_wait_thread_period(unsigned lo
 	}
=20
 	overruns =3D xntimer_get_overruns(&thread->ptimer, now);
-	if (overruns)
+	if (overruns) {
 		err =3D -ETIMEDOUT;
=20
+		trace_mark(xn_nucleus_thread_missedperiod,
+			   "thread %p thread_name %s overruns %lu",
+			   thread, xnthread_name(thread), overruns);
+	}
+
 	if (likely(overruns_r !=3D NULL))
 		*overruns_r =3D overruns;
=20
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -46,7 +46,6 @@
 #include <nucleus/module.h>
 #include <nucleus/shadow.h>
 #include <nucleus/core.h>
-#include <nucleus/ltt.h>
 #include <nucleus/jhash.h>
 #include <nucleus/ppd.h>
 #include <nucleus/trace.h>
@@ -881,7 +880,8 @@ static void lostage_handler(void *cookie
 		struct task_struct *p =3D rq->req[reqnum].task;
 		rq->out =3D (reqnum + 1) & (LO_MAX_REQUESTS - 1);
=20
-		xnltt_log_event(xeno_ev_lohandler, reqnum, p->comm, p->pid);
+		trace_mark(xn_nucleus_lostage_work, "reqnum %d comm %s pid %d",
+			   reqnum, p->comm, p->pid);
=20
 		switch (rq->req[reqnum].type) {
 		case LO_UNMAP_REQ:
@@ -1094,7 +1094,9 @@ redo:
 	   preemption and using the TASK_ATOMICSWITCH cumulative state
 	   provided by Adeos to Linux tasks. */
=20
-	xnltt_log_event(xeno_ev_primarysw, this_task->comm);
+	trace_mark(xn_nucleus_shadow_go_hard,
+		   "thread %p thread_name %s comm %s",
+		   thread, xnthread_name(thread), this_task->comm);
=20
 	gk->thread =3D thread;
 	xnthread_set_info(thread, XNATOMIC);
@@ -1141,7 +1143,8 @@ redo:
 	if (rpi_p(thread))
 		rpi_clear_remote(thread);
=20
-	xnltt_log_event(xeno_ev_primary, thread->name);
+	trace_mark(xn_nucleus_shadow_hardened, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
=20
 	return 0;
 }
@@ -1186,7 +1189,8 @@ void xnshadow_relax(int notify)
 	   domain to the Linux domain.  This will cause the Linux task
 	   to resume using the register state of the shadow thread. */
=20
-	xnltt_log_event(xeno_ev_secondarysw, thread->name);
+	trace_mark(xn_nucleus_shadow_go_relax, "thread %p thread_name %s",
+		  thread, xnthread_name(thread));
=20
 	ishield_on(thread);
=20
@@ -1231,7 +1235,9 @@ void xnshadow_relax(int notify)
 	/* "current" is now running into the Linux domain on behalf of the
 	   root thread. */
=20
-	xnltt_log_event(xeno_ev_secondary, current->comm);
+	trace_mark(xn_nucleus_shadow_relaxed,
+		  "thread %p thread_name %s comm %s",
+		  thread, xnthread_name(thread), current->comm);
 }
=20
 void xnshadow_exit(void)
@@ -1327,9 +1333,10 @@ int xnshadow_map(xnthread_t *thread, xnc
 		}
 	}
=20
-	xnltt_log_event(xeno_ev_shadowmap,
-			thread->name, current->pid,
-			xnthread_base_priority(thread));
+	trace_mark(xn_nucleus_shadow_map,
+		   "thread %p thread_name %s pid %d priority %d",
+		   thread, xnthread_name(thread), current->pid,
+		   xnthread_base_priority(thread));
=20
 	/* Switch on propagation of normal kernel events for the bound
 	   task. This is basically a per-task event filter which
@@ -1387,7 +1394,9 @@ void xnshadow_unmap(xnthread_t *thread)
 	xnthread_clear_state(thread, XNMAPPED);
 	rpi_pop(thread);
=20
-	xnltt_log_event(xeno_ev_shadowunmap, thread->name, p ? p->pid : -1);
+	trace_mark(xn_nucleus_shadow_unmap,
+		   "thread %p thread_name %s pid %d",
+		   thread, xnthread_name(thread), p ? p->pid : -1);
=20
 	if (!p)
 		return;
@@ -1450,7 +1459,8 @@ void xnshadow_start(xnthread_t *thread)
 	struct task_struct *p =3D xnthread_archtcb(thread)->user_task;
=20
 	rpi_push(thread);	/* A shadow always starts in relaxed mode. */
-	xnltt_log_event(xeno_ev_shadowstart, thread->name);
+	trace_mark(xn_nucleus_shadow_start, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
 	xnpod_resume_thread(thread, XNDORMANT);
=20
 	if (p->state =3D=3D TASK_INTERRUPTIBLE)
@@ -1897,7 +1907,10 @@ static inline int do_hisyscall_event(uns
 	muxid =3D __xn_mux_id(regs);
 	muxop =3D __xn_mux_op(regs);
=20
-	xnltt_log_event(xeno_ev_syscall, thread->name, muxid, muxop);
+	trace_mark(xn_nucleus_syscall_histage,
+		   "thread %p thread_name %s muxid %d muxop %d",
+		   thread, thread ? xnthread_name(thread) : NULL,
+		   muxid, muxop);
=20
 	if (muxid < 0 || muxid > XENOMAI_MUX_NR ||
 	    muxop < 0 || muxop >=3D muxtable[muxid].props->nrcalls) {
@@ -2072,9 +2085,11 @@ static inline int do_losyscall_event(uns
 	muxid =3D __xn_mux_id(regs);
 	muxop =3D __xn_mux_op(regs);
=20
-	xnltt_log_event(xeno_ev_syscall,
-			xnpod_active_p() ? xnpod_current_thread()->name : "<system>",
-			muxid, muxop);
+	trace_mark(xn_nucleus_syscall_lostage,
+		   "thread %p thread_name %s muxid %d muxop %d",
+		   xnpod_active_p() ? xnpod_current_thread() : NULL,
+		   xnpod_active_p() ? xnthread_name(xnpod_current_thread()) : NULL,
+		   muxid, muxop);
=20
 	/* Processing a real-time skin syscall. */
=20
@@ -2150,7 +2165,8 @@ static inline void do_taskexit_event(str
 	xnpod_schedule();
=20
 	xnshadow_dereference_skin(magic);
-	xnltt_log_event(xeno_ev_shadowexit, thread->name);
+	trace_mark(xn_nucleus_shadow_exit, "thread %p thread_name %s",
+		   thread, xnthread_name(thread));
 }
=20
 RTHAL_DECLARE_EXIT_EVENT(taskexit_event);
Index: xenomai/ksrc/nucleus/synch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/synch.c
+++ xenomai/ksrc/nucleus/synch.c
@@ -35,7 +35,6 @@
 #include <nucleus/synch.h>
 #include <nucleus/thread.h>
 #include <nucleus/module.h>
-#include <nucleus/ltt.h>
=20
 /*!=20
  * \fn void xnsynch_init(xnsynch_t *synch, xnflags_t flags);
@@ -174,7 +173,9 @@ void xnsynch_sleep_on(xnsynch_t *synch,=20
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_sleepon, thread->name, synch);
+	trace_mark(xn_nucleus_synch_sleepon,
+		   "thread %p thread_name %s sync %p",
+		   thread, xnthread_name(thread), synch);
=20
 	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
 		appendpq(&synch->pendq, &thread->plink);
@@ -388,7 +389,9 @@ xnthread_t *xnsynch_wakeup_one_sleeper(x
 		thread->wchan =3D NULL;
 		synch->owner =3D thread;
 		xnthread_set_info(thread, XNWAKEN);
-		xnltt_log_event(xeno_ev_wakeup1, thread->name, synch);
+		trace_mark(xn_nucleus_synch_wakeup_one,
+			   "thread %p thread_name %s sync %p",
+			   thread, xnthread_name(thread), synch);
 		xnpod_resume_thread(thread, XNPEND);
 	} else
 		synch->owner =3D NULL;
@@ -461,7 +464,9 @@ xnpholder_t *xnsynch_wakeup_this_sleeper
 	thread->wchan =3D NULL;
 	synch->owner =3D thread;
 	xnthread_set_info(thread, XNWAKEN);
-	xnltt_log_event(xeno_ev_wakeupx, thread->name, synch);
+	trace_mark(xn_nucleus_synch_wakeup_all,
+		   "thread %p thread_name %s synch %p",
+		   thread, xnthread_name(thread), synch);
 	xnpod_resume_thread(thread, XNPEND);
=20
 	if (testbits(synch->status, XNSYNCH_CLAIMED))
@@ -531,7 +536,8 @@ int xnsynch_flush(xnsynch_t *synch, xnfl
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_syncflush, synch, reason);
+	trace_mark(xn_nucleus_synch_flush, "synch %p reason %lu",
+		   synch, reason);
=20
 	status =3D emptypq_p(&synch->pendq) ? XNSYNCH_DONE : XNSYNCH_RESCHED;
=20
@@ -577,7 +583,9 @@ void xnsynch_forget_sleeper(xnthread_t *
 {
 	xnsynch_t *synch =3D thread->wchan;
=20
-	xnltt_log_event(xeno_ev_syncforget, thread->name, synch);
+	trace_mark(xn_nucleus_synch_forget,
+		   "thread %p thread_name %s synch %p",
+		   thread, xnthread_name(thread), synch);
=20
 	xnthread_clear_state(thread, XNPEND);
 	thread->wchan =3D NULL;
Index: xenomai/ksrc/nucleus/timebase.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timebase.c
+++ xenomai/ksrc/nucleus/timebase.c
@@ -53,7 +53,6 @@
=20
 #include <nucleus/pod.h>
 #include <nucleus/timer.h>
-#include <nucleus/ltt.h>
 #include <nucleus/module.h>
=20
 DEFINE_XNQUEUE(nktimebaseq);
@@ -378,19 +377,21 @@ void xntbase_start(xntbase_t *base)
 	xnticks_t start_date;
 	spl_t s;
=20
- 	if (base =3D=3D &nktbase || xntbase_enabled_p(base))
+	if (base =3D=3D &nktbase || xntbase_enabled_p(base))
 		return;
=20
+	trace_mark(xn_nucleus_tbase_start, "base %s", base->name);
+
 	xnlock_get_irqsave(&nklock, s);
=20
-  	start_date =3D xnarch_get_cpu_time();
+	start_date =3D xnarch_get_cpu_time();
=20
- 	/* Only synchronise non-isolated time bases on the master base. */
- 	if (!xntbase_isolated_p(base)) {
- 		base->wallclock_offset =3D xntbase_ns2ticks(base,
- 			start_date + nktbase.wallclock_offset);
- 		__setbits(base->status, XNTBSET);
- 	}
+	/* Only synchronise non-isolated time bases on the master base. */
+	if (!xntbase_isolated_p(base)) {
+		base->wallclock_offset =3D xntbase_ns2ticks(base,
+			start_date + nktbase.wallclock_offset);
+		__setbits(base->status, XNTBSET);
+	}
=20
 	start_date +=3D base->tickvalue;
=20
@@ -433,6 +434,8 @@ void xntbase_stop(xntbase_t *base)
=20
 	xntslave_stop(base2slave(base));
 	__clrbits(base->status, XNTBRUN | XNTBSET);
+
+	trace_mark(xn_nucleus_tbase_stop, "base %s", base->name);
 }
=20
 /*!
@@ -469,8 +472,7 @@ void xntbase_tick(xntbase_t *base)
=20
 	xnlock_get_irqsave(&nklock, s);
=20
-	xnltt_log_event(xeno_ev_tstick, base->name,
-			xnpod_current_thread()->name);
+	trace_mark(xn_nucleus_tbase_tick, "base %s", base->name);
=20
 	if (base =3D=3D &nktbase)
 		xntimer_tick_aperiodic();
@@ -565,7 +567,8 @@ void xntbase_adjust_time(xntbase_t *base
 	}
 #endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
=20
-	/* xnltt_log_event(xeno_ev_timeadjust, base->name, delta); */
+	trace_mark(xn_nucleus_tbase_adjust, "base %s delta %Lu",
+		   base->name, delta);
 }
=20
 /* The master time base - the most precise one, aperiodic, always valid.=
 */
Index: xenomai/ksrc/nucleus/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Config.in
+++ xenomai/ksrc/nucleus/Config.in
@@ -60,15 +60,6 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" !=3D "n" ]
 	fi
 	endmenu
=20
-	if [ "$CONFIG_LTT" !=3D "n" ]; then
-		mainmenu_option next_comment
-		comment 'LTT tracepoints filtering'
-			bool 'Disable IRQ-related tracepoints' CONFIG_XENO_OPT_FILTER_EVIRQ
-			bool 'Disable thread-related tracepoints' CONFIG_XENO_OPT_FILTER_EVTH=
R
-			bool 'Disable syscall-related tracepoints' CONFIG_XENO_OPT_FILTER_EVS=
YS
-			bool 'Disable all tracepoints' CONFIG_XENO_OPT_FILTER_EVALL
-		endmenu
-	fi
 	endmenu
 fi
=20
Index: xenomai/ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Kconfig
+++ xenomai/ksrc/nucleus/Kconfig
@@ -339,40 +339,4 @@ config XENO_OPT_TIMER_WHEEL_STEP
=20
 endmenu
=20
-menu "LTT tracepoints filtering"
-
-	depends on LTT
-
-config XENO_OPT_FILTER_EVIRQ
-	bool "Disable IRQ-related tracepoints"
-	default y if XENO_OPT_FILTER_EVALL=3Dy
-	help
-
-	When LTT support is active, this option disables tracepoints
-	inside real-time interrupt handlers.
-
-config XENO_OPT_FILTER_EVTHR
-	bool "Disable thread-related tracepoints"
-	default y if XENO_OPT_FILTER_EVALL=3Dy
-	help
-
-	When LTT support is active, this option disables tracepoints
-	inside most thread-related services.
-
-config XENO_OPT_FILTER_EVSYS
-	bool "Disable syscall-related tracepoints"
-	default y if XENO_OPT_FILTER_EVALL=3Dy
-	help
-
-	When LTT support is active, this option disables tracepoints
-	inside the shadow syscall dispatcher.
-
-config XENO_OPT_FILTER_EVALL
-	bool "Disable all tracepoints"
-	help
-
-	This option disables all LTT tracepoints inside Xenomai.
-
-endmenu
-
 endif
Index: xenomai/ksrc/nucleus/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Makefile
+++ xenomai/ksrc/nucleus/Makefile
@@ -14,8 +14,6 @@ xeno_nucleus-$(CONFIG_XENO_OPT_MAP) +=3D m
=20
 xeno_nucleus-$(CONFIG_XENO_OPT_REGISTRY) +=3D registry.o
=20
-xeno_nucleus-$(CONFIG_LTT) +=3D ltt.o
-
 EXTRA_CFLAGS +=3D -D__IN_XENOMAI__ -Iinclude/xenomai
=20
 else
@@ -35,7 +33,6 @@ opt_objs-$(CONFIG_XENO_OPT_PERVASIVE) +=3D
 opt_objs-$(CONFIG_XENO_OPT_PIPE) +=3D pipe.o
 opt_objs-$(CONFIG_XENO_OPT_MAP) +=3D map.o
 opt_objs-$(CONFIG_XENO_OPT_REGISTRY) +=3D registry.o
-opt_objs-$(CONFIG_LTT) +=3D ltt.o
=20
 xeno_nucleus-objs +=3D $(opt_objs-y)
=20
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -34,7 +34,6 @@
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 #include <nucleus/core.h>
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
-#include <nucleus/ltt.h>
 #include <asm/xenomai/bits/init.h>
=20
 MODULE_DESCRIPTION("Xenomai nucleus");
@@ -1156,10 +1155,6 @@ int __init __xeno_sys_init(void)
=20
 	xnintr_mount();
=20
-#ifdef CONFIG_LTT
-	xnltt_mount();
-#endif /* CONFIG_LTT */
-
 #ifdef CONFIG_XENO_OPT_PIPE
 	err =3D xnpipe_mount();
=20
@@ -1249,9 +1244,6 @@ void __exit __xeno_sys_exit(void)
 #ifdef CONFIG_XENO_OPT_PIPE
 	xnpipe_umount();
 #endif /* CONFIG_XENO_OPT_PIPE */
-#ifdef CONFIG_LTT
-	xnltt_umount();
-#endif /* CONFIG_LTT */
 #endif /* __KERNEL__ */
=20
 	if (nkmsgbuf)
Index: xenomai/include/asm-generic/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/wrappers.h
+++ xenomai/include/asm-generic/wrappers.h
@@ -275,4 +275,10 @@ unsigned long __va_to_kva(unsigned long=20
 #define IRQF_SHARED			SA_SHIRQ
 #endif /* < 2.6.18 */
=20
+#if defined(CONFIG_MARKERS) || LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,=
6,24)
+#include <linux/marker.h>
+#else /* !CONFIG_MARKERS */
+#define xnltt_log_event(ev, fmt, args...)	do { } while (0)
+#endif /* CONFIG_MARKERS */
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -170,6 +170,10 @@ int xntimer_start_aperiodic(xntimer_t *t
 {
 	xnticks_t date, now;
=20
+	trace_mark(xn_nucleus_timer_start,
+		   "timer %p base %s value %Lu interval %Lu mode %u",
+		   timer, timer->base->name, value, interval, mode);
+
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_aperiodic(timer);
=20
@@ -218,6 +222,8 @@ void xntimer_stop_aperiodic(xntimer_t *t
 {
 	int heading;
=20
+	trace_mark(xn_nucleus_timer_stop, "timer %p", timer);
+
 	heading =3D xntimer_heading_p(timer);
 	xntimer_dequeue_aperiodic(timer);
=20
@@ -294,6 +300,8 @@ void xntimer_tick_aperiodic(void)
 			   dates are ordered by increasing values. */
 			break;
=20
+		trace_mark(xn_nucleus_timer_expire, "timer %p", timer);
+
 		xntimer_dequeue_aperiodic(timer);
 		xnstat_counter_inc(&timer->fired);
=20
@@ -371,6 +379,10 @@ static int xntimer_start_periodic(xntime
 				  xnticks_t value, xnticks_t interval,
 				  xntmode_t mode)
 {
+	trace_mark(xn_nucleus_timer_start,
+		   "timer %p base %s value %Lu interval %Lu mode %u",
+		   timer, timer->base->name, value, interval, mode);
+
 	if (!testbits(timer->status, XNTIMER_DEQUEUED))
 		xntimer_dequeue_periodic(timer);
=20
@@ -406,6 +418,8 @@ static int xntimer_start_periodic(xntime
=20
 static void xntimer_stop_periodic(xntimer_t *timer)
 {
+	trace_mark(xn_nucleus_timer_stop, "timer %p", timer);
+
 	xntimer_dequeue_periodic(timer);
 }
=20
@@ -488,6 +502,8 @@ void xntimer_tick_periodic_inner(xntslav
 				  - base->jiffies) > 0)
 			break;
=20
+		trace_mark(xn_nucleus_timer_expire, "timer %p", timer);
+
 		xntimer_dequeue_periodic(timer);
 		xnstat_counter_inc(&timer->fired);
=20
@@ -625,6 +641,8 @@ void xntslave_start(xntslave_t *slave, x
 	int nr_cpus, cpu;
 	spl_t s;
=20
+	trace_mark(xn_nucleus_tbase_start, "base %s", slave->base.name);
+
 	for (cpu =3D 0, nr_cpus =3D xnarch_num_online_cpus(); cpu < nr_cpus; cp=
u++) {
=20
 		struct percpu_cascade *pc =3D &slave->cascade[cpu];
@@ -642,6 +660,8 @@ void xntslave_stop(xntslave_t *slave)
 	int nr_cpus, cpu;
 	spl_t s;
=20
+	trace_mark(xn_nucleus_tbase_stop, "base %s", slave->base.name);
+
 	for (cpu =3D 0, nr_cpus =3D xnarch_num_online_cpus(); cpu < nr_cpus; cp=
u++) {
=20
 		struct percpu_cascade *pc =3D &slave->cascade[cpu];
@@ -837,6 +857,9 @@ int xntimer_migrate(xntimer_t *timer, xn
 	int queued;
 	spl_t s;
=20
+	trace_mark(xn_nucleus_timer_migrate, "timer %p cpu %d",
+		   timer, xnsched_cpu(sched));
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	if (sched =3D=3D timer->sched)
@@ -932,6 +955,8 @@ void xntimer_freeze(void)
 	int nr_cpus, cpu;
 	spl_t s;
=20
+	trace_mark(xn_nucleus_timer_freeze, MARK_NOARGS);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	nr_cpus =3D xnarch_num_online_cpus();
Index: xenomai/include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/rtdm/rtdm_driver.h
+++ xenomai/include/rtdm/rtdm_driver.h
@@ -1019,11 +1019,13 @@ void __rtdm_synch_flush(xnsynch_t *synch
=20
 static inline void rtdm_event_pulse(rtdm_event_t *event)
 {
+	trace_mark(xn_rtdm_event_pulse, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, 0);
 }
=20
 static inline void rtdm_event_destroy(rtdm_event_t *event)
 {
+	trace_mark(xn_rtdm_event_destroy, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, XNRMID);
 }
 #endif /* !DOXYGEN_CPP */
@@ -1044,6 +1046,7 @@ void rtdm_sem_up(rtdm_sem_t *sem);
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void rtdm_sem_destroy(rtdm_sem_t *sem)
 {
+	trace_mark(xn_rtdm_sem_destroy, "sem %p", sem);
 	__rtdm_synch_flush(&sem->synch_base, XNRMID);
 }
 #endif /* !DOXYGEN_CPP */
@@ -1064,12 +1067,16 @@ static inline void rtdm_mutex_unlock(rtd
 {
 	XENO_ASSERT(RTDM, !xnpod_asynch_p(), return;);
=20
+	trace_mark(xn_rtdm_mutex_unlock, "mutex %p", mutex);
+
 	if (unlikely(xnsynch_wakeup_one_sleeper(&mutex->synch_base) !=3D NULL))=

 		xnpod_schedule();
 }
=20
 static inline void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
 {
+	trace_mark(xn_rtdm_mutex_destroy, "mutex %p", mutex);
+
 	__rtdm_synch_flush(&mutex->synch_base, XNRMID);
 }
 #endif /* !DOXYGEN_CPP */
Index: xenomai/ksrc/skins/rtdm/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/rtdm/core.c
+++ xenomai/ksrc/skins/rtdm/core.c
@@ -204,6 +204,8 @@ int __rt_dev_open(rtdm_user_info_t *user
 	int nrt_mode =3D !rtdm_in_rt_context();
=20
 	device =3D get_named_device(path);
+	trace_mark(xn_rtdm_open, "user_info %p path %s oflag %d device %p",
+		   user_info, path, oflag, device);
 	ret =3D -ENODEV;
 	if (!device)
 		goto err_out;
@@ -227,6 +229,8 @@ int __rt_dev_open(rtdm_user_info_t *user
=20
 	fildes->context =3D context;
=20
+	trace_mark(xn_rtdm_fd_created, "device %p fd %d", device, context->fd);=

+
 	return context->fd;
=20
 cleanup_out:
@@ -250,6 +254,9 @@ int __rt_dev_socket(rtdm_user_info_t *us
 	int nrt_mode =3D !rtdm_in_rt_context();
=20
 	device =3D get_protocol_device(protocol_family, socket_type);
+	trace_mark(xn_rtdm_socket, "user_info %p protocol_family %d "
+		   "socket_type %d protocol %d device %p",
+		   user_info, protocol_family, socket_type, protocol, device);
 	ret =3D -EAFNOSUPPORT;
 	if (!device)
 		goto err_out;
@@ -273,6 +280,8 @@ int __rt_dev_socket(rtdm_user_info_t *us
=20
 	fildes->context =3D context;
=20
+	trace_mark(xn_rtdm_fd_created, "device %p fd %d", device, context->fd);=

+
 	return context->fd;
=20
 cleanup_out:
@@ -292,6 +301,8 @@ int __rt_dev_close(rtdm_user_info_t *use
 	int ret;
 	int nrt_mode =3D !rtdm_in_rt_context();
=20
+	trace_mark(xn_rtdm_close, "user_info %p fd %d", user_info, fd);
+
 	ret =3D -EBADF;
 	if (unlikely((unsigned int)fd >=3D RTDM_FD_MAX))
 		goto err_out;
@@ -350,6 +361,8 @@ again:
 			 test_bit(RTDM_CREATED_IN_NRT, &context->context_flags),
 			 s);
=20
+	trace_mark(xn_rtdm_fd_closed, "fd %d", fd);
+
 	return ret;
=20
 unlock_out:
@@ -413,6 +426,7 @@ do {									\
 	rtdm_context_unlock(context);					\
 									\
 err_out:								\
+	trace_mark(xn_rtdm_##operation##_done, "result %d", ret);	\
 	return ret;							\
 } while (0)
=20
@@ -431,6 +445,9 @@ int __rt_dev_ioctl(rtdm_user_info_t *use
 	arg =3D va_arg(args, void __user *);
 	va_end(args);
=20
+	trace_mark(xn_rtdm_ioctl, "user_info %p fd %d request %d arg %p",
+		   user_info, fd, request, arg);
+
 	MAJOR_FUNCTION_WRAPPER_TH(ioctl, (unsigned int)request, arg);
=20
 	if (unlikely(ret < 0) && (unsigned int)request =3D=3D RTIOC_DEVICE_INFO=
) {
@@ -454,6 +471,8 @@ EXPORT_SYMBOL(__rt_dev_ioctl);
 ssize_t __rt_dev_read(rtdm_user_info_t *user_info, int fd, void *buf,
 		      size_t nbyte)
 {
+	trace_mark(xn_rtdm_read, "user_info %p fd %d buf %p nbyte %zu",
+		   user_info, fd, buf, nbyte);
 	MAJOR_FUNCTION_WRAPPER(read, buf, nbyte);
 }
=20
@@ -462,6 +481,8 @@ EXPORT_SYMBOL(__rt_dev_read);
 ssize_t __rt_dev_write(rtdm_user_info_t *user_info, int fd, const void *=
buf,
 		       size_t nbyte)
 {
+	trace_mark(xn_rtdm_write, "user_info %p fd %d buf %p nbyte %zu",
+		   user_info, fd, buf, nbyte);
 	MAJOR_FUNCTION_WRAPPER(write, buf, nbyte);
 }
=20
@@ -470,6 +491,12 @@ EXPORT_SYMBOL(__rt_dev_write);
 ssize_t __rt_dev_recvmsg(rtdm_user_info_t *user_info, int fd,
 			 struct msghdr *msg, int flags)
 {
+	trace_mark(xn_rtdm_recvmsg, "user_info %p fd %d msg_name %p "
+		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
+		   "msg_control %p msg_controllen %zu msg_flags %d",
+		   user_info, fd, msg->msg_name, msg->msg_namelen,
+		   msg->msg_iov, msg->msg_iovlen, msg->msg_control,
+		   msg->msg_controllen, msg->msg_flags);
 	MAJOR_FUNCTION_WRAPPER(recvmsg, msg, flags);
 }
=20
@@ -478,6 +505,12 @@ EXPORT_SYMBOL(__rt_dev_recvmsg);
 ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
 			 const struct msghdr *msg, int flags)
 {
+	trace_mark(xn_rtdm_recvmsg, "user_info %p fd %d msg_name %p "
+		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
+		   "msg_control %p msg_controllen %zu msg_flags %d",
+		   user_info, fd, msg->msg_name, msg->msg_namelen,
+		   msg->msg_iov, msg->msg_iovlen, msg->msg_control,
+		   msg->msg_controllen, msg->msg_flags);
 	MAJOR_FUNCTION_WRAPPER(sendmsg, msg, flags);
 }
=20
Index: xenomai/ksrc/skins/rtdm/device.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/rtdm/device.c
+++ xenomai/ksrc/skins/rtdm/device.c
@@ -263,6 +263,13 @@ int rtdm_dev_register(struct rtdm_device
 	down(&nrt_dev_lock);
=20
 	if ((device->device_flags & RTDM_DEVICE_TYPE_MASK) =3D=3D RTDM_NAMED_DE=
VICE) {
+		trace_mark(xn_rtdm_nameddev_register, "device %p name %s "
+			   "flags %d class %d sub_class %d profile_version %d "
+			   "driver_version %d", device, device->device_name,
+			   device->device_flags, device->device_class,
+			   device->device_sub_class, device->profile_version,
+			   device->driver_version);
+
 		hashkey =3D
 		    get_name_hash(device->device_name, RTDM_MAX_DEVNAME_LEN,
 				  name_hashkey_mask);
@@ -290,6 +297,15 @@ int rtdm_dev_register(struct rtdm_device
=20
 		up(&nrt_dev_lock);
 	} else {
+		trace_mark(xn_rtdm_protocol_register, "device %p "
+			   "protocol_family %d socket_type %d flags %d "
+			   "class %d sub_class %d profile_version %d "
+			   "driver_version %d", device,
+			   device->protocol_family, device->socket_type,
+			   device->device_flags, device->device_class,
+			   device->device_sub_class, device->profile_version,
+			   device->driver_version);
+
 		hashkey =3D get_proto_hash(device->protocol_family,
 					 device->socket_type);
=20
@@ -372,6 +388,9 @@ int rtdm_dev_unregister(struct rtdm_devi
 	if (!reg_dev)
 		return -ENODEV;
=20
+	trace_mark(xn_rtdm_dev_unregister, "device %p poll_delay %u",
+		   device, poll_delay);
+
 	down(&nrt_dev_lock);
 	xnlock_get_irqsave(&rt_dev_lock, s);
=20
@@ -381,6 +400,7 @@ int rtdm_dev_unregister(struct rtdm_devi
=20
 		if (!poll_delay) {
 			rtdm_dereference_device(reg_dev);
+			trace_mark(xn_rtdm_dev_busy, "device %p", device);
 			return -EAGAIN;
 		}
=20
@@ -388,6 +408,7 @@ int rtdm_dev_unregister(struct rtdm_devi
 			xnlogwarn("RTDM: device %s still in use - waiting for "
 				  "release...\n", reg_dev->device_name);
 		msleep(poll_delay);
+		trace_mark(xn_rtdm_dev_poll, "device %p", device);
=20
 		down(&nrt_dev_lock);
 		xnlock_get_irqsave(&rt_dev_lock, s);
Index: xenomai/ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/rtdm/drvlib.c
+++ xenomai/ksrc/skins/rtdm/drvlib.c
@@ -408,6 +408,9 @@ void rtdm_task_join_nrt(rtdm_task_t *tas
=20
 	XENO_ASSERT(RTDM, xnpod_root_p(), return;);
=20
+	trace_mark(xn_rtdm_task_joinnrt, "thread %p poll_delay %u",
+		   task, poll_delay);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	while (!xnthread_test_state(task, XNZOMBIE)) {
@@ -745,6 +748,8 @@ void rtdm_event_init(rtdm_event_t *event
 {
 	spl_t s;
=20
+	trace_mark(xn_rtdm_event_init, "event %p pending %lu", event, pending);=

+
 	/* Make atomic for re-initialisation support */
 	xnlock_get_irqsave(&nklock, s);
=20
@@ -822,6 +827,8 @@ void rtdm_event_signal(rtdm_event_t *eve
 {
 	spl_t s;
=20
+	trace_mark(xn_rtdm_event_signal, "event %p", event);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
@@ -911,6 +918,10 @@ int rtdm_event_timedwait(rtdm_event_t *e
=20
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
=20
+	trace_mark(xn_rtdm_event_timedwait,
+		   "event %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
+		   event, timeout, timeout_seq, timeout_seq ? *timeout_seq : 0);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	if (unlikely(testbits(event->synch_base.status, RTDM_SYNCH_DELETED)))
@@ -979,6 +990,8 @@ void rtdm_event_clear(rtdm_event_t *even
 {
 	spl_t s;
=20
+	trace_mark(xn_rtdm_event_clear, "event %p", event);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDING);
@@ -1014,6 +1027,8 @@ void rtdm_sem_init(rtdm_sem_t *sem, unsi
 {
 	spl_t s;
=20
+	trace_mark(xn_rtdm_sem_init, "sem %p value %lu", sem, value);
+
 	/* Make atomic for re-initialisation support */
 	xnlock_get_irqsave(&nklock, s);
=20
@@ -1125,6 +1140,10 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
=20
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
=20
+	trace_mark(xn_rtdm_sem_timedwait,
+		   "sem %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
+		   sem, timeout, timeout_seq, timeout_seq ? *timeout_seq : 0);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
@@ -1188,6 +1207,8 @@ void rtdm_sem_up(rtdm_sem_t *sem)
 {
 	spl_t s;
=20
+	trace_mark(xn_rtdm_sem_up, "sem %p", sem);
+
 	xnlock_get_irqsave(&nklock, s);
=20
 	if (xnsynch_wakeup_one_sleeper(&sem->synch_base))
@@ -1349,6 +1370,10 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *m
 	spl_t s;
 	int err =3D 0;
=20
+	trace_mark(xn_rtdm_mutex_timedlock,
+		   "mutex %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
+		   mutex, timeout, timeout_seq, timeout_seq ? *timeout_seq : 0);
+
 	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
=20
 	xnlock_get_irqsave(&nklock, s);
Index: xenomai/include/nucleus/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/Makefile.am
+++ xenomai/include/nucleus/Makefile.am
@@ -8,7 +8,6 @@ includesub_HEADERS =3D \
 	heap.h \
 	intr.h \
 	jhash.h \
-	ltt.h \
 	map.h \
 	module.h \
 	pipe.h \

--------------060401040507050709090303--

--------------enig558D4841D937C4B487026519
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHLtE+niDOoMHTA+kRAu1sAJ9yKb0YSsCWcF5UHx5GpdEMmUqj4wCeJwLS
cUmu96KhSOgur9aJMYJcHJY=
=pBNX
-----END PGP SIGNATURE-----

--------------enig558D4841D937C4B487026519--

