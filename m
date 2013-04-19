Message-ID: <51717A5A.9050109@siemens.com>
Date: Fri, 19 Apr 2013 19:09:46 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] ipipe: Retry clocksource validation in watchdog
 handler before failing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The realtime domain may interrupt the clocksource watchdog right between
its reading of the tested clock and the reference value. We do not want
to make this sequence atomic as some clocksources may have high access
latencies, but we also do not want to simply drop the watchdog because
broken hardware could otherwise remain unnoticed.

The solution is to read the watchdog clocksource twice, before and after
the tested clock, and retry this until the watchdog clock does not
progress excessively between the measurement points.

The watchdog is generic, but it currently only monitors x86's TSC.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

For review before queuing it up.

 kernel/time/clocksource.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0e71d18..84a290f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -250,6 +250,9 @@ static void clocksource_watchdog(unsigned long data)
 	cycle_t csnow, wdnow;
 	int64_t wd_nsec, cs_nsec;
 	int next_cpu, reset_pending;
+#ifdef CONFIG_IPIPE
+	cycle_t wdref;
+#endif
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -266,11 +269,22 @@ static void clocksource_watchdog(unsigned long data)
 			continue;
 		}
 
+#ifdef CONFIG_IPIPE
+retry:
+#endif
 		local_irq_disable();
+		wdref = watchdog->read(watchdog);
 		csnow = cs->read(cs);
 		wdnow = watchdog->read(watchdog);
 		local_irq_enable();
 
+#ifdef CONFIG_IPIPE
+		wd_nsec = clocksource_cyc2ns((wdnow - wdref) & watchdog->mask,
+					     watchdog->mult, watchdog->shift);
+		if (wd_nsec > WATCHDOG_THRESHOLD)
+			goto retry;
+#endif
+
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
 		    atomic_read(&watchdog_reset_pending)) {
-- 
1.7.3.4

