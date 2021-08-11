From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 3/3] y2038: testsuite/smokey/y2038: Adding tests for
 event_wait64
Date: Wed, 11 Aug 2021 15:50:26 +0200
Message-Id: <20210811135026.44400-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210811135026.44400-1-florian.bezdeka@siemens.com>
References: <20210811135026.44400-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Based on the tests provided by Song, slightly adjusted, #includes
cleaned up and making sure all resources used during tests have been
cleaned up as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 80 +++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 839a50e07..7add1c454 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -10,17 +10,8 @@
  * Released under the terms of GPLv2.
  */
 #include <asm/xenomai/syscall.h>
-#include <cobalt/uapi/syscall.h>
 #include <smokey/smokey.h>
-#include <semaphore.h>
-#include <unistd.h>
-#include <stdint.h>
-#include <stdbool.h>
-#include <errno.h>
 #include <mqueue.h>
-#include <signal.h>
-#include <cobalt/uapi/monitor.h>
-#include <sys/cobalt.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
@@ -916,6 +907,73 @@ static int test_sc_cobalt_monitor_wait64(void)
 	return 0;
 }
 
+static int test_sc_cobalt_event_wait64(void)
+{
+	int ret;
+	int sc_nr = sc_cobalt_event_wait64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+	struct cobalt_event_shadow evt;
+	unsigned int flags;
+
+	ret = cobalt_event_init(&evt, 0, COBALT_EVENT_FIFO);
+	if (ret)
+		return -errno;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note("event_wait64: skipped. (no kernel support)");
+		return 0; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/* Providing an invalid address has to deliver EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, &evt, 0x1, &flags, 0,
+			       (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT))
+		return ret ? ret : -EINVAL;
+
+	/* providing an invalid timeout has to deliver EINVAL */
+	t1.tv_sec = -1;
+	ret = XENOMAI_SYSCALL5(sc_nr, &evt, 0x1, &flags, 0, &t1);
+	if (!smokey_assert(ret == -EINVAL))
+		return ret ? ret : -EINVAL;
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t1.tv_sec = 0;
+	t1.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL5(sc_nr, &evt, 0x1, &flags, 0, &t1);
+	if (!smokey_assert(ret == -ETIMEDOUT))
+		return ret;
+
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
+	if (ret)
+		return -errno;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("event_wait64 returned too early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+	cobalt_event_destroy(&evt);
+
+	return 0;
+}
+
 static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -964,5 +1022,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_event_wait64();
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.30.2


