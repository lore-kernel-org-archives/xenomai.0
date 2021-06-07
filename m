From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH v3 3/3] irq_pipeline: Warn when calling
 irqentry_enter with oob stalled
Date: Mon,  7 Jun 2021 08:19:39 +0200
Message-Id: <a51eccb6e2f70a6ca5a0061069c13c3e184cecab.1623046779.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623046779.git.jan.kiszka@siemens.com>
References: <cover.1623046779.git.jan.kiszka@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Something must have went wrong if entering for an IRQ or an exception
over oob and with this stage stalled. Warn when debugging

Suggest-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/entry/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 35a6f6a4a1ba..a6c0236850ad 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -410,6 +410,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 
 #ifdef CONFIG_IRQ_PIPELINE
 	if (running_oob()) {
+		WARN_ON_ONCE(irq_pipeline_debug() && oob_irqs_disabled());
 		ret.stage_info = IRQENTRY_OOB;
 		return ret;
 	}
-- 
2.26.2


