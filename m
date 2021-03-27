From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/5] cobalt/sched: dovetail: disable separate per-IRQ
 statistics
Date: Sat, 27 Mar 2021 11:35:21 +0100
Message-Id: <20210327103524.2305814-3-rpm@xenomai.org>
In-Reply-To: <20210327103524.2305814-1-rpm@xenomai.org>
References: <20210327103524.2305814-1-rpm@xenomai.org>
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

This feature should be available directly from Dovetail.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index a266011d4..88953ff24 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -137,7 +137,7 @@ config XENO_OPT_STATS
 
 config XENO_OPT_STATS_IRQS
 	bool "Account IRQ handlers separatly"
-	depends on XENO_OPT_STATS
+	depends on XENO_OPT_STATS && IPIPE
 	default y
 	help
 	When enabled, the runtime of interrupt handlers is accounted
@@ -145,6 +145,8 @@ config XENO_OPT_STATS_IRQS
 	occurrence of shared interrupts is accounted on a per-handler
 	basis.
 
+	This option is available to legacy I-pipe builds only.
+
 config XENO_OPT_SHIRQ
 	bool "Shared interrupts"
 	help
-- 
2.29.2


