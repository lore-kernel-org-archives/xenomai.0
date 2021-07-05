From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/tick: dovetail: Always read timer name from CPU 0
Message-ID: <cf5edbb1-56cc-dd31-c3f7-c164a3648cae@siemens.com>
Date: Mon, 5 Jul 2021 10:48:15 +0200
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

__this_cpu_read will generate a warning when called by
print_core_clock_status because the context is detected as preemptible.
Avoid this by picking up the name from CPU 0, just like ipipe_timer_name
did.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/tick.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index ac343e4d3d..873b62471e 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -16,7 +16,7 @@ static DEFINE_PER_CPU(struct clock_proxy_device *, proxy_device);
 
 const char *pipeline_timer_name(void)
 {
-	struct clock_proxy_device *dev = __this_cpu_read(proxy_device);
+	struct clock_proxy_device *dev = per_cpu(proxy_device, 0);
 	struct clock_event_device *real_dev = dev->real_device;
 
 	/*
-- 
2.26.2

