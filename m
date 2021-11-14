From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] cobalt/syscall: dovetail: enable propagation from
 handle_oob_syscall()
Date: Sun, 14 Nov 2021 11:03:48 +0100
Message-Id: <20211114100348.1235576-1-rpm@xenomai.org>
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

Since release v5.10.76-dovetail3, handle_oob_syscall() should return a
propagation status just like handle_pipelined_syscall(), with the same
semantics. This is a requirement for properly handling our syscall
format and the new prctl-based one concurrently. Fix up the signature
accordingly.  This status is ignored on earlier Dovetail releases.

In addition, CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE is checked for
enabling our current syscall format, which defaults to y at the
moment.  Force it on regardless to allow for detection when this call
format is eventually deprecated upstream.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/dovetail/syscall.c | 5 ++---
 scripts/Kconfig.frag             | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/dovetail/syscall.c b/kernel/cobalt/dovetail/syscall.c
index cec6c0244..440c069d5 100644
--- a/kernel/cobalt/dovetail/syscall.c
+++ b/kernel/cobalt/dovetail/syscall.c
@@ -19,8 +19,7 @@ int handle_pipelined_syscall(struct irq_stage *stage, struct pt_regs *regs)
 	return handle_head_syscall(stage == &inband_stage, regs);
 }
 
-void handle_oob_syscall(struct pt_regs *regs)
+int handle_oob_syscall(struct pt_regs *regs)
 {
-	int ret = handle_head_syscall(false, regs);
-	XENO_BUG_ON(COBALT, ret == KEVENT_PROPAGATE);
+	return handle_head_syscall(false, regs);
 }
diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index dd91dc6c9..792128663 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -4,6 +4,7 @@ menuconfig XENOMAI
 	select IPIPE if HAVE_IPIPE_SUPPORT
 	select IPIPE_WANT_APIREV_2 if IPIPE
 	select DOVETAIL if HAVE_DOVETAIL
+	select DOVETAIL_LEGACY_SYSCALL_RANGE if HAVE_DOVETAIL
 	default y
 	help
 	  Xenomai's Cobalt core is a real-time extension to the Linux
-- 
2.31.1


