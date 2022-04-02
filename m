From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] x86: dovetail: reinstate I/O bitmap on out-of-band user
 entry
Date: Sat,  2 Apr 2022 16:21:27 +0200
Message-Id: <20220402142127.944138-4-rpm@xenomai.org>
In-Reply-To: <20220402142127.944138-1-rpm@xenomai.org>
References: <20220402142127.944138-1-rpm@xenomai.org>
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

We have to fix up the TSS with the proper I/O bitmap settings in
arch_dovetail_switch_finish() when the current task is about to
re-enter user mode on the out-of-band stage, along with reloading the
fpu context if need be.

This fixes an application crash observed when a user code would rely
on iopl() to raise the current I/O permissions, which would then
relinquish the CPU to a task invalidating them, before the initial
task eventually resumes in user mode on the out-of-band stage
(typically seen during an in-band -> out-of-band stage switch).

See https://xenomai.org/pipermail/xenomai/2022-March/047451.html.

Reported-by: Richard Weinberger <richard.weinberger@gmail.com>
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/include/asm/dovetail.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/dovetail.h b/arch/x86/include/asm/dovetail.h
index 9cf811fe98ba..0e0f93cb53d0 100644
--- a/arch/x86/include/asm/dovetail.h
+++ b/arch/x86/include/asm/dovetail.h
@@ -9,6 +9,7 @@
 #if !defined(__ASSEMBLY__) && defined(CONFIG_DOVETAIL)
 
 #include <asm/fpu/api.h>
+#include <asm/io_bitmap.h>
 
 static inline void arch_dovetail_exec_prepare(void)
 {
@@ -23,13 +24,17 @@ void arch_dovetail_switch_prepare(bool leave_inband)
 }
 
 static inline
-void arch_dovetail_switch_finish(bool enter_inband)
+void arch_dovetail_switch_finish(bool enter_inband, unsigned int ti_work)
 {
-	if (enter_inband)
+	if (enter_inband) {
 		fpu__resume_inband();
-	else if (!(current->flags & PF_KTHREAD) &&
-		test_thread_flag(TIF_NEED_FPU_LOAD))
-		switch_fpu_return();
+	} else {
+		  if (unlikely(ti_work & _TIF_IO_BITMAP))
+			  tss_update_io_bitmap();
+		  if (unlikely(ti_work & _TIF_NEED_FPU_LOAD &&
+				  !(current->flags & PF_KTHREAD)))
+			  switch_fpu_return();
+	}
 }
 
 #endif
-- 
2.34.1


