From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 20 Jul 2007 14:46:09 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_R6KoGCX46vZdKZ8"
Message-Id: <E1IBrs1-00081N-8b@domain.hid>
Subject: [Xenomai-core] [PATCH] [arm] support for user space tsc emulation
	for decrementing counters
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

--Boundary-00=_R6KoGCX46vZdKZ8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here comes my patch for user space tsc emulation for decrementing counters. I 
had to extend the __xn_tscinfo structure because the counter value from the 
last tsc update is needed to calculate the new tsc value.

I will post a second patch for Adeos which implements the kernel side for  
s3c24xx platforms on adeos-main.

-- 
Sebastian

--Boundary-00=_R6KoGCX46vZdKZ8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xeno_arm_userspace_tsc_decrementer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno_arm_userspace_tsc_decrementer.patch"

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
@@ -202,6 +205,7 @@
                 struct {
                         volatile unsigned *counter;
                         unsigned mask;
+			volatile unsigned *last_cnt;
                         volatile unsigned long long *tsc;
                 } fr;
                 struct {
@@ -248,6 +252,28 @@
 	if ((counter & mask) < (before & mask))
 		before += mask + 1;
 	return (before & ~mask) | (counter & mask);
+
+#elif CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_DECREMENTER
+	const unsigned long long mask = __xn_tscinfo.u.fr.mask;
+	unsigned long long after, before;
+	unsigned counter, last_cnt;
+
+	do {
+		before = *__xn_tscinfo.u.fr.tsc;
+		counter = *__xn_tscinfo.u.fr.counter;
+		last_cnt = *__xn_tscinfo.u.fr.last_cnt;
+		/* compiler barrier. */
+		asm("" : /* */ : /* */ : "memory");
+
+		after = *__xn_tscinfo.u.fr.tsc;
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
 
@@ -279,8 +305,8 @@
 	page_size = sysconf(_SC_PAGESIZE);
 
 	switch(__xn_tscinfo.type) {
-#if CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_FREERUNNING
-	case __XN_TSC_TYPE_FREERUNNING:{
+	case __XN_TSC_TYPE_FREERUNNING:
+	case __XN_TSC_TYPE_DECREMENTER: {
 		unsigned long phys_addr;
 
 		phys_addr = (unsigned long) __xn_tscinfo.u.fr.counter;
@@ -296,7 +322,6 @@
 			 ((char *) addr + (phys_addr & (page_size - 1))));
 		break;
 	}
-#endif /* CONFIG_XENO_ARM_HW_DIRECT_TSC == __XN_TSC_TYPE_FREERUNNING */
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
+			info.u.fr.counter = ipipe_info.archdep.tsc.u.fr.counter;
+			info.u.fr.mask = ipipe_info.archdep.tsc.u.fr.mask;
+			info.u.fr.last_cnt = ipipe_info.archdep.tsc.u.fr.last_cnt;
+			info.u.fr.tsc = ipipe_info.archdep.tsc.u.fr.tsc;
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

--Boundary-00=_R6KoGCX46vZdKZ8--

