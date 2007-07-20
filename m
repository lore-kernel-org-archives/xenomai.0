From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 20 Jul 2007 16:17:41 +0200
References: <E1IBrs1-00081N-8b@domain.hid>
	<2ff1a98a0707200558u1e118274nf74c77c528dc9d48@domain.hid>
In-Reply-To: <2ff1a98a0707200558u1e118274nf74c77c528dc9d48@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FQMoGWSD6LmlmvN"
Message-Id: <E1IBtIb-0005xb-KE@mailer.emlix.com>
Subject: Re: [Xenomai-core] [PATCH] [arm] support for user space tsc
	emulation for decrementing counters
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_FQMoGWSD6LmlmvN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Gilles Chanteperdrix wrote:
> On 7/20/07, Sebastian Smolorz <ssm@domain.hid> wrote:
> > Hi,
> >
> > here comes my patch for user space tsc emulation for decrementing
> > counters. I had to extend the __xn_tscinfo structure because the counter
> > value from the last tsc update is needed to calculate the new tsc value.
>
> The struct __xn_tscinfo is a union where "fr" stands for free-running,
> the idea was that you could add your own structure for decrementer
> based tsc.

Ok. Here is version 2 of the patch.

-- 
Sebastian

--Boundary-00=_FQMoGWSD6LmlmvN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="xeno_arm_userspace_tsc_decrementer_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno_arm_userspace_tsc_decrementer_v2.patch"

Index: include/asm-arm/syscall.h
===================================================================
--- include/asm-arm/syscall.h	(Revision 2768)
+++ include/asm-arm/syscall.h	(Arbeitskopie)
@@ -4,6 +4,9 @@
  * ARM port
  *   Copyright (C) 2005 Stelian Pop
  *
+ * Copyright (C) 2007 Sebastian Smolorz <ssm@domain.hid>
+ *	Support for TSC emulation in user space for decrementing counters
+ *
  * Xenomai is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published
  * by the Free Software Foundation; either version 2 of the License,
@@ -205,6 +208,10 @@
                         volatile unsigned long long *tsc;
                 } fr;
                 struct {
+			volatile unsigned *counter;
+			unsigned mask;
+			volatile unsigned *last_cnt;
+			volatile unsigned long long *tsc;
                 } dec;
         } u;
 };
@@ -248,6 +255,28 @@
 	if ((counter & mask) < (before & mask))
 		before += mask + 1;
 	return (before & ~mask) | (counter & mask);
+
+#elif CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_DECREMENTER
+	const unsigned mask = __xn_tscinfo.u.dec.mask;
+	unsigned long long after, before;
+	unsigned counter, last_cnt;
+
+	do {
+		before = *__xn_tscinfo.u.dec.tsc;
+		counter = *__xn_tscinfo.u.dec.counter;
+		last_cnt = *__xn_tscinfo.u.dec.last_cnt;
+		/* compiler barrier. */
+		asm("" : /* */ : /* */ : "memory");
+
+		after = *__xn_tscinfo.u.dec.tsc;
+	} while (after != before);
+
+	counter &= mask;
+	last_cnt &= mask;
+	if (counter > last_cnt)
+		before += mask + 1;
+	return (before + last_cnt - counter);
+
 #endif /* CONFIG_XENO_HW_DIRECT_TSC == __XN_TSC_TYPE_FREERUNNING */
 }
 
@@ -280,7 +309,7 @@
 
 	switch(__xn_tscinfo.type) {
 #if CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_FREERUNNING
-	case __XN_TSC_TYPE_FREERUNNING:{
+	case __XN_TSC_TYPE_FREERUNNING: {
 		unsigned long phys_addr;
 
 		phys_addr = (unsigned long) __xn_tscinfo.u.fr.counter;
@@ -296,6 +325,23 @@
 			 ((char *) addr + (phys_addr & (page_size - 1))));
 		break;
 	}
+#elif CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_DECREMENTER
+	case __XN_TSC_TYPE_DECREMENTER: {
+		unsigned long phys_addr;
+
+		phys_addr = (unsigned long) __xn_tscinfo.u.dec.counter;
+		addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
+			    fd, phys_addr & ~(page_size - 1));
+		if (addr == MAP_FAILED) {
+			perror("Xenomai init: mmap(/dev/mem)");
+			exit(EXIT_FAILURE);
+		}
+
+		__xn_tscinfo.u.dec.counter = 
+			((volatile unsigned *)
+			 ((char *) addr + (phys_addr & (page_size - 1))));
+		break;
+	}
 #endif /* CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_FREERUNNING */
 	case __XN_TSC_TYPE_NONE:
 		goto error;
Index: include/asm-arm/bits/shadow.h
===================================================================
--- include/asm-arm/bits/shadow.h	(Revision 2768)
+++ include/asm-arm/bits/shadow.h	(Arbeitskopie)
@@ -176,6 +176,12 @@
 			info.u.fr.tsc = ipipe_info.archdep.tsc.u.fr.tsc;
 			break;
 		case IPIPE_TSC_TYPE_DECREMENTER:
+			info.type = __XN_TSC_TYPE_DECREMENTER,
+			info.u.dec.counter = ipipe_info.archdep.tsc.u.dec.counter;
+			info.u.dec.mask = ipipe_info.archdep.tsc.u.dec.mask;
+			info.u.dec.last_cnt = ipipe_info.archdep.tsc.u.dec.last_cnt;
+			info.u.dec.tsc = ipipe_info.archdep.tsc.u.dec.tsc;
+			break;
 		case IPIPE_TSC_TYPE_NONE:
 			return -ENOSYS;
 			
Index: configure.in
===================================================================
--- configure.in	(Revision 2768)
+++ configure.in	(Arbeitskopie)
@@ -182,7 +182,8 @@
 	ixp4xx|pxa) 	arch=5
 	      		tsc_type=__XN_TSC_TYPE_FREERUNNING;;
 
-	s3c2410) 	arch=4;;
+	s3c2410) 	arch=4
+			tsc_type=__XN_TSC_TYPE_DECREMENTER;;
 
 	sa1100) 	arch=4
 			CONFIG_XENO_ARM_SA1100=y
Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 2768)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2007-07-19  Sebastian Smolorz  <ssm@domain.hid>
+
+	* include/asm-arm/syscall.h: Add user-space access to
+	tsc emulation for decrementing counters.
+
 2007-07-19  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* ksrc/nucleus/timer.c (xntimer_tick_aperiodic): Keep processing

--Boundary-00=_FQMoGWSD6LmlmvN--

