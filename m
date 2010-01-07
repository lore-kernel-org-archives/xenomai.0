Message-ID: <4B460269.5050905@domain.hid>
Date: Thu, 07 Jan 2010 16:48:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c31001040212m7b20037fre7668fd46587881d@domain.hid>	<1262617295.2220.30.camel@domain.hid>	<1262618363.2220.33.camel@domain.hid>
	<b88603c31001040725v15b517c9rafd80a78298b5880@domain.hid>
In-Reply-To: <b88603c31001040725v15b517c9rafd80a78298b5880@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Deadlock with test apps in 2.5.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Correct, that is the same behavior I get. When I then kill the latency
> app, the other process is released and can go on.

Ok. I may have found an issue. Here is a patch, could you try it?

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 22bac6f..5de5227 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -174,6 +174,29 @@ static inline void set_switch_lock_owner(struct task_struct *p)
 
 #define rpi_p(t)	((t)->rpi != NULL)
 
+static inline struct xnthread *rpi_next(struct xnsched *sched)
+{
+	struct xnthread *thread;
+	spl_t s;
+
+	thread = xnsched_peek_rpi(sched);
+	while (thread && 
+	       xnthread_user_task(thread)->state != TASK_RUNNING &&
+	       !xnthread_test_info(thread, XNATOMIC)) {
+		xnsched_pop_rpi(thread);
+		thread->rpi = NULL;
+		xnlock_put_irqrestore(&sched->rpilock, s);
+		/* Do NOT nest the rpilock and nklock locks. */
+		xnlock_get_irqsave(&nklock, s);
+		xnsched_suspend_rpi(thread);
+		xnlock_put_irqrestore(&nklock, s);
+		xnlock_get_irqsave(&sched->rpilock, s);
+		thread = xnsched_peek_rpi(sched);
+	}
+
+	return thread;
+}
+
 static void rpi_push(struct xnsched *sched, struct xnthread *thread)
 {
 	struct xnsched_class *sched_class;
@@ -236,7 +259,7 @@ static void rpi_pop(struct xnthread *thread)
 		return;
 	}
 
-	top = xnsched_peek_rpi(sched);
+	top = rpi_next(sched);
 	if (likely(top == NULL)) {
 		prio = XNSCHED_IDLE_PRIO;
 		sched_class = &xnsched_class_idle;
@@ -310,7 +333,7 @@ static void rpi_clear_remote(struct xnthread *thread)
 	xnsched_pop_rpi(thread);
 	thread->rpi = NULL;
 
-	if (xnsched_peek_rpi(rpi) == NULL)
+	if (rpi_next(rpi) == NULL)
 		rcpu = xnsched_cpu(rpi);
 
 	xnlock_put_irqrestore(&rpi->rpilock, s);
@@ -407,7 +430,7 @@ static inline void rpi_switch(struct task_struct *next_task)
 	    xnthread_test_state(next, XNRPIOFF)) {
 		xnlock_get_irqsave(&sched->rpilock, s);
 
-		top = xnsched_peek_rpi(sched);
+		top = rpi_next(sched);
 		if (top) {
 			newprio = top->cprio;
 			newclass = top->sched_class;
@@ -495,7 +518,7 @@ void xnshadow_rpi_check(void)
 	struct xnthread *top;
  
  	xnlock_get(&sched->rpilock);
- 	top = xnsched_peek_rpi(sched);
+ 	top = rpi_next(sched);
  	xnlock_put(&sched->rpilock);
 
 	if (top == NULL && xnsched_root_class(sched) != &xnsched_class_idle)


-- 
					    Gilles.

