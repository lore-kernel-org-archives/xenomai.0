From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] arm64: irq_pipeline: fix unbalanced RCU entry/exit on
 fault
Date: Wed,  4 Aug 2021 19:47:11 +0200
Message-Id: <20210804174711.4021807-4-rpm@xenomai.org>
In-Reply-To: <20210804174711.4021807-1-rpm@xenomai.org>
References: <20210804174711.4021807-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

We may switch in-band as a result of handling a trap. If we were
running out-of-band on kernel entry, we must not perform the RCU exit
upon leaving the exception since we did not enter RCU in the first
place.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/arm64/kernel/entry-common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 0df59c02dcc07de..0d9fe3d59fc97ec 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -43,9 +43,17 @@ static void noinstr __enter_from_kernel_mode(struct pt_regs *regs)
 static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_IRQ_PIPELINE
+	/*
+	 * CAUTION: we may switch in-band as a result of handling a
+	 * trap, so if we are running out-of-band, we must make sure
+	 * not to perform the RCU exit since we did not enter it in
+	 * the first place.
+	 */
 	regs->oob_on_entry = running_oob();
-	if (regs->oob_on_entry)
+	if (regs->oob_on_entry) {
+		regs->exit_rcu = false;
 		return;
+	}
 
 	/*
 	 * We trapped from kernel space running in-band, we need to
-- 
2.31.1


