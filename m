From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 05/10] dovetail/init: implement Xenomai stage enabling and
 disabling
Date: Mon, 11 Jan 2021 01:43:13 -0500
Message-Id: <20210111064318.6154-5-hongzhan.chen@intel.com>
In-Reply-To: <20210111064318.6154-1-hongzhan.chen@intel.com>
References: <20210111064318.6154-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/dovetail/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/init.c b/kernel/cobalt/dovetail/init.c
index 983186abe..bc891b4c1 100644
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
2.17.1


