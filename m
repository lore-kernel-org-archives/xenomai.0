From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey/y2038: Skip clock_settime test of not using
 legacy TSC
Message-ID: <bb0f2058-5d55-79ec-9bf5-15d73b3f76a5@siemens.com>
Date: Fri, 4 Jun 2021 15:02:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

It's not provided in this case. libcobalt calls libc instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c
b/testsuite/smokey/y2038/syscall-tests.c
index 24580f5a8..a64584d8c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -204,6 +204,9 @@ static int test_sc_cobalt_clock_settime64(void)
 	struct xn_timespec64 ts64, now64;
 	struct timespec now;

+	if (!cobalt_use_legacy_tsc())
+		return 0; // Not implemented, nothing to test, success
+
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
 	if (ret == -ENOSYS) {
-- 
2.26.2

