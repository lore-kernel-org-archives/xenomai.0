From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] tick: irq_pipeline: fix proxying of a broadcast device
Date: Sun,  3 Apr 2022 16:48:00 +0200
Message-Id: <20220403144800.1776095-1-rpm@xenomai.org>
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

When a proxy device is taking control of a (real) broadcast device, we
have to:

- remove the real device from the clockevents_list
- keep that device ticking, i.e. no shutdown

Fix tick_check_new_device() accordingly.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/time/clockevents.c   |  7 ++++---
 kernel/time/tick-common.c   | 21 +++++++++------------
 kernel/time/tick-internal.h |  8 ++++++++
 kernel/time/tick-proxy.c    |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 6ecf0af02822..b1e7de5e5290 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -639,10 +639,11 @@ void clockevents_exchange_device(struct clock_event_device *old,
 	if (old) {
 		module_put(old->owner);
 		/*
-		 * Do not move a proxy tick device to the release
-		 * list, keep it around but mark it as reserved.
+		 * Do not move the device backing a proxy tick device
+		 * to the release list, keep it around but mark it as
+		 * reserved.
 		 */
-		if (new && new->features & CLOCK_EVT_FEAT_PROXY) {
+		if (tick_check_is_proxy(new)) {
 			list_del(&old->list);
 			clockevents_switch_state(old, CLOCK_EVT_STATE_RESERVED);
 		} else {
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 58a9933d0250..5ffdc83f4153 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -322,17 +322,6 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
 }
 
-static bool tick_check_is_proxy(struct clock_event_device *curdev)
-{
-	if (!irqs_pipelined())
-		return false;
-
-	/*
-	 * Never replace an active proxy except when unregistering it.
-	 */
-	return curdev && curdev->features & CLOCK_EVT_FEAT_PROXY;
-}
-
 /*
  * Check whether the new device is a better fit than curdev. curdev
  * can be NULL !
@@ -340,6 +329,9 @@ static bool tick_check_is_proxy(struct clock_event_device *curdev)
 bool tick_check_replacement(struct clock_event_device *curdev,
 			    struct clock_event_device *newdev)
 {
+	/*
+	 * Never replace an active proxy except when unregistering it.
+	 */
 	if (tick_check_is_proxy(curdev))
 		return false;
 
@@ -378,7 +370,12 @@ void tick_check_new_device(struct clock_event_device *newdev)
 	 * not give it back to the clockevents layer !
 	 */
 	if (tick_is_broadcast_device(curdev)) {
-		clockevents_shutdown(curdev);
+		if (tick_check_is_proxy(newdev)) {
+			list_del(&curdev->list);
+			clockevents_switch_state(curdev, CLOCK_EVT_STATE_RESERVED);
+		} else {
+			clockevents_shutdown(curdev);
+		}
 		curdev = NULL;
 	}
 	clockevents_exchange_device(curdev, newdev);
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 4dd811be7edd..85d8451dfee6 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -47,6 +47,14 @@ static inline void clockevent_set_state(struct clock_event_device *dev,
 	dev->state_use_accessors = state;
 }
 
+static inline bool tick_check_is_proxy(struct clock_event_device *dev)
+{
+	if (!irqs_pipelined())
+		return false;
+
+	return dev && dev->features & CLOCK_EVT_FEAT_PROXY;
+}
+
 extern void clockevents_shutdown(struct clock_event_device *dev);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
index 84aab8bcc660..5a877987a84e 100644
--- a/kernel/time/tick-proxy.c
+++ b/kernel/time/tick-proxy.c
@@ -285,7 +285,7 @@ static int enable_oob_timer(void *arg) /* hard_irqs_disabled() */
 
 	/*
 	 * irq_switch_oob() grabs the IRQ descriptor lock which is
-	 * mutable, so that is fine to invoke this routine with hard
+	 * hybrid, so that is fine to invoke this routine with hard
 	 * IRQs off.
 	 */
 	irq_switch_oob(real_dev->irq, true);
-- 
2.34.1


