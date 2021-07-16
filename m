From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey: posix-mutex:
Message-ID: <d35daab3-2b33-24a0-87de-57d8f71af746@siemens.com>
Date: Fri, 16 Jul 2021 16:59:44 +0200
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

When running in QEMU, the 5 ms holding time of mutex_timed_locker may be
too short when the host is busy. This occasionally leads to failing
tests in our CI. Expand to 100 ms then.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/posix-mutex/posix-mutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 3a88532a30..f64ada346c 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -170,7 +170,8 @@ static void *mutex_timed_locker(void *arg)
 	int ret;
 
 	clock_gettime(CLOCK_REALTIME, &now);
-	timespec_adds(&ts, &now, 5000000); /* 5ms from now */
+	/* 5ms (or 100ms in VM) from now */
+	timespec_adds(&ts, &now, smokey_on_vm ? 100000000 : 5000000);
 
 	if (p->barrier)
 		smokey_barrier_release(p->barrier);
-- 
2.26.2

