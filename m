From: jamienstar@163.com
Subject: [PATCH] x86/fpu: fix compile error without kernel_fpu_disabled()
Date: Mon, 16 May 2022 23:32:42 +0800
Message-Id: <20220516153242.12622-1-jamienstar@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org
Cc: jamienstar@163.com, xenomai@xenomai.org

From: Jamie <jamienstar@163.com>

In v5.18-evl-rebase, function kernel_fpu_disabled() has been removed in
commit 59f5ede3bc0f("x86/fpu: Prevent FPU state corruption"), so we will
get compile error when CONFIG_DOVETAIL is enabled:
arch/x86/kernel/fpu/core.c:931:6: error: implicit declaration of function ‘kernel_fpu_disabled’; did you mean ‘perf_pmu_disable’? [-Werror=implicit-function-declaration]
  if (kernel_fpu_disabled()) {
      ^~~~~~~~~~~~~~~~~~~
      perf_pmu_disable
cc1: all warnings being treated as errors
So, fix it.

Signed-off-by: Jamie <jamienstar@163.com>
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 6a0d1e7f278f..c3adbbb73226 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -928,7 +928,7 @@ void fpu__suspend_inband(void)
 	 * preemption of an inband kernel context currently using the
 	 * fpu by a thread which resumes on the oob stage.
 	 */
-	if (kernel_fpu_disabled()) {
+	if (this_cpu_read(in_kernel_fpu)) {
 		save_fpregs_to_fpstate(kfpu);
 		__cpu_invalidate_fpregs_state();
 		oob_fpu_set_preempt(&tsk->thread.fpu);
-- 
2.17.1


