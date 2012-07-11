Message-ID: <4FFDC6A2.8050706@siemens.com>
Date: Wed, 11 Jul 2012 20:32:02 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH,
	forge] x86: Fix build breakage in 64-bit xnarch_leave_root
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/asm-x86/bits/pod_64.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86/bits/pod_64.h b/include/asm-x86/bits/pod_64.h
index 00b2438..546a4fa 100644
--- a/include/asm-x86/bits/pod_64.h
+++ b/include/asm-x86/bits/pod_64.h
@@ -42,7 +42,7 @@ static inline void xnarch_leave_root(xnarchtcb_t *rootcb)
 	rootcb->user_task = rootcb->active_task = current;
 	rootcb->rspp = &current->thread.sp;
 	rootcb->ripp = &current->thread.rip;
-	rootcb->ts_usedfpu = !!wrap_test_fpu_used(current)
+	rootcb->ts_usedfpu = !!wrap_test_fpu_used(current);
 	rootcb->cr0_ts = (read_cr0() & 8) != 0;
 	/* So that xnarch_save_fpu() will operate on the right FPU area. */
 	if (rootcb->cr0_ts || rootcb->ts_usedfpu)
-- 
1.7.3.4

