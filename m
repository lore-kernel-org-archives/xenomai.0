From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/intr: Move IRQ exit trace point in non-shared case
Message-ID: <cc4d7e75-5e09-761e-b050-34e0f8e6e328@siemens.com>
Date: Thu, 5 Dec 2019 18:40:37 +0100
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

This was missed in cfa2c51de424.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/intr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index d6fc0af6fa..d45c223268 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -671,12 +671,12 @@ done:
 out:
 	switch_from_irqstats(sched, prev);
 
+	trace_cobalt_irq_exit(irq);
+
 	if (--sched->inesting == 0) {
 		sched->lflags &= ~XNINIRQ;
 		xnsched_run();
 	}
-
-	trace_cobalt_irq_exit(irq);
 }
 
 int __init xnintr_mount(void)
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

