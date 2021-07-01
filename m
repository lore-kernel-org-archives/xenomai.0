From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ipipe: Avoid recursive faults on root work overflow
Message-ID: <a2c9518f-8468-e8c5-c4fa-c266b29000be@siemens.com>
Date: Thu, 1 Jul 2021 09:19:24 +0200
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

On some archs, WARN* is implemented by triggering a fault. This can
cause troubles if we are already in a fault and try to submit too much
root work. Convert to open-coded warning and stack dump.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Doesn't solve the overflow you've seen, Mauro, but should give a better 
hint.

 kernel/ipipe/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 99a88e4d620e..485db973b81b 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -2027,9 +2027,16 @@ void __ipipe_post_work_root(struct ipipe_work_header *work)
 	cpu = ipipe_processor_id();
 	tail = per_cpu(work_tail, cpu);
 
-	if (WARN_ON_ONCE((unsigned char *)tail + work->size >=
-			 per_cpu(work_buf, cpu) + WORKBUF_SIZE))
+	if (unlikely((unsigned char *)tail + work->size >=
+		     per_cpu(work_buf, cpu) + WORKBUF_SIZE)) {
+		static volatile unsigned long once;
+		if (!test_and_set_bit(0, &once)) {
+			ipipe_prepare_panic();
+			pr_err("I-pipe root work queue overflow! System may be unstable now.\n");
+			dump_stack();
+		}
 		goto out;
+	}
 
 	/* Work handling is deferred, so data has to be copied. */
 	memcpy(tail, work, work->size);
-- 
2.26.2

