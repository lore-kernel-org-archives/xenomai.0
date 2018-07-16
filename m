From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:49 +0200
Message-Id: <c88831c6c7f0231853051628589a8532d411e2ab.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 1/6] cobalt/posix: Harden cobalt_thread_shadow
	against invalid requests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

If the caller has already a Xenomai shadow, we will crash rather than
failing gracefully. The reason is that pthread_discard expects secondary
mode - which may not be the case if the caller is already able to
migrate. So check early and avoid that we can run into this trap.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/thread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index b5809e840b..d75a593536 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -625,6 +625,9 @@ cobalt_thread_shadow(struct task_struct *p,
 	struct sched_param_ex param_ex;
 	int ret;
 
+	if (xnthread_current())
+		return ERR_PTR(-EBUSY);
+
 	param_ex.sched_priority = 0;
 	trace_cobalt_pthread_create(hkey->u_pth, SCHED_NORMAL, &param_ex);
 	ret = pthread_create(&thread, SCHED_NORMAL, &param_ex, p);
-- 
2.16.4


