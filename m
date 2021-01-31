From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 09/13] cobalt/x86: ipipe: remove obsolete calibration handler
Date: Sun, 31 Jan 2021 15:45:36 +0100
Message-Id: <20210131144540.243363-9-rpm@xenomai.org>
In-Reply-To: <20210131144540.243363-1-rpm@xenomai.org>
References: <20210131144540.243363-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/arch/x86/ipipe/machine.c | 39 +-------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/kernel/cobalt/arch/x86/ipipe/machine.c b/kernel/cobalt/arch/x86/ipipe/machine.c
index 4b25486da..95d2ab2ff 100644
--- a/kernel/cobalt/arch/x86/ipipe/machine.c
+++ b/kernel/cobalt/arch/x86/ipipe/machine.c
@@ -17,11 +17,9 @@
  *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  *   02111-1307, USA.
  */
-#include <linux/ipipe_tickdev.h>
-#include <cobalt/kernel/arith.h>
-#include <asm/xenomai/syscall.h>
 #include <asm/xenomai/machine.h>
 #include <asm/xenomai/thread.h>
+#include <asm/xenomai/syscall.h>
 #include <asm/xenomai/smi.h>
 #include <asm/xenomai/c1e.h>
 
@@ -44,40 +42,6 @@ long strncpy_from_user_nocheck(char *dst, const char __user *src, long count)
 }
 EXPORT_SYMBOL_GPL(strncpy_from_user_nocheck);
 
-static unsigned long mach_x86_calibrate(void)
-{
-	unsigned long delay = (cobalt_pipeline.timer_freq + HZ / 2) / HZ;
-	unsigned long long t0, t1, dt;
-	unsigned long flags;
-	int i;
-
-	flags = ipipe_critical_enter(NULL);
-
-	ipipe_timer_set(delay);
-
-	ipipe_read_tsc(t0);
-
-	for (i = 0; i < 100; i++)
-		ipipe_timer_set(delay);
-
-	ipipe_read_tsc(t1);
-	dt = t1 - t0;
-
-	ipipe_critical_exit(flags);
-
-	/*
-	 * Reset the max trace, since it contains the calibration time
-	 * now.
-	 */
-	ipipe_trace_max_reset();
-
-	/*
-	 * Compute average with a 5% margin to avoid negative
-	 * latencies with PIT.
-	 */
-	return xnarch_ulldiv(dt, i + 5, NULL);
-}
-
 static int mach_x86_init(void)
 {
 	int ret;
@@ -128,7 +92,6 @@ struct cobalt_machine cobalt_machine = {
 	.init = mach_x86_init,
 	.late_init = NULL,
 	.cleanup = mach_x86_cleanup,
-	.calibrate = mach_x86_calibrate,
 	.prefault = NULL,
 	.fault_labels = fault_labels,
 };
-- 
2.26.2


