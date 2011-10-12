Message-ID: <4E95618B.6010709@domain.hid>
Date: Wed, 12 Oct 2011 11:44:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH xenomai-head] testsuite: fix compiler error
	'SIGALRM, undeclared'
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 src/testsuite/regression/posix/leaks.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/testsuite/regression/posix/leaks.c b/src/testsuite/regression/posix/leaks.c
index 7326572..f9dd34d 100644
--- a/src/testsuite/regression/posix/leaks.c
+++ b/src/testsuite/regression/posix/leaks.c
@@ -6,6 +6,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <semaphore.h>
+#include <signal.h>
 #include <mqueue.h>
 
 #include <nucleus/heap.h>
-- 
1.7.6.2


