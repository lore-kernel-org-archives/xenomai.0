From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 15 May 2006 22:36:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152236.56645.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Patch for better error messages in posix testsuite
Reply-To: niklaus.giger@domain.hid
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

Hi

If one greps the output of the posix testsuite failures does not show
up cleanly as the assertions are terminated by a line feed. 

Please apply the following patch which fixes this problem
Index: sim/skins/posix/testsuite/xntest.c
===================================================================
--- sim/skins/posix/testsuite/xntest.c  (Revision 1103)
+++ sim/skins/posix/testsuite/xntest.c  (Arbeitskopie)
@@ -91,7 +91,7 @@
     ++tests;
     if(!status) {
         ++test_failures;
-        xnarch_printf("%s:%d: TEST %s failed.\n", file, line, assertion);
+        xnarch_printf("%s:%d: TEST failed: %s\n", file, line, assertion);
     } else
         xnarch_printf("%s:%d TEST passed.\n", file, line);
     xnlock_put_irqrestore(&test_lock, s);

Thanks in advance
-- 
Niklaus Giger

