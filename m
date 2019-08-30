From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] cobalt/sched: tp: check partition id obtained from user
Date: Fri, 30 Aug 2019 18:05:14 +0200
Message-Id: <20190830160514.29592-2-rpm@xenomai.org>
In-Reply-To: <20190830160514.29592-1-rpm@xenomai.org>
References: <20190830160514.29592-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/sched-tp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cobalt/sched-tp.c b/kernel/cobalt/sched-tp.c
index d3e2586b0..ccff37428 100644
--- a/kernel/cobalt/sched-tp.c
+++ b/kernel/cobalt/sched-tp.c
@@ -168,6 +168,10 @@ static int xnsched_tp_chkparam(struct xnthread *thread,
 {
 	struct xnsched_tp *tp = &thread->sched->tp;
 
+	if (p->tp.ptid < 0 ||
+		p->tp.ptid >= CONFIG_XENO_OPT_SCHED_TP_NRPART)
+		return -EINVAL;
+
 	if (tp->gps == NULL ||
 	    p->tp.prio < XNSCHED_TP_MIN_PRIO ||
 	    p->tp.prio > XNSCHED_TP_MAX_PRIO)
-- 
2.21.0


