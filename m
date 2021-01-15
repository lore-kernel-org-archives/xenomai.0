From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH V2 4/8] dovetail/clock: implement pipeline_timer_name
Date: Thu, 14 Jan 2021 20:16:34 -0500
Message-Id: <20210115011639.15390-4-hongzhan.chen@intel.com>
In-Reply-To: <20210115011639.15390-1-hongzhan.chen@intel.com>
References: <20210115011639.15390-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

to get the name of the current clock event chip, which is the real
device controlled by the proxy tick device.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index db982d969..d2de1cd34 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -19,16 +19,7 @@ static inline u64 pipeline_read_cycle_counter(void)
 
 inline void pipeline_set_timer_shot(unsigned long cycles);
 
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
+inline const char *pipeline_timer_name(void);
 
 static inline const char *pipeline_clock_name(void)
 {
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 55039f96e..bf267b9d9 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -16,6 +16,18 @@ extern struct xnintr nktimer;
 
 static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
 
+inline const char *pipeline_timer_name(void)
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
 inline void pipeline_set_timer_shot(unsigned long cycles)
 {
 	/*
-- 
2.17.1


