From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] cobalt/arm64: fpu: fixup for kernel 4.19+
Date: Sun,  1 Sep 2019 11:27:53 +0200
Message-Id: <20190901092753.13425-1-rpm@xenomai.org>
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

Starting from kernel 4.19, we need to restore the FPU context from our
scheduling tail.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/arch/arm64/thread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cobalt/arch/arm64/thread.c b/kernel/cobalt/arch/arm64/thread.c
index 270c99f92..719c30a62 100644
--- a/kernel/cobalt/arch/arm64/thread.c
+++ b/kernel/cobalt/arch/arm64/thread.c
@@ -139,6 +139,9 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
 	(void)last;
 #else
 	switch_to(prev, next, last);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0)
+	fpsimd_restore_current_state();
+#endif
 #endif
 }
 
-- 
2.21.0


