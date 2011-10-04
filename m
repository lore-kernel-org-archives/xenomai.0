Message-ID: <4E8B0C2D.6030707@domain.hid>
Date: Tue, 04 Oct 2011 15:37:49 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060504060805050706060606"
Subject: [Xenomai-core] patch: testsuite: add missing include
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060504060805050706060606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

the posix/leks regression test in the test suite failed to build on
debian testing due to a missing include. The attached patch fixes the
problem.

Cheers,
-- 
Daniele

--------------060504060805050706060606
Content-Type: text/x-diff;
 name="0003-testsuite-add-missing-include.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-testsuite-add-missing-include.patch"

>From 795a866c1080987ec772492fec223db8d1a2a4a8 Mon Sep 17 00:00:00 2001
From: Daniele Nicolodi <nicolodi@domain.hid>
Date: Tue, 4 Oct 2011 15:14:44 +0200
Subject: testsuite: add missing include

---
 src/testsuite/regression/posix/leaks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/testsuite/regression/posix/leaks.c b/src/testsuite/regression/posix/leaks.c
index 7326572..6c8cee9 100644
--- a/src/testsuite/regression/posix/leaks.c
+++ b/src/testsuite/regression/posix/leaks.c
@@ -1,6 +1,6 @@
 #include <stdio.h>
 #include <stdlib.h>
-
+#include <signal.h>
 #include <unistd.h>
 #include <pthread.h>
 #include <fcntl.h>
-- 
1.7.6.3


--------------060504060805050706060606--

