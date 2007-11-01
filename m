Message-ID: <4729B923.1040406@domain.hid>
Date: Thu, 01 Nov 2007 12:31:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDD99375562608097ED222F20"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH] refactor x86/hal_*.c
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
--------------enigDD99375562608097ED222F20
Content-Type: multipart/mixed;
 boundary="------------060208040408050002040601"

This is a multi-part message in MIME format.
--------------060208040408050002040601
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This is the kind of patch I've warned about regarding this late -rc
state... :->

It refactores most code from arch/x86/hal_*.c into hal-shared.c, overall
killing more than 200 lines of code. It's compile- and run-tested on
both i386 and x86_64 from 2.6.20 up to 2.6.24-rc1 (x86_64 only on 2.6.23
and 2.6.24). Still, the patch may contain copy&paste regressions or some
remaining ugliness, so it is RFC and not a must for the release.

Jan

--------------060208040408050002040601
Content-Type: text/x-patch;
 name="refactor-x86-hal.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="refactor-x86-hal.patch"

---
 include/asm-x86/hal.h         |   14 +
 include/asm-x86/hal_32.h      |   39 ++++
 include/asm-x86/hal_64.h      |   20 ++
 include/asm-x86/wrappers_64.h |    3=20
 ksrc/arch/x86/Makefile        |    4=20
 ksrc/arch/x86/hal-shared.c    |  371 +++++++++++++++++++++++++++++++++++=
++++++
 ksrc/arch/x86/hal_32.c        |  375 -----------------------------------=
-------
 ksrc/arch/x86/hal_64.c        |  313 -----------------------------------=

 8 files changed, 450 insertions(+), 689 deletions(-)

Index: xenomai/include/asm-x86/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal.h
+++ xenomai/include/asm-x86/hal.h
@@ -1,5 +1,19 @@
+#ifndef _XENO_ASM_X86_HAL_H
+#define _XENO_ASM_X86_HAL_H
+
+enum rthal_ktimer_mode { /* <!> Must follow enum clock_event_mode */
+	KTIMER_MODE_UNUSED =3D 0,
+	KTIMER_MODE_SHUTDOWN,
+	KTIMER_MODE_PERIODIC,
+	KTIMER_MODE_ONESHOT,
+};
+
+extern enum rthal_ktimer_mode rthal_ktimer_saved_mode;
+
 #ifdef __i386__
 #include "hal_32.h"
 #else
 #include "hal_64.h"
 #endif
+
+#endif /* !_XENO_ASM_X86_HAL_H */
Index: xenomai/include/asm-x86/hal_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal_32.h
+++ xenomai/include/asm-x86/hal_32.h
@@ -36,7 +36,8 @@
=20
 #ifndef _XENO_ASM_X86_HAL_32_H
 #define _XENO_ASM_X86_HAL_32_H
-#define _XENO_ASM_X86_HAL_H
+
+#define RTHAL_ARCH_NAME			"i386"
=20
 #include <asm/xenomai/wrappers.h>
=20
@@ -175,8 +176,42 @@ static const char *const rthal_fault_lab
 	[20] =3D NULL,
 };
=20
-long rthal_strncpy_from_user(char *dst, const char __user * src, long co=
unt);
+#ifdef CONFIG_X86_LOCAL_APIC
+
+#include <asm/fixmap.h>
+#include <asm/mpspec.h>
+#ifdef CONFIG_X86_IO_APIC
+#include <asm/io_apic.h>
+#endif /* CONFIG_X86_IO_APIC */
+#include <asm/apic.h>
+
+static inline int rthal_set_apic_base(int lvtt_value)
+{
+	if (APIC_INTEGRATED(GET_APIC_VERSION(apic_read(APIC_LVR))))
+		lvtt_value |=3D SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
+
+	return lvtt_value;
+}
+
+static inline void rthal_setup_periodic_apic(int count, int vector)
+{
+	apic_read_around(APIC_LVTT);
+	apic_write_around(APIC_LVTT, rthal_set_apic_base(APIC_LVT_TIMER_PERIODI=
C | vector));
+	apic_read_around(APIC_TMICT);
+	apic_write_around(APIC_TMICT, count);
+}
+
+static inline void rthal_setup_oneshot_apic(int vector)
+{
+	apic_read_around(APIC_LVTT);
+	apic_write_around(APIC_LVTT, rthal_set_apic_base(vector));
+}
+#endif /* !CONFIG_X86_LOCAL_APIC */
=20
 #endif /* !__cplusplus */
=20
+long rthal_strncpy_from_user(char *dst, const char __user * src, long co=
unt);
+
+void rthal_latency_above_max(struct pt_regs *regs);
+
 #endif /* !_XENO_ASM_X86_HAL_32_H */
Index: xenomai/include/asm-x86/hal_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal_64.h
+++ xenomai/include/asm-x86/hal_64.h
@@ -22,7 +22,8 @@
=20
 #ifndef _XENO_ASM_X86_HAL_64_H
 #define _XENO_ASM_X86_HAL_64_H
-#define _XENO_ASM_X86_HAL_H
+
+#define RTHAL_ARCH_NAME			"x86_64"
=20
 #include <asm/xenomai/wrappers.h>
 #include <asm-generic/xenomai/hal.h>    /* Read the generic bits. */
@@ -116,6 +117,23 @@ static const char *const rthal_fault_lab
     [20] =3D NULL,
 };
