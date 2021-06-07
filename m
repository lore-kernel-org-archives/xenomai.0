From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH v3 2/3] irq_pipeline: Account for stage migration
 across faults
Date: Mon,  7 Jun 2021 08:19:38 +0200
Message-Id: <52f3c6c18cb3b80f25c103ae022d6244f236c6b8.1623046779.git.jan.kiszka@siemens.com>
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

We need to unstall the inband stage when we entered for a fault over OOB
and then migrated to inband. So far we kept the inband stage stalled,
causing a state corruption this way.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/entry/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5a669f87ec3f..35a6f6a4a1ba 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -577,9 +577,11 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 	/*
 	 * If pipelining interrupts, clear the in-band stall bit if
 	 * irqentry_enter() raised it in order to mirror the hardware
-	 * state.
+	 * state. Also clear it when we where coming from oob, thus went
+	 * through a migration that was caused by taking, e.g., a fault.
 	 */
-	if (state.stage_info == IRQENTRY_INBAND_UNSTALLED)
+	if (state.stage_info == IRQENTRY_INBAND_UNSTALLED ||
+	    state.stage_info == IRQENTRY_OOB)
 		unstall_inband();
 #endif
 	return;
-- 
2.26.2


