From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 14/25] cobalt/timer: Check if nklock is held in timer services
Date: Thu, 20 May 2021 23:44:24 +0200
Message-Id: <544cd293367276d8a5edaeaa47fbb4fdd315c835.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/timer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index f9aa457ce9..9297cca186 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -118,6 +118,8 @@ int xntimer_start(struct xntimer *timer,
 	unsigned long gravity;
 	int ret = 0;
 
+	atomic_only();
+
 	trace_cobalt_timer_start(timer, value, interval, mode);
 
 	if ((timer->status & XNTIMER_DEQUEUED) == 0)
@@ -204,6 +206,8 @@ void __xntimer_stop(struct xntimer *timer)
 	struct xnsched *sched;
 	int heading = 1;
 
+	atomic_only();
+
 	trace_cobalt_timer_stop(timer);
 
 	if ((timer->status & XNTIMER_DEQUEUED) == 0) {
@@ -239,6 +243,8 @@ EXPORT_SYMBOL_GPL(__xntimer_stop);
  */
 xnticks_t xntimer_get_date(struct xntimer *timer)
 {
+	atomic_only();
+
 	if (!xntimer_running_p(timer))
 		return XN_INFINITE;
 
@@ -269,6 +275,8 @@ xnticks_t __xntimer_get_timeout(struct xntimer *timer)
 	struct xnclock *clock;
 	xnticks_t expiry, now;
 
+	atomic_only();
+
 	clock = xntimer_clock(timer);
 	now = xnclock_read_raw(clock);
 	expiry = xntimer_expiry(timer);
@@ -431,6 +439,8 @@ void __xntimer_switch_tracking(struct xntimer *timer,
 void xntimer_set_clock(struct xntimer *timer,
 		       struct xnclock *newclock)
 {
+	atomic_only();
+
 	if (timer->clock != newclock) {
 		xntimer_stop(timer);
 		timer->clock = newclock;
@@ -605,6 +615,8 @@ unsigned long long xntimer_get_overruns(struct xntimer *timer,
 	xnsticks_t delta;
 	xntimerq_t *q;
 
+	atomic_only();
+
 	delta = now - xntimer_pexpect(timer);
 	if (unlikely(delta >= (xnsticks_t) period)) {
 		period = timer->interval_ns;
-- 
2.26.2