=20
+#ifdef CONFIG_X86_LOCAL_APIC
+
+#include <asm/mach_apic.h>
+
+static inline void rthal_setup_periodic_apic(int count, int vector)
+{
+	apic_write(APIC_LVTT, APIC_LVT_TIMER_PERIODIC | vector);
+	apic_write(APIC_TMICT, count);
+}
+
+static inline void rthal_setup_oneshot_apic(int vector)
+{
+	apic_write(APIC_LVTT, vector);
+}
+
+#endif /* !CONFIG_X86_LOCAL_APIC */
+
 #endif /* !__cplusplus */
=20
 long rthal_strncpy_from_user(char *dst,
Index: xenomai/ksrc/arch/x86/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/Makefile
+++ xenomai/ksrc/arch/x86/Makefile
@@ -10,7 +10,7 @@ endif
=20
 obj-$(CONFIG_XENOMAI) +=3D xeno_hal.o
=20
-xeno_hal-y :=3D hal_$(X86_MODE).o usercopy_$(X86_MODE).o
+xeno_hal-y :=3D hal_$(X86_MODE).o hal-shared.o usercopy_$(X86_MODE).o
=20
 xeno_hal-$(CONFIG_XENO_HW_NMI_DEBUG_LATENCY) +=3D nmi_$(X86_MODE).o
=20
@@ -26,7 +26,7 @@ USE_STANDARD_AS_RULE :=3D true
=20
 O_TARGET :=3D built-in.o
=20
-obj-y :=3D hal_32.o
+obj-y :=3D hal_32.o hal-shared.o
=20
 obj-$(CONFIG_XENO_HW_NMI_DEBUG_LATENCY) +=3D nmi_32.o
=20
Index: xenomai/ksrc/arch/x86/hal-shared.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/ksrc/arch/x86/hal-shared.c
@@ -0,0 +1,371 @@
+/**
+ *   @ingroup hal
+ *   @file
+ *
+ *   Adeos-based Real-Time Abstraction Layer for x86.
+ *   Common code of i386 and x86_64.
+ *
+ *   Copyright (C) 2007 Philippe Gerum.
+ *
+ *   Xenomai is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License as
+ *   published by the Free Software Foundation, Inc., 675 Mass Ave,
+ *   Cambridge MA 02139, USA; either version 2 of the License, or (at
+ *   your option) any later version.
+ *
+ *   Xenomai is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *   General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ *   02111-1307, USA.
+ */
+
+/**
+ * @addtogroup hal
+ *
+ *@{*/
+
+#include <asm/xenomai/hal.h>
+
+enum rthal_ktimer_mode rthal_ktimer_saved_mode;
+
+static struct {
+	unsigned long flags;
+	int count;
+} rthal_linux_irq[IPIPE_NR_XIRQS];
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+#define RTHAL_SET_ONESHOT_XENOMAI	1
+#define RTHAL_SET_ONESHOT_LINUX		2
+#define RTHAL_SET_PERIODIC		3
+
+static void rthal_critical_sync(void)
+{
+	switch (rthal_sync_op) {
+	case RTHAL_SET_ONESHOT_XENOMAI:
+		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
+		break;
+
+	case RTHAL_SET_ONESHOT_LINUX:
+		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
+		/* We need to keep the timing cycle alive for the kernel. */
+		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+		break;
+
+	case RTHAL_SET_PERIODIC:
+		rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
+		break;
+	}
+}
+
+static void rthal_timer_set_oneshot(int rt_mode)
+{
+	unsigned long flags;
+
+	flags =3D rthal_critical_enter(rthal_critical_sync);
+	if (rt_mode) {
+		rthal_sync_op =3D RTHAL_SET_ONESHOT_XENOMAI;
+		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
+	} else {
+		rthal_sync_op =3D RTHAL_SET_ONESHOT_LINUX;
+		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
+		/* We need to keep the timing cycle alive for the kernel. */
+		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+	}
+	rthal_critical_exit(flags);
+}
+
+static void rthal_timer_set_periodic(void)
+{
+	unsigned long flags;
+
+	flags =3D rthal_critical_enter(&rthal_critical_sync);
+	rthal_sync_op =3D RTHAL_SET_PERIODIC;
+	rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
+	rthal_critical_exit(flags);
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+#include <asm/smpboot.h>
+static inline void send_IPI_all(int vector)
+{
+	unsigned long flags;
+
+	rthal_local_irq_save_hw(flags);
+	apic_wait_icr_idle();
+	apic_write_around(APIC_ICR,
+			  APIC_DM_FIXED | APIC_DEST_ALLINC | INT_DEST_ADDR_MODE
+			  | vector);
+	rthal_local_irq_restore_hw(flags);
+}
+#elif defined(__i386__)
+#include <mach_ipi.h>
+#endif
+
+DECLARE_LINUX_IRQ_HANDLER(rthal_broadcast_to_local_timers, irq, dev_id)
+{
+#ifdef CONFIG_SMP
+	send_IPI_all(LOCAL_TIMER_VECTOR);
+#else
+	rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
+#endif
+	return IRQ_HANDLED;
+}
+
+int rthal_timer_request(
+	void (*tick_handler)(void),
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	void (*mode_emul)(enum clock_event_mode mode,
+			  struct ipipe_tick_device *tdev),
+	int (*tick_emul)(unsigned long delay,
+			 struct ipipe_tick_device *tdev),
+#endif
+	int cpu)
+{
+	int tickval, err;
+
+	/* This code works both for UP+LAPIC and SMP configurations. */
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	err =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu);
+
+	switch (err) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* oneshot tick emulation callback won't be used, ask
+		 * the caller to start an internal timer for emulating
+		 * a periodic tick. */
+		tickval =3D 1000000000UL / HZ;
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* oneshot tick emulation */
+		tickval =3D 1;
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+		/* we don't need to emulate the tick at all. */
+		tickval =3D 0;
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		return -ENODEV;
+
+	default:
+		return err;
+	}
+
+	rthal_ktimer_saved_mode =3D err;
+#else /* !CONFIG_GENERIC_CLOCKEVENTS */
+	/*
+	 * When the local APIC is enabled for kernels lacking generic
+	 * support for clock events, we do not need to relay the host tick
+	 * since 8254 interrupts are already flowing normally to Linux
+	 * (i.e. the nucleus does not intercept them, but uses a dedicated
+	 * APIC-based timer interrupt instead, i.e. RTHAL_APIC_TIMER_IPI).
+	 */
+	tickval =3D 0;
+	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
+#endif /* !CONFIG_GENERIC_CLOCKEVENTS */
+
+	/*
+	 * The rest of the initialization should only be performed
+	 * once by a single CPU.
+	 */
+	if (cpu > 0)
+		goto out;
+
+	rthal_timer_set_oneshot(1);
+
+	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
+			  (rthal_irq_handler_t) tick_handler, NULL, NULL);
+
+	if (err)
+		return err;
+
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
+	rthal_irq_host_request(RTHAL_BCAST_TICK_IRQ,
+			       &rthal_broadcast_to_local_timers,
+			       "rthal_broadcast_timer",
+			       &rthal_broadcast_to_local_timers);
+#endif
+
+	rthal_nmi_init(&rthal_latency_above_max);
+out:
+	return tickval;
+}
+
+void rthal_timer_release(int cpu)
+{
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	ipipe_release_tickdev(cpu);
+#else
+	rthal_irq_host_release(RTHAL_BCAST_TICK_IRQ,
+			       &rthal_broadcast_to_local_timers);
+#endif
+
+	/*
+	 * The rest of the cleanup work should only be performed once
+	 * by a single CPU.
+	 */
+	if (cpu > 0)
+		return;
+
+	rthal_nmi_release();
+
+	rthal_irq_release(RTHAL_APIC_TIMER_IPI);
+
+	if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_PERIODIC)
+		rthal_timer_set_periodic();
+	else if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_ONESHOT)
+		rthal_timer_set_oneshot(0);
+}
+
+
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+
+void rthal_timer_notify_switch(enum clock_event_mode mode,
+			       struct ipipe_tick_device *tdev)
+{
+	if (rthal_processor_id() > 0)
+		/*
+		 * We assume all CPUs switch the same way, so we only
+		 * track mode switches from the boot CPU.
+		 */
+		return;
+
+	rthal_ktimer_saved_mode =3D mode;
+}
+
+EXPORT_SYMBOL(rthal_timer_notify_switch);
+
+#endif	/* CONFIG_GENERIC_CLOCKEVENTS */
+
+int rthal_irq_host_request(unsigned irq,
+			   rthal_irq_host_handler_t handler,
+			   char *name, void *dev_id)
+{
+	unsigned long flags;
+
+	if (irq >=3D IPIPE_NR_XIRQS || !handler)
+		return -EINVAL;
+
+	spin_lock_irqsave(&rthal_irq_descp(irq)->lock, flags);
+
+	if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->acti=
on) {
+		rthal_linux_irq[irq].flags =3D
+		    rthal_irq_descp(irq)->action->flags;
+		rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
+	}
+
+	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
+
+	return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
+}
+
+int rthal_irq_host_release(unsigned irq, void *dev_id)
+{
+	unsigned long flags;
+
+	if (irq >=3D NR_IRQS || rthal_linux_irq[irq].count =3D=3D 0)
+		return -EINVAL;
+
+	free_irq(irq, dev_id);
+
+	spin_lock_irqsave(&rthal_irq_descp(irq)->lock, flags);
+
+	if (--rthal_linux_irq[irq].count =3D=3D 0 && rthal_irq_descp(irq)->acti=
on)
+		rthal_irq_descp(irq)->action->flags =3D
+		    rthal_linux_irq[irq].flags;
+
+	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
+
+	return 0;
+}
+
+int rthal_irq_enable(unsigned irq)
+{
+	if (irq >=3D NR_IRQS)
+		return -EINVAL;
+
+	rthal_irq_desc_status(irq) &=3D ~IRQ_DISABLED;
+
+	return rthal_irq_chip_enable(irq);
+}
+
+int rthal_irq_disable(unsigned irq)
+{
+
+	if (irq >=3D NR_IRQS)
+		return -EINVAL;
+
+	rthal_irq_desc_status(irq) |=3D IRQ_DISABLED;
+
+	return rthal_irq_chip_disable(irq);
+}
+
+int rthal_irq_end(unsigned irq)
+{
+	if (irq >=3D NR_IRQS)
+		return -EINVAL;
+
+	return rthal_irq_chip_end(irq);
+}
+
+static inline int do_exception_event(unsigned event, unsigned domid, voi=
d *data)
+{
+	/* Notes:
+
+	   1) GPF needs to be propagated downstream whichever domain caused
+	   it. This is required so that we don't spuriously raise a fatal
+	   error when some fixup code is available to solve the error
+	   condition. For instance, Linux always attempts to reload the %gs
+	   segment register when switching a process in (__switch_to()),
+	   regardless of its value. It is then up to Linux's GPF handling
+	   code to search for a possible fixup whenever some exception
+	   occurs. In the particular case of the %gs register, such an
+	   exception could be raised for an exiting process if a preemption
+	   occurs inside a short time window, after the process's LDT has
+	   been dropped, but before the kernel lock is taken.  The same goes
+	   for Xenomai switching back a Linux thread in non-RT mode which
+	   happens to have been preempted inside do_exit() after the MM
+	   context has been dropped (thus the LDT too). In such a case, %gs
+	   could be reloaded with what used to be the TLS descriptor of the
+	   exiting thread, but unfortunately after the LDT itself has been
+	   dropped. Since the default LDT is only 5 entries long, any attempt
+	   to refer to an LDT-indexed descriptor above this value would cause
+	   a GPF.  2) NMI is not pipelined. */
+
+	if (domid =3D=3D RTHAL_DOMAIN_ID) {
+		rthal_realtime_faults[rthal_processor_id()][event]++;
+
+		if (rthal_trap_handler !=3D NULL &&
+		    rthal_trap_handler(event, domid, data) !=3D 0)
+			return RTHAL_EVENT_STOP;
+	}
+
+	return RTHAL_EVENT_PROPAGATE;
+}
+
+RTHAL_DECLARE_EVENT(exception_event);
+
+static inline void do_rthal_domain_entry(void)
+{
+	unsigned trapnr;
+
+	/* Trap all faults. */
+	for (trapnr =3D 0; trapnr < RTHAL_NR_FAULTS; trapnr++)
+		rthal_catch_exception(trapnr, &exception_event);
+
+	printk(KERN_INFO "Xenomai: hal/%s started.\n", RTHAL_ARCH_NAME);
+}
+
+RTHAL_DECLARE_DOMAIN(rthal_domain_entry);
+
+/*@}*/
Index: xenomai/ksrc/arch/x86/hal_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal_32.c
+++ xenomai/ksrc/arch/x86/hal_32.c
@@ -34,7 +34,7 @@
 /**
  * @addtogroup hal
  *
- * x86-specific HAL services.
+ * i386-specific HAL services.
  *
  *@{*/
