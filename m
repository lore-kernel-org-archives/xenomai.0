From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 10/13] cobalt/powerpc: ipipe: remove obsolete calibration
 handler
Date: Sun, 31 Jan 2021 15:45:37 +0100
Message-Id: <20210131144540.243363-10-rpm@xenomai.org>
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
 kernel/cobalt/arch/powerpc/ipipe/machine.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cobalt/arch/powerpc/ipipe/machine.c b/kernel/cobalt/arch/powerpc/ipipe/machine.c
index 2e1643a24..14e2c4f90 100644
--- a/kernel/cobalt/arch/powerpc/ipipe/machine.c
+++ b/kernel/cobalt/arch/powerpc/ipipe/machine.c
@@ -24,11 +24,6 @@
 #include <asm/cputable.h>
 #include <asm/xenomai/machine.h>
 
-static unsigned long mach_powerpc_calibrate(void)
-{
-	return 5;	/* 5 clock cycles. */
-}
-
 static int mach_powerpc_init(void)
 {
 #ifdef CONFIG_ALTIVEC
@@ -67,7 +62,6 @@ struct cobalt_machine cobalt_machine = {
 	.init = mach_powerpc_init,
 	.late_init = NULL,
 	.cleanup = NULL,
-	.calibrate = mach_powerpc_calibrate,
 	.prefault = NULL,
 	.fault_labels = fault_labels,
 };
-- 
2.26.2


