From: Henning Schild <henning.schild@siemens.com>
Date: Mon, 24 Oct 2016 19:39:45 +0200
Message-Id: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/2] hal/x86: fix kernel-space FPU with 4.1 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Starting at kernel 4.1 we have a per-cpu flag for kernel fpu and do not
abuse the flag of current anymore. This patch is a minimal fix for
something that is hard to get your head around, but xenomai 2.6 will not
go beyond 4.1. So not effort to fix or document what is going on ...

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 include/asm-x86/bits/pod.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-x86/bits/pod.h b/include/asm-x86/bits/pod.h
index 678720a..8a16713 100644
--- a/include/asm-x86/bits/pod.h
+++ b/include/asm-x86/bits/pod.h
@@ -58,6 +58,10 @@ static inline void xnarch_leave_root(xnarchtcb_t *rootcb)
 	rootcb->spp = &current->thread.x86reg_sp;
 	rootcb->ipp = &current->thread.rip;
 #endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
+	if (kernel_fpu_disabled())
+		wrap_clear_fpu_used(current);
+#endif
 	rootcb->ts_usedfpu = !!wrap_test_fpu_used(current);
 	rootcb->cr0_ts = (read_cr0() & 8) != 0;
 	/* So that xnarch_save_fpu() will operate on the right FPU area. */
-- 
2.7.3