=20
@@ -51,14 +51,6 @@
 #include <asm/delay.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#ifdef CONFIG_X86_IO_APIC
-#include <asm/io_apic.h>
-#endif /* CONFIG_X86_IO_APIC */
-#include <asm/apic.h>
-#endif /* CONFIG_X86_LOCAL_APIC */
 #include <asm/xenomai/hal.h>
 #include <stdarg.h>
=20
@@ -76,92 +68,8 @@ static void dummy_mksound(unsigned int h
 #include <asm/nmi.h>
 #endif
=20
-static struct {
-	unsigned long flags;
-	int count;
-} rthal_linux_irq[IPIPE_NR_XIRQS];
-
-static enum { /* <!> Must follow enum clock_event_mode */
-	KTIMER_MODE_UNUSED =3D 0,
-	KTIMER_MODE_SHUTDOWN,
-	KTIMER_MODE_PERIODIC,
-	KTIMER_MODE_ONESHOT,
-} rthal_ktimer_saved_mode;
-
 #ifdef CONFIG_X86_LOCAL_APIC
=20
-static inline int rthal_set_apic_base(int lvtt_value)
-{
-	if (APIC_INTEGRATED(GET_APIC_VERSION(apic_read(APIC_LVR))))
-		lvtt_value |=3D SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
-
-	return lvtt_value;
-}
-
-static inline void rthal_setup_periodic_apic(int count, int vector)
-{
-	apic_read_around(APIC_LVTT);
-	apic_write_around(APIC_LVTT, rthal_set_apic_base(APIC_LVT_TIMER_PERIODI=
C | vector));
-	apic_read_around(APIC_TMICT);
-	apic_write_around(APIC_TMICT, count);
-}
-
-static inline void rthal_setup_oneshot_apic(int vector)
-{
-	apic_read_around(APIC_LVTT);
-	apic_write_around(APIC_LVTT, rthal_set_apic_base(vector));
-}
-
-#define RTHAL_SET_ONESHOT_XENOMAI	1
-#define RTHAL_SET_ONESHOT_LINUX		2
-#define RTHAL_SET_PERIODIC		3
-
-static void rthal_critical_sync(void)
-{
-	switch (rthal_sync_op) {
-	case RTHAL_SET_ONESHOT_XENOMAI:
-		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
-		break;
-
-	case RTHAL_SET_ONESHOT_LINUX:
-		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
-		/* We need to keep the timing cycle alive for the kernel. */
-		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
-		break;
-
-	case RTHAL_SET_PERIODIC:
-		rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
-		break;
-	}
-}
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-#include <asm/smpboot.h>
-static inline void send_IPI_all(int vector)
-{
-	unsigned long flags;
-
-	rthal_local_irq_save_hw(flags);
-	apic_wait_icr_idle();
-	apic_write_around(APIC_ICR,
-			  APIC_DM_FIXED | APIC_DEST_ALLINC | INT_DEST_ADDR_MODE
-			  | vector);
-	rthal_local_irq_restore_hw(flags);
-}
-#else
-#include <mach_ipi.h>
-#endif
-
-DECLARE_LINUX_IRQ_HANDLER(rthal_broadcast_to_local_timers, irq, dev_id)
-{
-#ifdef CONFIG_SMP
-	send_IPI_all(LOCAL_TIMER_VECTOR);
-#else
-	rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
-#endif
-	return IRQ_HANDLED;
-}
-
 unsigned long rthal_timer_calibrate(void)
 {
 	unsigned long flags, v;
@@ -218,7 +126,7 @@ void die_nmi(struct pt_regs *regs, const
=20
 #endif /* Linux < 2.6 */
=20
-static void rthal_latency_above_max(struct pt_regs *regs)
+void rthal_latency_above_max(struct pt_regs *regs)
 {
 	/* Try to report via latency tracer first, then fall back to panic. */
 	if (rthal_trace_user_freeze(rthal_maxlat_us, 1) < 0) {
@@ -234,141 +142,6 @@ static void rthal_latency_above_max(stru
=20
 #endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
=20
-static void rthal_timer_set_oneshot(int rt_mode)
-{
-	unsigned long flags;
-
-	flags =3D rthal_critical_enter(rthal_critical_sync);
-	if (rt_mode) {
-		rthal_sync_op =3D RTHAL_SET_ONESHOT_XENOMAI;
-		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
-	} else {
-		rthal_sync_op =3D RTHAL_SET_ONESHOT_LINUX;
-		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
-		/* We need to keep the timing cycle alive for the kernel. */
-		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
-	}
-	rthal_critical_exit(flags);
-}
-
-static void rthal_timer_set_periodic(void)
-{
-	unsigned long flags;
-
-	flags =3D rthal_critical_enter(&rthal_critical_sync);
-	rthal_sync_op =3D RTHAL_SET_PERIODIC;
-	rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
-	rthal_critical_exit(flags);
-}
-
-int rthal_timer_request(
-	void (*tick_handler)(void),
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	void (*mode_emul)(enum clock_event_mode mode,
-			  struct ipipe_tick_device *tdev),
-	int (*tick_emul)(unsigned long delay,
-			 struct ipipe_tick_device *tdev),
-#endif
-	int cpu)
-{
-	int tickval, err;
-
-	/* This code works both for UP+LAPIC and SMP configurations. */
-
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	err =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu);
-
-	switch (err) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* oneshot tick emulation callback won't be used, ask
-		 * the caller to start an internal timer for emulating
-		 * a periodic tick. */
-		tickval =3D 1000000000UL / HZ;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* oneshot tick emulation */
-		tickval =3D 1;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-		/* we don't need to emulate the tick at all. */
-		tickval =3D 0;
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		return -ENODEV;
-
-	default:
-		return err;
-	}
-
-	rthal_ktimer_saved_mode =3D err;
-#else /* !CONFIG_GENERIC_CLOCKEVENTS */
-	/*
-	 * When the local APIC is enabled for kernels lacking generic
-	 * support for clock events, we do not need to relay the host tick
-	 * since 8254 interrupts are already flowing normally to Linux
-	 * (i.e. the nucleus does not intercept them, but uses a dedicated
-	 * APIC-based timer interrupt instead, i.e. RTHAL_APIC_TIMER_IPI).
-	 */
-	tickval =3D 0;
-	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
-#endif /* !CONFIG_GENERIC_CLOCKEVENTS */
-
-	/*
-	 * The rest of the initialization should only be performed
-	 * once by a single CPU.
-	 */
-	if (cpu > 0)
-		goto out;
-
-	rthal_timer_set_oneshot(1);
-
-	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
-			  (rthal_irq_handler_t) tick_handler, NULL, NULL);
-
-	if (err)
-		return err;
-
-#ifndef CONFIG_GENERIC_CLOCKEVENTS
-	rthal_irq_host_request(RTHAL_BCAST_TICK_IRQ,
-			       &rthal_broadcast_to_local_timers,
-			       "rthal_broadcast_timer",
-			       &rthal_broadcast_to_local_timers);
-#endif
-
-	rthal_nmi_init(&rthal_latency_above_max);
-out:
-	return tickval;
-}
-
-void rthal_timer_release(int cpu)
-{
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	ipipe_release_tickdev(cpu);
-#else
-	rthal_irq_host_release(RTHAL_BCAST_TICK_IRQ,
-			       &rthal_broadcast_to_local_timers);
-#endif
-
-	/*
-	 * The rest of the cleanup work should only be performed once
-	 * by a single CPU.
-	 */
-	if (cpu > 0)
-		return;
-
-	rthal_nmi_release();
-
-	rthal_irq_release(RTHAL_APIC_TIMER_IPI);
-
-	if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_PERIODIC)
-		rthal_timer_set_periodic();
-	else if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_ONESHOT)
-		rthal_timer_set_oneshot(0);
-}
-
 #else /* !CONFIG_X86_LOCAL_APIC */
=20
 unsigned long rthal_timer_calibrate(void)
@@ -531,7 +304,7 @@ void rthal_timer_release(int cpu)
 		rthal_trigger_irq(RTHAL_TIMER_IRQ);
 }
