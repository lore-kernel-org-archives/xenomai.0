From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] Remove __work from PIPELINE_INBAND_WORK_INITIALIZER
Date: Wed,  6 Apr 2022 23:06:14 +0200
Message-Id: <20220406210614.17715-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

ipipe took a copy of the queued work, __work was used to determine how mu=
ch
bytes had to get copied.
With dovetail no copy as taken and the __work parameter is no longer
useful, so we can get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/kernel/dovetail/pipeline/inband_work.h | 2 +-
 include/cobalt/kernel/rtdm/driver.h                   | 3 +--
 kernel/cobalt/rtdm/drvlib.c                           | 3 +--
 kernel/cobalt/rtdm/fd.c                               | 3 +--
 kernel/cobalt/thread.c                                | 8 +++-----
 kernel/drivers/udd/udd.c                              | 3 +--
 6 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/inband_work.h b/incl=
ude/cobalt/kernel/dovetail/pipeline/inband_work.h
index af3d70fc6..a69bf651f 100644
--- a/include/cobalt/kernel/dovetail/pipeline/inband_work.h
+++ b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
@@ -17,7 +17,7 @@ struct pipeline_inband_work {
 	struct irq_work work;
 };
=20
-#define PIPELINE_INBAND_WORK_INITIALIZER(__work, __handler)		\
+#define PIPELINE_INBAND_WORK_INITIALIZER(__handler)			\
 	{								\
 		.work =3D IRQ_WORK_INIT((void (*)(struct irq_work *))__handler), \
 	}
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/=
rtdm/driver.h
index 930da34ed..d5f3dad34 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -924,8 +924,7 @@ static inline void rtdm_nrtsig_init(rtdm_nrtsig_t *nr=
t_sig,
 				    rtdm_nrtsig_handler_t handler, void *arg)
 {
 	nrt_sig->inband_work =3D (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(*nrt_sig,
-						 __rtdm_nrtsig_execute);
+		PIPELINE_INBAND_WORK_INITIALIZER(__rtdm_nrtsig_execute);
 	nrt_sig->handler =3D handler;
 	nrt_sig->arg =3D arg;
 }
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 4ae1ed672..4eaf3a57c 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1666,8 +1666,7 @@ static void lostage_schedule_work(struct pipeline_i=
nband_work *inband_work)
 static struct lostage_trigger_work {
 	struct pipeline_inband_work inband_work; /* Must be first. */
 } nrt_work =3D  {
-	.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(nrt_work,
-							lostage_schedule_work),
+	.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(lostage_schedule_work=
),
 };
=20
 /**
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index bbeea06ae..3c26534f3 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -304,8 +304,7 @@ static void lostage_trigger_close(struct pipeline_inb=
and_work *inband_work)
 static struct lostage_trigger_close {
 	struct pipeline_inband_work inband_work; /* Must be first. */
 } fd_closework =3D  {
-	.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(fd_closework,
-						lostage_trigger_close),
+	.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(lostage_trigger_close=
),
 };
=20
 static void __put_fd(struct rtdm_fd *fd, spl_t s)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index dfaef7564..41804b24f 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -151,7 +151,7 @@ static int map_kthread(struct xnthread *thread, struc=
t kthread_arg *ka)
 	trace_cobalt_lostage_request("wakeup", current);
=20
 	ka->inband_work =3D (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(*ka, do_parent_wakeup);
+		PIPELINE_INBAND_WORK_INITIALIZER(do_parent_wakeup);
 	pipeline_post_inband_work(ka);
=20
 	xnlock_get_irqsave(&nklock, s);
@@ -2047,8 +2047,7 @@ void xnthread_relax(int notify, int reason)
 {
 	struct task_struct *p =3D current;
 	struct lostage_wakeup wakework =3D {
-		.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(wakework,
-					lostage_task_wakeup),
+		.inband_work =3D PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup)=
,
 		.task =3D p,
 	};
 	struct xnthread *thread =3D xnthread_current();
@@ -2393,8 +2392,7 @@ void __xnthread_signal(struct xnthread *thread, int=
 sig, int arg)
 		return;
=20
 	sigwork->inband_work =3D (struct pipeline_inband_work)
-			PIPELINE_INBAND_WORK_INITIALIZER(*sigwork,
-							 lostage_task_signal);
+			PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_signal);
 	sigwork->task =3D xnthread_host_task(thread);
 	sigwork->signo =3D sig;
 	sigwork->sigval =3D sig =3D=3D SIGDEBUG ? arg | sigdebug_marker : arg;
diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index d263afc72..958208ec7 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -552,8 +552,7 @@ static void switch_irq_line(rtdm_irq_t *irqh, int ena=
ble, rtdm_event_t *done)
 		return;
=20
 	rq->inband_work =3D (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(*rq,
-					lostage_irqswitch_line);
+		PIPELINE_INBAND_WORK_INITIALIZER(lostage_irqswitch_line);
 	rq->irqh =3D irqh;
 	rq->enabled =3D enable;
 	rq->done =3D done;
--=20
2.26.2


