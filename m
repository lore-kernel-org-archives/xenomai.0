From: Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] cobalt/x86: fix condition in eager fpu code for kernels < 4.14
Date: Fri, 21 Dec 2018 14:44:52 +0100
Message-Id: <20181221134452.15743-1-henning.schild@siemens.com>
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
To: xenomai <xenomai@xenomai.org>

From: Henning Schild <henning.schild@siemens.com>

We should mark the current task as not owning the fpu anymore if it does
actually own the fpu, not if the fpu itself is active.

Fixes cb52e6c7438fa

Reported-by: Mauro Salvini <mauro.salvini@smigroup.net>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 kernel/cobalt/arch/x86/thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
index a09560075..0c6054338 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -475,7 +475,7 @@ void xnarch_leave_root(struct xnthread *root)
 	switch_fpu_finish(&current->thread.fpu, smp_processor_id());
 #else
 	/* mark current thread as not owning the FPU anymore */
-	if (&current->thread.fpu.fpstate_active)
+	if (&current->thread.fpu.fpregs_active)
 		fpregs_deactivate(&current->thread.fpu);
 #endif
 }
-- 
2.19.2


