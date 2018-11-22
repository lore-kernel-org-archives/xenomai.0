Subject: [PATCH 2/2] cobalt: Make some private functions static
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <a0ae52fe-fa52-124e-b3e2-b82d2755fa10@siemens.com>
Message-ID: <c7330a0c-3655-1495-fade-682f6678a1f7@siemens.com>
Date: Thu, 22 Nov 2018 18:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <a0ae52fe-fa52-124e-b3e2-b82d2755fa10@siemens.com>
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
 kernel/cobalt/sched-idle.c | 10 +++++-----
 kernel/cobalt/sched-rt.c   | 10 +++++-----
 kernel/cobalt/sched-weak.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/cobalt/sched-idle.c b/kernel/cobalt/sched-idle.c
index e810294409..1f040c355e 100644
--- a/kernel/cobalt/sched-idle.c
+++ b/kernel/cobalt/sched-idle.c
@@ -29,19 +29,19 @@ static int xnsched_idle_setparam(struct xnthread *thread,
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
index 834b242605..66ad3d4d0d 100644
--- a/kernel/cobalt/sched-rt.c
+++ b/kernel/cobalt/sched-rt.c
@@ -97,19 +97,19 @@ static int xnsched_rt_setparam(struct xnthread *thread,
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
index a9933e48a8..3b42a8e987 100644
--- a/kernel/cobalt/sched-weak.c
+++ b/kernel/cobalt/sched-weak.c
@@ -53,14 +53,14 @@ static int xnsched_weak_setparam(struct xnthread *thread,
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

