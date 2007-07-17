From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DVXm4jvdWE"
Content-Transfer-Encoding: 7bit
Message-ID: <18077.6356.94172.274545@domain.hid>
Date: Tue, 17 Jul 2007 21:30:28 +0200
Subject: [Xenomai-core] [patch] fix ximulator xnarch_program_next_timer_shot.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--DVXm4jvdWE
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

when xnarch_program_next_timer_shot is passed a null delay and there is
no other timed event pending, the mvm terminates with the message:
"nothing to schedule".

The attached patch fixes this, though I am not sure it is the best way
to fix it.

-- 


					    Gilles Chanteperdrix.

--DVXm4jvdWE
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-sim-program-null-delay.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-sim/bits/timer.h
===================================================================
--- include/asm-sim/bits/timer.h	(revision 2765)
+++ include/asm-sim/bits/timer.h	(working copy)
@@ -22,7 +22,7 @@
 static inline void xnarch_program_timer_shot (unsigned long delay)
 {
     /* 1 tsc unit of the virtual CPU == 1 ns. */
-    mvm_program_timer(delay);
+    mvm_program_timer(delay ?: 1);
 }
 
 static inline int xnarch_send_timer_ipi (xnarch_cpumask_t mask)

--DVXm4jvdWE--

