From: Henning Schild <henning.schild@siemens.com>
Date: Mon, 24 Oct 2016 19:39:46 +0200
Message-Id: <7050749da48fe07a7a47ecbc9872e37190e9b0e0.1477330570.git.henning.schild@siemens.com>
In-Reply-To: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
References: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
In-Reply-To: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
References: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/2] Revert "hal/x86: forbid compilation with
	Linux 4.0+"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This reverts commit 3cf927a630edd3a41a8fb06e7d66169338d95038.
---
 include/asm-x86/bits/pod.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-x86/bits/pod.h b/include/asm-x86/bits/pod.h
index 8a16713..6d19719 100644
--- a/include/asm-x86/bits/pod.h
+++ b/include/asm-x86/bits/pod.h
@@ -44,10 +44,6 @@ void xnpod_delete_thread(struct xnthread *);
 
 #define xnarch_stop_timer(cpu)	rthal_timer_release(cpu)
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
-#error "Xenomai x86 FPU support broken on Linux 4.0 and later"
-#endif
-
 static inline void xnarch_leave_root(xnarchtcb_t *rootcb)
 {
 	rthal_root_preempt_notify();
-- 
2.7.3


