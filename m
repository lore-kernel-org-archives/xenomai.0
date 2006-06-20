From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 20 Jun 2006 19:08:28 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MuCmE5GuaSgmWiy"
Message-Id: <200606201908.28728.niklaus.giger@domain.hid>
Subject: [Xenomai-core] More testcases for vxworks skin task handling?
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_MuCmE5GuaSgmWiy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles

I did some more testing, about how the vxWorks skins handles 
taskSpawn/taskInit and taskName.

I did not discover any differences between running it on my board under 
vxworks and under using the Xenomai simulator on my PowerBook.

There are probably some tests that you consider redundant, so please feel free 
to minimize is.

It is very nice to have an infrastructure where I can easily add testcases and 
verify that everything is okay! Congratulations for all your work on the 
simulator and the skins!

Best regards

-- 
Niklaus Giger

--Boundary-00=_MuCmE5GuaSgmWiy
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vx_task.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vx_task.patch"

Index: t010823-1.c
===================================================================
--- t010823-1.c	(Revision 1240)
+++ t010823-1.c	(Arbeitskopie)
@@ -28,16 +28,20 @@
  * - taskTcb
  * - taskSafe
  * - taskUnsafe
+ * - taskName
  *
  */
 
 #include <vxworks_test.h>
 
 static WIND_TCB peerTcb;
+static WIND_TCB peerTcbPrio18;
+static WIND_TCB peerTcbPrio21;
 
 void peerTask  (long a0, long a1, long a2, long a3, long a4,
 		long a5, long a6, long a7, long a8, long a9)
 {
+    int rc; 
     WIND_TCB *pTcb = taskTcb(taskIdSelf());
     TEST_ASSERT(pTcb == &peerTcb);
 
@@ -53,9 +57,65 @@
 
     TEST_ASSERT_OK(taskUnsafe());
 
+    rc = strcmp(taskName(taskIdSelf()),"peerTask");
+    TEST_ASSERT(rc == 0);
+    rc = strcmp(taskName(0),"peerTask");
+    TEST_ASSERT(rc == 0);
+
     TEST_MARK();
 }
 
