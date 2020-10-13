From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH][dovetail/wip] cobalt/init: enable Xenomai oob stage
Date: Tue, 13 Oct 2020 03:38:11 -0400
Message-Id: <20201013073811.4288-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

enable xenomai oob stage during init

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index bdf37f34a..9b1651528 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -225,6 +225,7 @@ static int __init mach_setup(void)
 			  (ipipe_irq_handler_t)__xnsched_run_handler,
 			  NULL, NULL);*/
 #warning TODO: Dovetail init
+	enable_oob_stage("Xenomai");
 
 	ret = xnclock_init(cobalt_pipeline.clock_freq);
 	if (ret)
-- 
2.17.1


