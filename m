From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 11/18] cobalt/timer: remove useless wrappers to IPI management
Date: Sun,  7 Feb 2021 17:04:27 +0100
Message-Id: <20210207160434.2869121-11-rpm@xenomai.org>
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
 include/cobalt/kernel/timer.h | 11 -----------
 kernel/cobalt/timer.c         | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/include/cobalt/kernel/timer.h b/include/cobalt/kernel/timer.h
index 691be7a3b..703a13506 100644
--- a/include/cobalt/kernel/timer.h
+++ b/include/cobalt/kernel/timer.h
@@ -517,10 +517,6 @@ void xntimer_migrate(struct xntimer *timer, struct xnsched *sched)
 		__xntimer_migrate(timer, sched);
 }
 
-int xntimer_setup_ipi(void);
-
-void xntimer_release_ipi(void);
-
 void __xntimer_set_affinity(struct xntimer *timer,
 			    struct xnsched *sched);
 
@@ -539,13 +535,6 @@ static inline void xntimer_migrate(struct xntimer *timer,
 	timer->sched = sched;
 }
 
-static inline int xntimer_setup_ipi(void)
-{
-	return 0;
-}
-
-static inline void xntimer_release_ipi(void) { }
-
 static inline void xntimer_set_affinity(struct xntimer *timer,
 					struct xnsched *sched)
 {
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 7f5033c87..f9aa457ce 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -574,16 +574,6 @@ void __xntimer_set_affinity(struct xntimer *timer, struct xnsched *sched)
 }
 EXPORT_SYMBOL_GPL(__xntimer_set_affinity);
 
-int xntimer_setup_ipi(void)
-{
-	return pipeline_request_timer_ipi(xnintr_core_clock_handler);
-}
-
-void xntimer_release_ipi(void)
-{
-	pipeline_free_timer_ipi();
-}
-
 #endif /* CONFIG_SMP */
 
 /**
-- 
2.26.2


