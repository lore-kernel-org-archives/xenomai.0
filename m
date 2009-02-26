Message-ID: <49A6A437.3080204@domain.hid>
Date: Thu, 26 Feb 2009 15:16:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 3/3] native: Silent migration before
	self-deletion
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Silently migrate to Linux domain before starting a task self-deletion so
that we don't raise SIGXCPU during tear-down if T_WARNSW is set.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/skins/native/task.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index 24da8ef..f590b79 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -121,6 +121,9 @@ static void *rt_task_trampoline(void *cookie)
 	if (!err)
 		entry(cookie);
 
+	/* Silently migrate to avoid raising SIGXCPU on regular exit. */
+	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+
       fail:
 
 	pthread_exit((void *)err);
@@ -265,12 +268,18 @@ int rt_task_delete(RT_TASK *task)
 {
 	int err;
 
-	if (task && task->opaque2) {
+	if (!task || task->opaque == rt_task_self()->opaque) {
+		/* Silently migrate to avoid raising SIGXCPU. */
+		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+
+		pthread_exit(NULL);
+	}
+
+	if (task->opaque2) {
 		err = pthread_cancel((pthread_t)task->opaque2);
 		if (err)
 			return -err;
-	} else if (!task)
-		pthread_exit(NULL);
+	}
 
 	err = XENOMAI_SKINCALL1(__native_muxid, __native_task_delete, task);
 	if (err == -ESRCH)

