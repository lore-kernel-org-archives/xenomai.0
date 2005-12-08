Message-ID: <4398B430.5000706@domain.hid>
Date: Thu, 08 Dec 2005 23:31:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020308000408080106070001"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [patch] fix posix userspace headers
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

This is a multi-part message in MIME format.
--------------020308000408080106070001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Good evening,

this patch is required to compile some posix userspace program against
2.1 SVN.

Jan

--------------020308000408080106070001
Content-Type: text/x-patch;
 name="posix-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="posix-header.patch"

Index: include/posix/signal.h
===================================================================
--- include/posix/signal.h	(Revision 245)
+++ include/posix/signal.h	(Arbeitskopie)
@@ -20,6 +20,12 @@
 #ifndef _POSIX_SIGNAL_H
 #define _POSIX_SIGNAL_H
 
+#ifndef __KERNEL__
+
+#include_next <signal.h>
+
+#else /* __KERNEL__ */
+
 #include <xenomai/posix/thread.h>
 
 #define SIGACTION_FLAGS (SA_ONESHOT|SA_NOMASK|SA_SIGINFO)
@@ -46,4 +52,6 @@
 
 void pse51_signal_pkg_cleanup(void);
 
+#endif /* !__KERNEL__ */
+
 #endif /* !_POSIX_SIGNAL_H */

--------------020308000408080106070001--

