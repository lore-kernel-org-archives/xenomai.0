From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:51 +0200
Message-Id: <cd18218973c91bd185c11a63b716a4a1e2537818.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 3/6] cobalt/posix: Remove task parameter from
	cobalt_thread_shadow
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

It's always current, and it can only be current.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sched.c  | 2 +-
 kernel/cobalt/posix/thread.c | 9 ++++-----
 kernel/cobalt/posix/thread.h | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 9b61193845..eca16f7647 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -755,7 +755,7 @@ int cobalt_sched_setscheduler_ex(pid_t pid,
 		if (u_winoff == NULL || pid != task_pid_vnr(current))
 			return -ESRCH;
 			
-		thread = cobalt_thread_shadow(current, &hkey, u_winoff);
+		thread = cobalt_thread_shadow(&hkey, u_winoff);
 		if (IS_ERR(thread))
 			return PTR_ERR(thread);
 
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index d75a593536..86f667488c 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -480,7 +480,7 @@ int cobalt_thread_setschedparam_ex(unsigned long pth,
 		if (u_winoff == NULL)
 			return -EINVAL;
 			
-		thread = cobalt_thread_shadow(current, &hkey, u_winoff);
+		thread = cobalt_thread_shadow(&hkey, u_winoff);
 		if (IS_ERR(thread))
 			return PTR_ERR(thread);
 
@@ -617,8 +617,7 @@ COBALT_SYSCALL(thread_create, init,
 }
 
 struct cobalt_thread *
-cobalt_thread_shadow(struct task_struct *p,
-		     struct cobalt_local_hkey *hkey,
+cobalt_thread_shadow(struct cobalt_local_hkey *hkey,
 		     __u32 __user *u_winoff)
 {
 	struct cobalt_thread *thread = NULL;
@@ -630,7 +629,7 @@ cobalt_thread_shadow(struct task_struct *p,
 
 	param_ex.sched_priority = 0;
 	trace_cobalt_pthread_create(hkey->u_pth, SCHED_NORMAL, &param_ex);
-	ret = pthread_create(&thread, SCHED_NORMAL, &param_ex, p);
+	ret = pthread_create(&thread, SCHED_NORMAL, &param_ex, current);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -640,7 +639,7 @@ cobalt_thread_shadow(struct task_struct *p,
 		return ERR_PTR(ret);
 	}
 
-	if (!thread_hash(hkey, thread, task_pid_vnr(p))) {
+	if (!thread_hash(hkey, thread, task_pid_vnr(current))) {
 		ret = -EAGAIN;
 		goto fail;
 	}
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index abbb203a13..5cc098afab 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -151,8 +151,7 @@ COBALT_SYSCALL_DECL(thread_create,
 		     int xid, __u32 __user *u_winoff));
 
 struct cobalt_thread *
-cobalt_thread_shadow(struct task_struct *p,
-		     struct cobalt_local_hkey *lhkey,
+cobalt_thread_shadow(struct cobalt_local_hkey *lhkey,
 		     __u32 __user *u_winoff);
 
 COBALT_SYSCALL_DECL(thread_setmode,
-- 
2.16.4