=20
-#endif /* CONFIG_X86_LOCAL_APIC */
+#endif /* !CONFIG_X86_LOCAL_APIC */
=20
 #ifndef CONFIG_X86_TSC
=20
@@ -584,146 +357,6 @@ rthal_time_t rthal_get_8254_tsc(void)
=20
 #endif /* !CONFIG_X86_TSC */
=20
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-
-void rthal_timer_notify_switch(enum clock_event_mode mode,
-			       struct ipipe_tick_device *tdev)
-{
-	if (rthal_processor_id() > 0)
-		/*
-		 * We assume all CPUs switch the same way, so we only
-		 * track mode switches from the boot CPU.
-		 */
-		return;
-
-	rthal_ktimer_saved_mode =3D mode;
-}
-
-EXPORT_SYMBOL(rthal_timer_notify_switch);
-
-#endif	/* CONFIG_GENERIC_CLOCKEVENTS */
-
-int rthal_irq_host_request(unsigned irq,
-			   rthal_irq_host_handler_t handler,
-			   char *name, void *dev_id)
-{
-	unsigned long flags;
-
-	if (irq >=3D IPIPE_NR_XIRQS || !handler)
-		return -EINVAL;
-
-	spin_lock_irqsave(&rthal_irq_descp(irq)->lock, flags);
-
-	if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->acti=
on) {
-		rthal_linux_irq[irq].flags =3D
-		    rthal_irq_descp(irq)->action->flags;
-		rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
-	}
-
-	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
-
-	return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
-}
-
-int rthal_irq_host_release(unsigned irq, void *dev_id)
-{
-	unsigned long flags;
-
-	if (irq >=3D NR_IRQS || rthal_linux_irq[irq].count =3D=3D 0)
-		return -EINVAL;
-
-	free_irq(irq, dev_id);
-
-	spin_lock_irqsave(&rthal_irq_descp(irq)->lock, flags);
-
-	if (--rthal_linux_irq[irq].count =3D=3D 0 && rthal_irq_descp(irq)->acti=
on)
-		rthal_irq_descp(irq)->action->flags =3D
-		    rthal_linux_irq[irq].flags;
-
-	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
-
-	return 0;
-}
-
-int rthal_irq_enable(unsigned irq)
-{
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-
-	rthal_irq_desc_status(irq) &=3D ~IRQ_DISABLED;
-
-	return rthal_irq_chip_enable(irq);
-}
-
-int rthal_irq_disable(unsigned irq)
-{
-
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-
-	rthal_irq_desc_status(irq) |=3D IRQ_DISABLED;
-
-	return rthal_irq_chip_disable(irq);
-}
-
-int rthal_irq_end(unsigned irq)
-{
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-
-	return rthal_irq_chip_end(irq);
-}
-
-static inline int do_exception_event(unsigned event, unsigned domid, voi=
d *data)
-{
-	/* Notes:
-
-	   1) GPF needs to be propagated downstream whichever domain caused
-	   it. This is required so that we don't spuriously raise a fatal
-	   error when some fixup code is available to solve the error
-	   condition. For instance, Linux always attempts to reload the %gs
-	   segment register when switching a process in (__switch_to()),
-	   regardless of its value. It is then up to Linux's GPF handling
-	   code to search for a possible fixup whenever some exception
-	   occurs. In the particular case of the %gs register, such an
-	   exception could be raised for an exiting process if a preemption
-	   occurs inside a short time window, after the process's LDT has
-	   been dropped, but before the kernel lock is taken.  The same goes
-	   for Xenomai switching back a Linux thread in non-RT mode which
-	   happens to have been preempted inside do_exit() after the MM
-	   context has been dropped (thus the LDT too). In such a case, %gs
-	   could be reloaded with what used to be the TLS descriptor of the
-	   exiting thread, but unfortunately after the LDT itself has been
-	   dropped. Since the default LDT is only 5 entries long, any attempt
-	   to refer to an LDT-indexed descriptor above this value would cause
-	   a GPF.  2) NMI is not pipelined. */
-
-	if (domid =3D=3D RTHAL_DOMAIN_ID) {
-		rthal_realtime_faults[rthal_processor_id()][event]++;
-
-		if (rthal_trap_handler !=3D NULL &&
-		    rthal_trap_handler(event, domid, data) !=3D 0)
-			return RTHAL_EVENT_STOP;
-	}
-
-	return RTHAL_EVENT_PROPAGATE;
-}
-
-RTHAL_DECLARE_EVENT(exception_event);
-
-static inline void do_rthal_domain_entry(void)
-{
-	unsigned trapnr;
-
-	/* Trap all faults. */
-	for (trapnr =3D 0; trapnr < RTHAL_NR_FAULTS; trapnr++)
-		rthal_catch_exception(trapnr, &exception_event);
-
-	printk(KERN_INFO "Xenomai: hal/x86 started.\n");
-}
-
-RTHAL_DECLARE_DOMAIN(rthal_domain_entry);
-
 int rthal_arch_init(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -777,7 +410,7 @@ void rthal_arch_cleanup(void)
 	/* Restore previous PC speaker code. */
 	kd_mksound =3D old_mksound;
 #endif /* Linux < 2.6 && !CONFIG_X86_TSC && CONFIG_VT */
-	printk(KERN_INFO "Xenomai: hal/x86 stopped.\n");
+	printk(KERN_INFO "Xenomai: hal/i386 stopped.\n");
 }
