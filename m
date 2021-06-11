From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 12/17] cobalt/tick: dovetail: improve accuracy of the host
 tick delay
Date: Fri, 11 Jun 2021 20:05:38 +0200
Message-Id: <7b6dd52ed44d59ed87d260d7e35663dbb8cb3cd2.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Expiration dates of in-band timers are based on the monotonic time
base read by ktime_get(), which is ok for us to use from non-NMI
context.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/tick.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index fa041092e..ac343e4d3 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -55,19 +55,21 @@ void pipeline_set_timer_shot(unsigned long delay) /* ns */
 }
 
 static int proxy_set_next_ktime(ktime_t expires,
-				struct clock_event_device *proxy_dev)
+				struct clock_event_device *proxy_dev) /* hard irqs on/off */
 {
 	struct xnsched *sched;
-	ktime_t delta;
 	unsigned long flags;
+	ktime_t delta;
 	int ret;
 
 	/*
-	 * When Negative delta have been observed, we set delta zero.
-	 * Or else exntimer_start() will return -ETIMEDOUT and do not
-	 * trigger shot
+	 * Expiration dates of in-band timers are based on the common
+	 * monotonic time base. If the timeout date has already
+	 * elapsed, make sure xntimer_start() does not fail with
+	 * -ETIMEDOUT but programs the hardware for ticking
+	 * immediately instead.
 	 */
-	delta = ktime_sub(expires, ktime_get_mono_fast_ns());
+	delta = ktime_sub(expires, ktime_get());
 	if (delta < 0)
 		delta = 0;
 
-- 
2.26.2


