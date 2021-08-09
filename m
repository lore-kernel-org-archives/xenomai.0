From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey: y2038: Fix evaluation of pthread_join result
Message-ID: <ff6fb552-1773-59ed-8c34-1d443ad56016@siemens.com>
Date: Mon, 9 Aug 2021 09:15:41 +0200
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

The status value is the pointer, not where the pointer points to.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Not yet resolving the unexpected assertion, though.

 testsuite/smokey/y2038/syscall-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 90bfe28d48..afbe8d42a6 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -150,7 +150,7 @@ static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
 	if (!__T(ret, pthread_join(tid, &status)))
 		return ret;
 
-	res = *((long *) status);
+	res = (long)status;
 
 	return (res == exp_result) ? 0 : ret;
 }
-- 
2.31.1

