From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon, 30 Sep 2013 21:21:55 +0200
Message-Id: <1380568915-32582-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH] x86/ipipe: get FPU backup area allocated for all
	threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

In order to be able to handle FPU faults in the Xenomai domain without
switching to the root domain, the FPU backup area must be systematically
allocated for all Linux tasks. Currently, the backup area is systematically
allocated in arch_dup_task_struct(), but gets freed upon exec by
flush_thread(). Stop freeing it in flush_thread(), there does not seem
to be any risk of leaking information, as the "used_math" flag is cleared
by drop_init_fpui() so that upon next fault, the context is reinitialized.
---
 arch/x86/kernel/process.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index a00bed1..4716eb2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -73,14 +73,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 		if (ret)
 			return ret;
 		fpu_copy(dst, src);
-	} else {
-#ifdef CONFIG_IPIPE
-		/* unconditionally allocate, RT domain may need it */
-		memset(&dst->thread.fpu, 0, sizeof(dst->thread.fpu));
-		ret = fpu_alloc(&dst->thread.fpu);
-		if (ret)
-			return ret;
-#endif
 	}
 	return 0;
 }
@@ -170,8 +162,8 @@ void flush_thread(void)
 	 * lazily at the first use.
 	 */
 	if (!use_eager_fpu())
-#endif
 		free_thread_xstate(tsk);
+#endif
 }
 
 static void hard_disable_TSC(void)
-- 
1.7.10.4


