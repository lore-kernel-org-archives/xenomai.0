From: Greg Gallagher <greg@embeddedgreg.com>
Subject: [PATCH 2/2] kernel: cobalt: Remove header file for newer kernels
Date: Wed, 27 Jan 2021 00:43:48 -0500
Message-Id: <20210127054348.2128285-2-greg@embeddedgreg.com>
In-Reply-To: <20210127054348.2128285-1-greg@embeddedgreg.com>
References: <20210127054348.2128285-1-greg@embeddedgreg.com>
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

5.4 kernels do not have compiler.h, only include this header file for kernels older then 5.4

Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
---
 kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
index 7444cc823..17be10339 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
@@ -29,7 +29,11 @@
 #define XNARCH_HOST_TICK_IRQ __ipipe_hrtimer_irq
 
 #include <asm/barrier.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
 #include <asm/compiler.h>
+#endif
+
 #include <asm/cmpxchg.h>
 #include <asm/switch_to.h>
 #include <asm/system_misc.h>
-- 
2.25.1


