Message-ID: <483D6466.5080207@domain.hid>
Date: Wed, 28 May 2008 15:55:50 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai 2.4.x user space build problem with uint64_t
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

Hello,

the following patch fixes a problem building the Xenomai user
space applications for the MPC5200 using the ELDK 4.2. It can't 
find the type uint64_t:

Index: include/asm-powerpc/fptest.h
===================================================================
--- include/asm-powerpc/fptest.h	(revision 3891)
+++ include/asm-powerpc/fptest.h	(working copy)
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #else /* !__KERNEL__ */
 #include <stdio.h>
+#include <stdint.h>
 #define printk printf
 #endif /* !__KERNEL__ */
 
TIA,

Wolfgang.

