From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ipipe: Dump panic traces with KERN_EMERG
Message-ID: <c4e99800-8758-acf0-1418-df9b7c289c07@siemens.com>
Date: Mon, 6 Apr 2020 13:57:26 +0200
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

This is in line with what ftrace does and ensures that setups with
lowered log levels will not miss this important information.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Corresponding patch for 4.4.y-cip will be queued as well.

 kernel/ipipe/tracer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index 2d75199b086b..d0f7cc95c799 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -680,7 +680,7 @@ void ipipe_trace_panic_dump(void)
 
 	ipipe_context_check_off();
 
-	printk(KERN_CONT "I-pipe tracer log (%d points):\n", cnt);
+	printk(KERN_EMERG "I-pipe tracer log (%d points):\n", cnt);
 
 	start = pos = WRAP_POINT_NO(panic_path->trace_pos-1);
 
@@ -690,7 +690,7 @@ void ipipe_trace_panic_dump(void)
 		char info[16];
 		int i;
 
-		printk(KERN_CONT " %c",
+		printk(KERN_EMERG " %c",
 		       (point->flags & IPIPE_TFLG_HWIRQ_OFF) ? '|' : ' ');
 
 		for (i = IPIPE_TFLG_DOMSTATE_BITS; i >= 0; i--)
@@ -720,7 +720,8 @@ void ipipe_trace_panic_dump(void)
 
 				case IPIPE_TRACE_EVENT:
 					__ipipe_get_event_date(info,
-							       panic_path, point);
+							       panic_path,
+							       point);
 					printk(KERN_CONT "%s", info);
 					break;
 
-- 
2.16.4

