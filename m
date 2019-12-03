From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 1/7] cobalt/posix/thread: Factor out thread_lookup_or_shadow
Date: Tue,  3 Dec 2019 12:32:11 +0100
Message-Id: <33e64f417b0ecf14bb9f97ffe91f4ce401ae34fb.1575372737.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575372737.git.jan.kiszka@siemens.com>
References: <cover.1575372737.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575372737.git.jan.kiszka@siemens.com>
References: <cover.1575372737.git.jan.kiszka@siemens.com>
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

This pattern will be reused by cobalt_thread_setschedprio.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/thread.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 30c31bb6d9..9f1c802b63 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -463,32 +463,46 @@ static inline int pthread_setmode_np(int clrmask, int setmask, int *mode_r)
 	return 0;
 }
 
-int cobalt_thread_setschedparam_ex(unsigned long pth,
-				   int policy,
-				   const struct sched_param_ex *param_ex,
-				   __u32 __user *u_winoff,
-				   int __user *u_promoted)
+static struct cobalt_thread *thread_lookup_or_shadow(unsigned long pth,
+						     __u32 __user *u_winoff,
+						     int *promoted_r)
 {
 	struct cobalt_local_hkey hkey;
 	struct cobalt_thread *thread;
-	int ret, promoted = 0;
+
+	*promoted_r = 0;
 
 	hkey.u_pth = pth;
 	hkey.mm = current->mm;
-	trace_cobalt_pthread_setschedparam(pth, policy, param_ex);
 
 	thread = thread_lookup(&hkey);
 	if (thread == NULL) {
 		if (u_winoff == NULL)
-			return -ESRCH;
+			return ERR_PTR(-ESRCH);
 			
 		thread = cobalt_thread_shadow(&hkey, u_winoff);
-		if (IS_ERR(thread))
-			return PTR_ERR(thread);
-
-		promoted = 1;
+		if (!IS_ERR(thread))
+			*promoted_r = 1;
 	}
 
+	return thread;
+}
+
+int cobalt_thread_setschedparam_ex(unsigned long pth,
+				   int policy,
+				   const struct sched_param_ex *param_ex,
+				   __u32 __user *u_winoff,
+				   int __user *u_promoted)
+{
+	struct cobalt_thread *thread;
+	int ret, promoted;
+
+	trace_cobalt_pthread_setschedparam(pth, policy, param_ex);
+
+	thread = thread_lookup_or_shadow(pth, u_winoff, &promoted);
+	if (IS_ERR(thread))
+		return PTR_ERR(thread);
+
 	ret = __cobalt_thread_setschedparam_ex(thread, policy, param_ex);
 	if (ret)
 		return ret;
-- 
2.16.4


