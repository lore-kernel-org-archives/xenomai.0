From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ipipe: Clean up per-CPU host timers on hotplug
Message-ID: <218c3aa3-11cf-8b4e-63e7-ee168e4133c0@siemens.com>
Date: Mon, 25 Feb 2019 18:42:18 +0100
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

When a CPU is unplugged, make sure to drop all per-CPU ipipe timer
devices when removing the CPU. Otherwise, we will corrupt the device
list when re-registering the host timer on CPU onlining.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/ipipe_tickdev.h |  5 +++++
 kernel/ipipe/timer.c          | 15 +++++++++++++++
 kernel/time/clockevents.c     |  5 ++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipipe_tickdev.h b/include/linux/ipipe_tickdev.h
index 90395095e115..e222e839c3be 100644
--- a/include/linux/ipipe_tickdev.h
+++ b/include/linux/ipipe_tickdev.h
@@ -102,6 +102,11 @@ extern unsigned long __ipipe_hrtimer_freq;
  */
 void ipipe_host_timer_register(struct clock_event_device *clkevt);
 
+/*
+ * Called by tick_cleanup_dead_cpu, to drop per-CPU timer devices
+ */
+void ipipe_host_timer_cleanup(struct clock_event_device *clkevt);
+
 /*
  * Register a standalone ipipe timer
  */
diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index bbb3c8f4a7ab..5532be93e951 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -145,6 +145,21 @@ void ipipe_host_timer_register(struct clock_event_device *evtdev)
 	ipipe_timer_register(timer);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+void ipipe_host_timer_cleanup(struct clock_event_device *evtdev)
+{
+	struct ipipe_timer *timer = evtdev->ipipe_timer;
+	unsigned long flags;
+
+	if (timer == NULL)
+		return;
+
+	raw_spin_lock_irqsave(&lock, flags);
+	list_del(&timer->link);
+	raw_spin_unlock_irqrestore(&lock, flags);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * register a timer: maintain them in a list sorted by rating
  */
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index fd6894afff6b..1db5e25abde3 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -630,8 +630,10 @@ void tick_cleanup_dead_cpu(int cpu)
 	 * Unregister the clock event devices which were
 	 * released from the users in the notify chain.
 	 */
-	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
+	list_for_each_entry_safe(dev, tmp, &clockevents_released, list) {
 		list_del(&dev->list);
+		ipipe_host_timer_cleanup(dev);
+	}
 	/*
 	 * Now check whether the CPU has left unused per cpu devices
 	 */
@@ -641,6 +643,7 @@ void tick_cleanup_dead_cpu(int cpu)
 		    !tick_is_broadcast_device(dev)) {
 			BUG_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
+			ipipe_host_timer_cleanup(dev);
 		}
 	}
 	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
-- 
2.16.4

