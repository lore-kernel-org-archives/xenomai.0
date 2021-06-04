From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] smokey: y2038: Fix reference clock for sem_timedwait64
Message-ID: <30ef9a9c-ad96-0317-3718-bad8b6a75f5d@siemens.com>
Date: Fri, 4 Jun 2021 10:09:55 +0200
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
To: Xenomai <xenomai@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, Song Chen <chensong_2000@189.cn>

From: Jan Kiszka <jan.kiszka@siemens.com>

This service uses CLOCK_REALTIME, not CLOCK_MONOTONIC. Fixes false
positives regarding early timeouts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Likely affects pending test patches as well - please check your queues.

 testsuite/smokey/y2038/syscall-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 716be4f2a..9f5b3b564 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -137,7 +137,7 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	 * Providing a valid timeout, waiting for it to time out and check
 	 * that we didn't come back to early.
 	 */
-	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
 	if (ret)
 		return -errno;
 
@@ -149,7 +149,7 @@ static int test_sc_cobalt_sem_timedwait64(void)
 	if (!smokey_assert(ret == -ETIMEDOUT))
 		return ret;
 
-	ret = clock_gettime(CLOCK_MONOTONIC, &ts_nat);
+	ret = clock_gettime(CLOCK_REALTIME, &ts_nat);
 	if (ret)
 		return -errno;
 
-- 
2.26.2

