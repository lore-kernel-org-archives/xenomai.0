From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 21 Sep 2008 22:34:06 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_++q1IowGQNaujNT"
Message-Id: <200809212234.06587.niklaus.giger@domain.hid>
Subject: [Xenomai-core] xenomai-solo vxWorks: know whether a task is safe or
	not
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

--Boundary-00=_++q1IowGQNaujNT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

For various reasons we were forced to examine under vxWorks 5.5 the private
WIND_TCB safeCnt field to determine whether a task was "safe" or not.

With the attached patch I try to add a taskIsSafe procedure to xenomai-solo.
It is probably not free from race condition, as I do not know how to access
a pthread_mutex.

Would such (may be improved) patch find its way into the "official" trunk?

Best regards

-- 
NIklaus Giger


--Boundary-00=_++q1IowGQNaujNT
Content-Type: text/x-patch;
  charset="us-ascii";
  name="taskIsSafe.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="taskIsSafe.diff"

diff --git a/include/vxworks/taskInfo.h b/include/vxworks/taskInfo.h
index 61315d5..27b3cc6 100644
--- a/include/vxworks/taskInfo.h
+++ b/include/vxworks/taskInfo.h
@@ -50,6 +50,8 @@ TASK_ID taskNameToId(const char *name);
 
 TASK_ID taskIdDefault(TASK_ID task_id);
     
+BOOL taskIsSafe(TASK_ID task_id);
+
 BOOL taskIsReady(TASK_ID task_id);
 
 BOOL taskIsSuspended (TASK_ID task_id);
diff --git a/vxworks/taskLib.c b/vxworks/taskLib.c
index f6253b2..7dd52ae 100644
--- a/vxworks/taskLib.c
+++ b/vxworks/taskLib.c
@@ -595,7 +595,7 @@ STATUS taskSafe(void)
 	}
 
 	pthread_mutex_lock(&current->safelock);
-
+	current->safeCnt = 1;
 	return OK;
 }
 
@@ -615,11 +615,24 @@ STATUS taskUnsafe(void)
 		return ERROR;
 	}
 
+	current->safeCnt = 0;
 	pthread_mutex_unlock(&current->safelock);
 
 	return OK;
 }
 
+BOOL taskIsSafe(TASK_ID tid)
+{
+	struct wind_task *task = find_wind_task(tid);
+
+	if (task == NULL) {
+		errno = S_objLib_OBJ_ID_ERROR;
+		return ERROR;
+	}
+
+	return (task->safeCnt > 0);
+}
+
 STATUS taskIdVerify(TASK_ID tid)
 {
 	struct wind_task *task = find_wind_task(tid);
diff --git a/vxworks/taskLib.h b/vxworks/taskLib.h
index 299d059..f743270 100644
--- a/vxworks/taskLib.h
+++ b/vxworks/taskLib.h
@@ -42,6 +42,7 @@ struct wind_task_args {
 struct wind_task {
 
 	pthread_mutex_t safelock;
+	int	safeCnt;
 	sem_t barrier;
 
 	struct WIND_TCB *tcb;

--Boundary-00=_++q1IowGQNaujNT--

