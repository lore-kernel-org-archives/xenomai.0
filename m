Message-ID: <6384510d-fcc5-d513-d169-0c8b7643e876@siemens.com>
Date: Wed, 15 Jun 2022 17:20:34 +0200
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3.2.x] cobalt/x86: Account for changes to switch_fpu_finish in
 5.4.182
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The signature of switch_fpu_finish changed in stable 5.4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/ipipe/thread.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
index dd97a5d32c..7e28903a42 100644
--- a/kernel/cobalt/arch/x86/ipipe/thread.c
+++ b/kernel/cobalt/arch/x86/ipipe/thread.c
@@ -425,7 +425,9 @@ void xnarch_leave_root(struct xnthread *root)
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 	/* restore current's fpregs */
 	__cpu_invalidate_fpregs_state();
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,182)
+	switch_fpu_finish(current);
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
 	switch_fpu_finish(&current->thread.fpu);
 #else
 	switch_fpu_finish(&current->thread.fpu, raw_smp_processor_id());
-- 
2.35.3