=20
 /*@}*/
Index: xenomai/ksrc/arch/x86/hal_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/arch/x86/hal_64.c
+++ xenomai/ksrc/arch/x86/hal_64.c
@@ -43,70 +43,9 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/io_apic.h>
-#include <asm/apic.h>
 #include <asm/xenomai/hal.h>
-#include <asm/mach_apic.h>
 #include <stdarg.h>
=20
-#define RTHAL_SET_ONESHOT_XENOMAI	1
-#define RTHAL_SET_ONESHOT_LINUX		2
-#define RTHAL_SET_PERIODIC		3
-
-static enum { /* <!> Must follow enum clock_event_mode */
-	KTIMER_MODE_UNUSED =3D 0,
-	KTIMER_MODE_SHUTDOWN,
-	KTIMER_MODE_PERIODIC,
-	KTIMER_MODE_ONESHOT,
-} rthal_ktimer_saved_mode;
-
-static struct {
-	unsigned long flags;
-	int count;
-} rthal_linux_irq[IPIPE_NR_XIRQS];
-
-static inline void rthal_setup_periodic_apic(int count, int vector)
-{
-	apic_write(APIC_LVTT, APIC_LVT_TIMER_PERIODIC | vector);
-	apic_write(APIC_TMICT, count);
-}
-
-static inline void rthal_setup_oneshot_apic(int vector)
-{
-	apic_write(APIC_LVTT, vector);
-}
-
-static void rthal_critical_sync(void)
-{
-	switch (rthal_sync_op) {
-	case RTHAL_SET_ONESHOT_XENOMAI:
-		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
-		break;
-
-	case RTHAL_SET_ONESHOT_LINUX:
-		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
-		/* We need to keep the timing cycle alive for the kernel. */
-		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
-		break;
-
-	case RTHAL_SET_PERIODIC:
-		rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
-		break;
-	}
-}
-
-irqreturn_t rthal_broadcast_to_local_timers(int irq, void *dev_id)
-{
-#ifdef CONFIG_SMP
-	send_IPI_all(LOCAL_TIMER_VECTOR);
-#else
-	rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
-#endif
-	return IRQ_HANDLED;
-}
-
 unsigned long rthal_timer_calibrate(void)
 {
 	unsigned long v, flags;
@@ -134,258 +73,6 @@ unsigned long rthal_timer_calibrate(void
 	return rthal_imuldiv(dt, 20, RTHAL_CPU_FREQ);
 }
=20
-static void rthal_timer_set_oneshot(int rt_mode)
-{
-	unsigned long flags;
-
-	flags =3D rthal_critical_enter(rthal_critical_sync);
-	if (rt_mode) {
-		rthal_sync_op =3D RTHAL_SET_ONESHOT_XENOMAI;
-		rthal_setup_oneshot_apic(RTHAL_APIC_TIMER_VECTOR);
-	} else {
-		rthal_sync_op =3D RTHAL_SET_ONESHOT_LINUX;
-		rthal_setup_oneshot_apic(LOCAL_TIMER_VECTOR);
-		/* We need to keep the timing cycle alive for the kernel. */
-		rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
-	}
-	rthal_critical_exit(flags);
-}
-
-static void rthal_timer_set_periodic(void)
-{
-	unsigned long flags;
-
-	flags =3D rthal_critical_enter(&rthal_critical_sync);
-	rthal_sync_op =3D RTHAL_SET_PERIODIC;
-	rthal_setup_periodic_apic(RTHAL_APIC_ICOUNT, LOCAL_TIMER_VECTOR);
-	rthal_critical_exit(flags);
-}
-
-int rthal_timer_request(
-	void (*tick_handler)(void),
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	void (*mode_emul)(enum clock_event_mode mode,
-			  struct ipipe_tick_device *tdev),
-	int (*tick_emul)(unsigned long delay,
-			 struct ipipe_tick_device *tdev),
-#endif
-	int cpu)
-{
-	int tickval, err;
-
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	err =3D ipipe_request_tickdev("lapic", mode_emul, tick_emul, cpu);
-
-	switch (err) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/* oneshot tick emulation callback won't be used, ask
-		 * the caller to start an internal timer for emulating
-		 * a periodic tick. */
-		tickval =3D 1000000000UL / HZ;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* oneshot tick emulation */
-		tickval =3D 1;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-		/* we don't need to emulate the tick at all. */
-		tickval =3D 0;
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		return -ENODEV;
-
-	default:
-		return err;
-	}
-
-	rthal_ktimer_saved_mode =3D err;
-#else /* !CONFIG_GENERIC_CLOCKEVENTS */
-	/*
-	 * When the local APIC is enabled for kernels lacking generic
-	 * support for clock events, we do not need to relay the host tick
-	 * since 8254 interrupts are already flowing normally to Linux
-	 * (i.e. the nucleus does not intercept them, but uses a dedicated
-	 * APIC-based timer interrupt instead, i.e. RTHAL_APIC_TIMER_IPI).
-	 */
-	tickval =3D 0;
-	rthal_ktimer_saved_mode =3D KTIMER_MODE_PERIODIC;
-#endif /* !CONFIG_GENERIC_CLOCKEVENTS */
-
-	/*
-	 * The rest of the initialization should only be performed
-	 * once by a single CPU.
-	 */
-	if (cpu > 0)
-		goto out;
-
-	rthal_timer_set_oneshot(1);
-
-	err =3D rthal_irq_request(RTHAL_APIC_TIMER_IPI,
-				(rthal_irq_handler_t) tick_handler, NULL, NULL);
-
-	if (err)
-		return err;
-
-#ifndef CONFIG_GENERIC_CLOCKEVENTS
-	rthal_irq_host_request(RTHAL_BCAST_TICK_IRQ,
-			       &rthal_broadcast_to_local_timers,
-			       "rthal_broadcast_timer",
-			       &rthal_broadcast_to_local_timers);
-#endif
-
-	rthal_nmi_init(&rthal_latency_above_max);
-out:
-	return tickval;
-}
-
-void rthal_timer_release(int cpu)
-{
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	ipipe_release_tickdev(cpu);
-#else
-	rthal_irq_host_release(RTHAL_BCAST_TICK_IRQ,
-			       &rthal_broadcast_to_local_timers);
-#endif
-
-	/*
-	 * The rest of the cleanup work should only be performed once
-	 * by a single CPU.
-	 */
-	if (cpu > 0)
-		return;
-
-	rthal_nmi_release();
-
-	rthal_irq_release(RTHAL_APIC_TIMER_IPI);
-
-	if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_PERIODIC)
-		rthal_timer_set_periodic();
-	else if (rthal_ktimer_saved_mode =3D=3D KTIMER_MODE_ONESHOT)
-		rthal_timer_set_oneshot(0);
-}
-
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-
-void rthal_timer_notify_switch(enum clock_event_mode mode,
-			       struct ipipe_tick_device *tdev)
-{
-	if (rthal_processor_id() > 0)
-		/*
-		 * We assume all CPUs switch the same way, so we only
-		 * track mode switches from the boot CPU.
-		 */
-		return;
-
-	rthal_ktimer_saved_mode =3D mode;
-}
-
-EXPORT_SYMBOL(rthal_timer_notify_switch);
-
-#endif	/* CONFIG_GENERIC_CLOCKEVENTS */
-
-int rthal_irq_host_request(unsigned irq,
-			   rthal_irq_host_handler_t handler,
-			   char *name, void *dev_id)
-{
-	unsigned long flags;
-
-	if (irq >=3D IPIPE_NR_XIRQS || !handler)
-		return -EINVAL;
-
-	spin_lock_irqsave(&rthal_irq_descp(irq)->lock, flags);
-
-	if (rthal_linux_irq[irq].count++ =3D=3D 0 && rthal_irq_descp(irq)->acti=
on) {
-		rthal_linux_irq[irq].flags =3D
-		    rthal_irq_descp(irq)->action->flags;
-		rthal_irq_descp(irq)->action->flags |=3D IRQF_SHARED;
-	}
-
-	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
-
-	return request_irq(irq, handler, IRQF_SHARED, name, dev_id);
-}
-
-int rthal_irq_host_release(unsigned irq, void *dev_id)
-{
-	unsigned long flags;
-
-	if (irq >=3D NR_IRQS || rthal_linux_irq[irq].count =3D=3D 0)
-		return -EINVAL;
-
-	free_irq(irq, dev_id);
-
-	spin_lock_irqsave(&rthal_irq_descp(irq)->lock, flags);
-
-	if (--rthal_linux_irq[irq].count =3D=3D 0 && rthal_irq_descp(irq)->acti=
on)
-		rthal_irq_descp(irq)->action->flags =3D
-		    rthal_linux_irq[irq].flags;
-
-	spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags);
-
-	return 0;
-}
-
-int rthal_irq_enable(unsigned irq)
-{
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-
-	rthal_irq_desc_status(irq) &=3D ~IRQ_DISABLED;
-
-	return rthal_irq_chip_enable(irq);
-}
-
-int rthal_irq_disable(unsigned irq)
-{
-
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-
-	rthal_irq_desc_status(irq) |=3D IRQ_DISABLED;
-
-	return rthal_irq_chip_disable(irq);
-}
-
-int rthal_irq_end(unsigned irq)
-{
-	if (irq >=3D NR_IRQS)
-		return -EINVAL;
-
-	return rthal_irq_chip_end(irq);
-}
-
-static inline int do_exception_event(unsigned event, unsigned domid, voi=
d *data)
-{
-
-	if (domid =3D=3D RTHAL_DOMAIN_ID) {
-		rthal_realtime_faults[rthal_processor_id()][event]++;
-
-		if (rthal_trap_handler !=3D NULL &&
-		    rthal_trap_handler(event, domid, data) !=3D 0)
-			return RTHAL_EVENT_STOP;
-	}
-
-	return RTHAL_EVENT_PROPAGATE;
-}
-
-RTHAL_DECLARE_EVENT(exception_event);
-
-static inline void do_rthal_domain_entry(void)
-{
-	unsigned trapnr;
-
-	/* Trap all faults. */
-	for (trapnr =3D 0; trapnr < RTHAL_NR_FAULTS; trapnr++)
-		rthal_catch_exception(trapnr, &exception_event);
-
-	printk(KERN_INFO "Xenomai: hal/x86_64 started.\n");
-}
-
-RTHAL_DECLARE_DOMAIN(rthal_domain_entry);
-
 int rthal_arch_init(void)
 {
 	if (rthal_cpufreq_arg =3D=3D 0)
Index: xenomai/include/asm-x86/wrappers_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/wrappers_64.h
+++ xenomai/include/asm-x86/wrappers_64.h
@@ -37,4 +37,7 @@
=20
 typedef irq_handler_t rthal_irq_host_handler_t;
=20
+#define DECLARE_LINUX_IRQ_HANDLER(fn, irq, dev_id)	\
+	irqreturn_t fn(int irq, void *dev_id)
+
 #endif /* _XENO_ASM_X86_WRAPPERS_64_H */

--------------060208040408050002040601--

--------------enigDD99375562608097ED222F20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHKbkjniDOoMHTA+kRAga9AJ485Yv3T6nzdFXRTcwrCWjlJdU91QCfQ3Xp
mCcjqcY/spqt5fe2hECbd/E=
=236M
-----END PGP SIGNATURE-----

--------------enigDD99375562608097ED222F20--

