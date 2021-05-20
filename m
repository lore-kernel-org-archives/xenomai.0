From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 17/25] cobalt/tick: dovetail: implement pipeline_timer_name()
Date: Thu, 20 May 2021 23:44:27 +0200
Message-Id: <b3f4db82fdcee6d8279c09cd95acdc53f677fcd1.1621547075.git.jan.kiszka@siemens.com>
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

From: Hongzhan Chen <hongzhan.chen@intel.com>

Get the name of real device controlled by the proxy tick device.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/clock.h | 11 +----------
 kernel/cobalt/dovetail/tick.c                   | 12 ++++++++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index d5443a4fd6..82f02d4d77 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -21,16 +21,7 @@ static inline u64 pipeline_read_cycle_counter(void)
 
 void pipeline_set_timer_shot(unsigned long cycles);
 
-static inline const char *pipeline_timer_name(void)
-{
-	/*
-	 * Return the name of the current clock event chip, which is
-	 * the real device controlled by the proxy tick device.
-	 */
-	TODO();
-
-	return "?";
-}
+const char *pipeline_timer_name(void);
 
 static inline const char *pipeline_clock_name(void)
 {
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index a6633348b1..41aaa151a8 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -14,6 +14,18 @@
 
 static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
 
+const char *pipeline_timer_name(void)
+{
+	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
+	struct clock_event_device *real_dev = dev->real_device;
+
+	/*
+	 * Return the name of the current clock event chip, which is
+	 * the real device controlled by the proxy tick device.
+	 */
+	return real_dev->name;
+}
+
 void pipeline_set_timer_shot(unsigned long delay) /* ns */
 {
 	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
-- 
2.26.2


