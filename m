From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] cobalt: Make some private functions static
Message-ID: <d01096f3-3796-f341-b8ca-7844b956babc@siemens.com>
Date: Wed, 28 Nov 2018 08:06:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - decouple from "cobalt: Return error from xnsched_setparam" which is
   going to be addressed differently

 kernel/cobalt/sched-idle.c | 14 +++++++-------
 kernel/cobalt/sched-rt.c   | 14 +++++++-------
 kernel/cobalt/sched-weak.c | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/cobalt/sched-idle.c b/kernel/cobalt/sched-idle.c
index e5ca8aee87..e6799824a8 100644
--- a/kernel/cobalt/sched-idle.c
+++ b/kernel/cobalt/sched-idle.c
@@ -23,25 +23,25 @@ static struct xnthread *xnsched_idle_pick(struct xnsched *sched)
 	return &sched->rootcb;
 }
 
-bool xnsched_idle_setparam(struct xnthread *thread,
-			   const union xnsched_policy_param *p)
+static bool xnsched_idle_setparam(struct xnthread *thread,
+				  const union xnsched_policy_param *p)
 {
 	return __xnsched_idle_setparam(thread, p);
 }
 
-void xnsched_idle_getparam(struct xnthread *thread,
-			   union xnsched_policy_param *p)
+static void xnsched_idle_getparam(struct xnthread *thread,
+				  union xnsched_policy_param *p)
 {
 	__xnsched_idle_getparam(thread, p);
 }
 
-void xnsched_idle_trackprio(struct xnthread *thread,
-			   const union xnsched_policy_param *p)
+static void xnsched_idle_trackprio(struct xnthread *thread,
+				   const union xnsched_policy_param *p)
 {
 	__xnsched_idle_trackprio(thread, p);
 }
 
-void xnsched_idle_protectprio(struct xnthread *thread, int prio)
+static void xnsched_idle_protectprio(struct xnthread *thread, int prio)
 {
 	__xnsched_idle_protectprio(thread, prio);
 }
diff --git a/kernel/cobalt/sched-rt.c b/kernel/cobalt/sched-rt.c
index 114ddad214..24570322a0 100644
--- a/kernel/cobalt/sched-rt.c
+++ b/kernel/cobalt/sched-rt.c
@@ -91,25 +91,25 @@ void xnsched_rt_tick(struct xnsched *sched)
 	xnsched_putback(sched->curr);
 }
 
-bool xnsched_rt_setparam(struct xnthread *thread,
-			 const union xnsched_policy_param *p)
+static bool xnsched_rt_setparam(struct xnthread *thread,
+				const union xnsched_policy_param *p)
 {
 	return __xnsched_rt_setparam(thread, p);
 }
 
-void xnsched_rt_getparam(struct xnthread *thread,
-			 union xnsched_policy_param *p)
+static void xnsched_rt_getparam(struct xnthread *thread,
+				union xnsched_policy_param *p)
 {
 	__xnsched_rt_getparam(thread, p);
 }
 
-void xnsched_rt_trackprio(struct xnthread *thread,
-			  const union xnsched_policy_param *p)
+static void xnsched_rt_trackprio(struct xnthread *thread,
+				 const union xnsched_policy_param *p)
 {
 	__xnsched_rt_trackprio(thread, p);
 }
 
-void xnsched_rt_protectprio(struct xnthread *thread, int prio)
+static void xnsched_rt_protectprio(struct xnthread *thread, int prio)
 {
 	__xnsched_rt_protectprio(thread, prio);
 }
diff --git a/kernel/cobalt/sched-weak.c b/kernel/cobalt/sched-weak.c
index fc778b8535..bd3872f104 100644
--- a/kernel/cobalt/sched-weak.c
+++ b/kernel/cobalt/sched-weak.c
@@ -44,8 +44,8 @@ static struct xnthread *xnsched_weak_pick(struct xnsched *sched)
 	return xnsched_getq(&sched->weak.runnable);
 }
 
-bool xnsched_weak_setparam(struct xnthread *thread,
-			   const union xnsched_policy_param *p)
+static bool xnsched_weak_setparam(struct xnthread *thread,
+				  const union xnsched_policy_param *p)
 {
 	if (!xnthread_test_state(thread, XNBOOST))
 		xnthread_set_state(thread, XNWEAK);
@@ -53,14 +53,14 @@ bool xnsched_weak_setparam(struct xnthread *thread,
 	return xnsched_set_effective_priority(thread, p->weak.prio);
 }
 
-void xnsched_weak_getparam(struct xnthread *thread,
-			   union xnsched_policy_param *p)
+static void xnsched_weak_getparam(struct xnthread *thread,
+				  union xnsched_policy_param *p)
 {
 	p->weak.prio = thread->cprio;
 }
 
-void xnsched_weak_trackprio(struct xnthread *thread,
-			    const union xnsched_policy_param *p)
+static void xnsched_weak_trackprio(struct xnthread *thread,
+				   const union xnsched_policy_param *p)
 {
 	if (p)
 		thread->cprio = p->weak.prio;
@@ -68,7 +68,7 @@ void xnsched_weak_trackprio(struct xnthread *thread,
 		thread->cprio = thread->bprio;
 }
 
-void xnsched_weak_protectprio(struct xnthread *thread, int prio)
+static void xnsched_weak_protectprio(struct xnthread *thread, int prio)
 {
   	if (prio > XNSCHED_WEAK_MAX_PRIO)
 		prio = XNSCHED_WEAK_MAX_PRIO;
-- 
2.16.4