+void peerTaskPrio18  (long a0, long a1, long a2, long a3, long a4,
+		long a5, long a6, long a7, long a8, long a9)
+{
+    int rc; 
+    int prio;
+    TEST_MARK();
+    taskPriorityGet(taskIdSelf(),&prio);
+    TEST_ASSERT(prio == 18);
+    TEST_MARK();
+    rc = strcmp(taskName(taskIdSelf()),"peerPrio18");
+    TEST_ASSERT(rc == 0);
+    rc = strcmp(taskName(0),"peerPrio18");
+    TEST_ASSERT(rc == 0);
+    TEST_MARK();
+}
+
+
+void peerTaskPrio20  (long a0, long a1, long a2, long a3, long a4,
+		long a5, long a6, long a7, long a8, long a9)
+{
+    int rc; 
+    int prio;
+    TEST_MARK();
+    taskPriorityGet(taskIdSelf(),&prio);
+    TEST_ASSERT(prio == 20);
+    TEST_MARK();
+    rc = strcmp(taskName(taskIdSelf()),"peerPrio20");
+    TEST_ASSERT(rc == 0);
+    rc = strcmp(taskName(0),"peerPrio20");
+    TEST_ASSERT(rc == 0);
+    TEST_MARK();
+}
+
+void peerTaskPrio21  (long a0, long a1, long a2, long a3, long a4,
+		long a5, long a6, long a7, long a8, long a9)
+{
+    int rc; 
+    int prio;
+    TEST_MARK();
+    taskPriorityGet(taskIdSelf(),&prio);
+    TEST_ASSERT(prio == 21);
+    TEST_MARK();
+    rc = strcmp(taskName(taskIdSelf()),"peerPrio21");
+    TEST_ASSERT(rc == 0);
+    rc = strcmp(taskName(0),"peerPrio21");
+    TEST_ASSERT(rc == 0);
+    TEST_MARK();
+    taskDelay(2);
+    TEST_MARK();
+}
+
 void rootTask (long a0, long a1, long a2, long a3, long a4,
 	       long a5, long a6, long a7, long a8, long a9)
 {
@@ -64,6 +124,8 @@
     WIND_TCB *pTcb;
     int prio = 0;
     TASK_ID id;
+    int rc = 0;
+    int tid18 = 0, tid20 = 0, tid21 = 0;
 
     TEST_START(0);
 
@@ -113,15 +175,101 @@
 
     TEST_MARK();
 
-    TEST_CHECK_SEQUENCE(SEQ("root",2),
-			SEQ("peerTask",2),
-			SEQ("root",1),
-			END_SEQ);
-
     TEST_ASSERT_OK(taskDelete((TASK_ID)&peerTcb));
 
     TEST_ASSERT(taskIdVerify((TASK_ID)&peerTcb)==ERROR);
 
+    TEST_ASSERT_OK(taskPrioritySet(taskIdSelf(),20));
+
+    TEST_ASSERT_OK(taskInit(&peerTcbPrio18,
+                "peerPrio18",
+                18,
+                0,
+                pstackBase,
+                stackSize,
+                peerTaskPrio18,
+                0,0,0,0,0,0,0,0,0,0));
+    TEST_MARK();
+    TEST_ASSERT_OK(taskActivate((TASK_ID)&peerTcbPrio18));
+
+    TEST_MARK();
+
+    rc = taskDelete((TASK_ID)&peerTcbPrio18);
+    TEST_ASSERT(rc == ERROR);
+    TEST_MARK();
+
+    TEST_ASSERT_OK(taskInit(&peerTcbPrio21,
+                "peerPrio21",
+                21,
+                0,
+                pstackBase,
+                stackSize,
+                peerTaskPrio21,
+                0,0,0,0,0,0,0,0,0,0));
+    TEST_MARK();
+    TEST_ASSERT_OK(taskActivate((TASK_ID)&peerTcbPrio21));
+
+    TEST_MARK();
+
+    taskDelay(1);
+    TEST_MARK();
+
+    TEST_ASSERT_OK(taskDelete((TASK_ID)&peerTcbPrio21));
+    TEST_MARK();
+
+    tid18 = taskSpawn("peerPrio18",                                     
+                18,                                               
+                0,  
+                32768,
+                peerTaskPrio18,
+                0,0,0,0,0,0,0,0,0,0);
+    TEST_ASSERT(tid18 != 0);
+    TEST_MARK();
+
+    tid20 = taskSpawn("peerPrio20",                                     
+                20,                                               
+                0,                                                
+                32768,
+                peerTaskPrio20,
+                0,0,0,0,0,0,0,0,0,0);
+    TEST_ASSERT(tid20 != 0);
+
+    TEST_MARK();
+
+    tid21 = taskSpawn("peerPrio21",                                     
+                21,                                               
+                0,                                                
+                32768,
+                peerTaskPrio21,
+                0,0,0,0,0,0,0,0,0,0);
+    TEST_ASSERT(tid21 != 0);
+
+    TEST_MARK();
+    taskDelay(1);
+    TEST_MARK();
+    TEST_ASSERT_OK(taskDelete(tid21));
+    errno = 0;
+    TEST_ASSERT(taskDelete(tid18) == ERROR && errno == S_objLib_OBJ_ID_ERROR);
+    errno = 0;
+    TEST_ASSERT(taskDelete(tid20) == ERROR && errno == S_objLib_OBJ_ID_ERROR);
+    TEST_MARK();
+
+    TEST_CHECK_SEQUENCE(SEQ("root",2),
+            SEQ("peerTask",2),
+            SEQ("root",1),
+            SEQ("peerTask",1),
+            SEQ("root",1),
+            SEQ("peerPrio18",3),
+            SEQ("root",4),
+            SEQ("peerPrio21",3),
+            SEQ("root",2),
+            SEQ("peerPrio18",3),
+            SEQ("root",3),
+            SEQ("peerPrio20",3),
+            SEQ("peerPrio21",3),
+            SEQ("root",2),
+            END_SEQ);
+
     TEST_FINISH();
 }
 

--Boundary-00=_MuCmE5GuaSgmWiy--

