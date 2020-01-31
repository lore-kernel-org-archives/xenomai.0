From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/3] lib/alchemy/testsuite: Add event test case for EV_ALL bug
Date: Fri, 31 Jan 2020 15:37:58 +0100
Message-Id: <6acf665fca26973c97a2961a66e85f17785eaaee.1580481480.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1580481480.git.jan.kiszka@siemens.com>
References: <cover.1580481480.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1580481480.git.jan.kiszka@siemens.com>
References: <cover.1580481480.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This fails so far due to a bug in the event wait implementations, both
with cobalt and mercury.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/testsuite/event-1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/alchemy/testsuite/event-1.c b/lib/alchemy/testsuite/event-1.c
index fdf962736e..0893df36de 100644
--- a/lib/alchemy/testsuite/event-1.c
+++ b/lib/alchemy/testsuite/event-1.c
@@ -63,6 +63,7 @@ static void foreground_task(void *arg)
 
 int main(int argc, char *const argv[])
 {
+	unsigned int flags;
 	int ret;
 
 	traceobj_init(&trobj, argv[0], 0);
@@ -70,6 +71,14 @@ int main(int argc, char *const argv[])
 	ret = rt_event_create(&event, "EVENT", 0, EV_FIFO);
 	traceobj_check(&trobj, ret, 0);
 
+	ret = rt_event_signal(&event, 0x3);
+	traceobj_check(&trobj, ret, 0);
+	ret = rt_event_wait(&event, 0x1, &flags, EV_ALL, TM_NONBLOCK);
+	traceobj_check(&trobj, ret, 0);
+	traceobj_assert(&trobj, flags == 0x1);
+	ret = rt_event_clear(&event, 0x3, NULL);
+	traceobj_check(&trobj, ret, 0);
+
 	ret = rt_task_create(&t_bgnd, "BGND", 0,  20, 0);
 	traceobj_check(&trobj, ret, 0);
 
-- 
2.16.4


