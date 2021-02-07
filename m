From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 10/18] cobalt/timer: ipipe: directly use the abstract
 interface for IPIs
Date: Sun,  7 Feb 2021 17:04:26 +0100
Message-Id: <20210207160434.2869121-10-rpm@xenomai.org>
In-Reply-To: <20210207160434.2869121-1-rpm@xenomai.org>
References: <20210207160434.2869121-1-rpm@xenomai.org>
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
 kernel/cobalt/ipipe/tick.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/ipipe/tick.c b/kernel/cobalt/ipipe/tick.c
index da1563a66..b711bedc0 100644
--- a/kernel/cobalt/ipipe/tick.c
+++ b/kernel/cobalt/ipipe/tick.c
@@ -187,7 +187,7 @@ int pipeline_install_tick_proxy(void)
 	nkclock.wallclock_offset =
 		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
 
-	ret = xntimer_setup_ipi();
+	ret = pipeline_request_timer_ipi(xnintr_core_clock_handler);
 	if (ret)
 		return ret;
 
@@ -244,7 +244,7 @@ fail:
 		ipipe_timer_stop(_cpu);
 	}
 
-	xntimer_release_ipi();
+	pipeline_free_timer_ipi();
 
 	return ret;
 }
@@ -270,7 +270,7 @@ void pipeline_uninstall_tick_proxy(void)
 	for_each_realtime_cpu(cpu)
 		ipipe_timer_stop(cpu);
 
-	xntimer_release_ipi();
+	pipeline_free_timer_ipi();
 
 #ifdef CONFIG_XENO_OPT_STATS_IRQS
 	xnintr_destroy(&nktimer);
-- 
2.26.2


