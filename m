From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 13/25] cobalt/init: dovetail: add oob stage enabling,
 disabling services
Date: Thu, 20 May 2021 23:44:23 +0200
Message-Id: <077be2e9efb355240c89e7709ae4d2e16c474d05.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Hongzhan Chen <hongzhan.chen@intel.com>

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/init.c b/kernel/cobalt/dovetail/init.c
index 983186abe1..bc891b4c13 100644
--- a/kernel/cobalt/dovetail/init.c
+++ b/kernel/cobalt/dovetail/init.c
@@ -20,7 +20,7 @@ int __init pipeline_init(void)
 	}
 
 	/* Enable the Xenomai out-of-band stage */
-	TODO();
+	enable_oob_stage("Xenomai");
 
 	ret = xnclock_init();
 	if (ret)
@@ -46,7 +46,7 @@ int __init pipeline_late_init(void)
 __init void pipeline_cleanup(void)
 {
 	/* Disable the Xenomai stage */
-	TODO();
+	disable_oob_stage();
 
 	xnclock_cleanup();
 }
-- 
2.26.2


