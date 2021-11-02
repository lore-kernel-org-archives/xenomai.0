From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [dovetail][RFC PATCH 1/5] net/sched/sch_generic: Measure the time
 between watchdog runs
Date: Tue,  2 Nov 2021 17:09:51 +0100
Message-Id: <20211102160955.3067995-1-florian.bezdeka@siemens.com>
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

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

The output looks like that:

[36452.934159] dev_watchdog: cpu(6) jiffies(4331120128) jd(5072) ct(36452934152782) ctd(5119999)
[36458.054164] dev_watchdog: cpu(6) jiffies(4331125248) jd(5120) ct(36458054156389) ctd(5120003)
[36464.198155] dev_watchdog: cpu(6) jiffies(4331131392) jd(6144) ct(36464198148371) ctd(6143991)
[36469.830161] dev_watchdog: cpu(6) jiffies(4331137024) jd(5584) ct(36469830153958) ctd(5632005)
[36474.950166] dev_watchdog: cpu(6) jiffies(4331142144) jd(5105) ct(36474950159329) ctd(5120005)                              
[36480.070154] dev_watchdog: cpu(6) jiffies(4331147264) jd(5120) ct(36480070147773) ctd(5119988)
[36486.214156] dev_watchdog: cpu(6) jiffies(4331153408) jd(6097) ct(36486214149032) ctd(6144001)                                 
[36491.846164] dev_watchdog: cpu(6) jiffies(4331159040) jd(5632) ct(36491846157376) ctd(5632008)

The timer seems quite unstable on that machine. Even with
CONFIG_IRQ_PIPELINE=n the values are the same.

Is there a mistake in the time measurement code?

The timeout configured by that timer is 5*HZ, so 5 seconds. According to
the values above I see up to 6,14 seconds... 

Both systems I saw similar problems on are using jiffies for time
calculations. The global variable "jiffies" is incremented by the timer
interrupt. So I started thinking of delayed timer IRQs or timer IRQs
that are "merged" when being posted into the IRQ log. Merging should not
be a problem for real device IRQs, but timer IRQs might be "counting".

 net/sched/sch_generic.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 05aa2571a409..2e7d823a6fb4 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -439,6 +439,20 @@ static void dev_watchdog(struct timer_list *t)
 {
 	struct net_device *dev = from_timer(dev, t, watchdog_timer);
 
+	static unsigned long jiffies_prev = 0;
+	unsigned long jiffies_diff = jiffies - jiffies_prev;
+
+	static u64 core_time_prev = 0;
+	u64 core_time = local_clock();
+	u64 core_time_diff = (core_time - core_time_prev) / 1000; /* in us */
+
+	printk("dev_watchdog: cpu(%d) jiffies(%lu) jd(%lu) ct(%llu) ctd(%llu)\n",
+	       smp_processor_id(), jiffies, jiffies_diff, core_time,
+	       core_time_diff);
+
+	jiffies_prev = jiffies;
+	core_time_prev = core_time;
+
 	netif_tx_lock(dev);
 	if (!qdisc_tx_is_noop(dev)) {
 		if (netif_device_present(dev) &&
@@ -464,6 +478,13 @@ static void dev_watchdog(struct timer_list *t)
 
 			if (some_queue_timedout) {
 				trace_net_dev_xmit_timeout(dev, i);
+
+				printk("dev_watchdog: trigger: cpu(%d) jiffies(%lu) to(%lu) diff(%lu)\n",
+				       smp_processor_id(), jiffies,
+				       trans_start + dev->watchdog_timeo,
+				       jiffies - (trans_start +
+						  dev->watchdog_timeo));
+
 				WARN_ONCE(1, KERN_INFO "NETDEV WATCHDOG: %s (%s): transmit queue %u timed out\n",
 				       dev->name, netdev_drivername(dev), i);
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
-- 
2.30.2


