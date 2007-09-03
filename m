Message-ID: <46DC2484.6040004@domain.hid>
Date: Mon, 03 Sep 2007 18:13:08 +0300
From: Ravid Baruch Naali <ravidbn@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070307050402050707090907"
Subject: [Xenomai-core] [PATCH] VxWorks semaphore usage demo
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

This is a multi-part message in MIME format.
--------------070307050402050707090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello again,


I'm not sure what is the preferred way to commit my changes, so before I 
commit i'm Attaching my patch in order to get you remarks and further 
instructions


Thanks

-- 
Ravid Baruch Naali
ravidbn@domain.hid
+972 4 6732729
+972 52 5830021


--------------070307050402050707090907
Content-Type: text/x-patch;
 name="vxworks_demo.2960.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vxworks_demo.2960.patch"

Index: ksrc/skins/vxworks/demos/sem.c
===================================================================
--- ksrc/skins/vxworks/demos/sem.c	(revision 0)
+++ ksrc/skins/vxworks/demos/sem.c	(revision 0)
@@ -0,0 +1,104 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <vxworks/vxworks.h>
+#include <sys/mman.h>
+
+
+#define TASK_NUM 10
+#define STACK_SIZE 1024
+#define xnarch_printf printf
+
+SEM_ID semID, syncSEM;
+
+void taskMain(long arg1, long arg2, long arg3, long arg4, long arg5, long arg6, long arg7, long arg8, long arg9, long arg10)
+{
+    int localerrno;
+    //Waiting to start synchronized with all other spawned tasks
+    semTake(syncSEM, WAIT_FOREVER);
+    //Taking the counting semaphore to indicate task started running, 
+    //stall main from exiting 
+    STATUS result = semTake(semID, WAIT_FOREVER);
+    //Chaking for failures
+    if(result == ERROR){
+	localerrno = errnoGet();
+	//checking failure reason
+	switch(localerrno){
+	    case S_objLib_OBJ_ID_ERROR:
+		xnprintf( "Semaphore ID is invalid\n");
+		break;
+	    case S_objLib_OBJ_UNAVAILABLE:
+		xnprintf( "Semaphore unavailable (NO_WAIT)\n");
+		break;
+	    case S_objLib_OBJ_TIMEOUT:
+		xnprintf( "Timeout occured before semaphore was released\n");
+		break;
+	    case S_semLib_INVALID_OPTION:
+		xnprintf( "Semaphore type is invalid\n");
+		break;
+	    case EINTR:
+		xnprintf( "Received interup\n");
+		break;
+	    default:
+		break;
+	}
+	return;
+    }
+    
+    int i = 10;
+    //Getting this task's ID
+    int ownID = taskIdSelf();
+    //Getting this task's pririty
+    int priority;
+    result = taskPriorityGet(ownID, &priority);
+    
+    xnprintf( "My priority is %d\n", priority);
+    while(i){
+	    printf("My name is %s my tid=%d\n", taskName(ownID), ownID);
+	    sleep(1);
+	    i--;
+    }
+    //Signaling main that this task as finished
+    semGive(semID);
+    //Not realy required but releasing semaphore
+    semGive(syncSEM);
+}
+
+
+int main(int argc, char **argv)
+{
+	
+    mlockall(MCL_CURRENT|MCL_FUTURE);
+    int tidStat;
+    int tids[TASK_NUM];
+    //Creating counting semaphore on which main waits until all tasks are done
+    semID = semCCreate(SEM_Q_PRIORITY, TASK_NUM);
+    if(!semID){
+	xnprintf( "Failed to create semaphore\n");
+	exit(1);
+    }
+    //Creating a binary semaphore to sync all tasks 
+    syncSEM = semBCreate(SEM_Q_PRIORITY, SEM_EMPTY);
+    if(!syncSEM){
+	xnprintf( "Failed to create binary semaphore\n");
+	exit(1);
+    }
+    //creating all the tasks 
+    int i;
+    for(i = 0; i < TASK_NUM; i++){
+	tids[i] = taskSpawn(NULL, 25-i, 0, STACK_SIZE , taskMain,0,0,0,0,0,0,0,0,0,0);
+	xnprintf( "Spawned task: %d\n", tids[i]);
+    }
+    //Giving all tasks a signal to start
+    semFlush(syncSEM);
+    //Waiting for all task to complete their main routine
+    semTake(semID, WAIT_FOREVER);
+    for(i = 0; i < TASK_NUM; i++)
+	taskDelete(tids[i]);
+    semDelete(semID);
+    semDelete(syncSEM);
+}
Index: ksrc/skins/vxworks/demos/Makefile
===================================================================
--- ksrc/skins/vxworks/demos/Makefile	(revision 2960)
+++ ksrc/skins/vxworks/demos/Makefile	(working copy)
@@ -7,7 +7,7 @@
 
 STD_CFLAGS  := $(shell $(XENO_CONFIG) --xeno-cflags)
 STD_LDFLAGS := $(shell $(XENO_CONFIG) --xeno-ldflags) -lvxworks
-STD_TARGETS := satch
+STD_TARGETS := satch sem
 
 GCIC := $(prefix)/bin/gcic
 SIM_CFLAGS  := -g
@@ -27,6 +27,9 @@
 satch: satch.c
 	$(CC) -o $@ $< $(STD_CFLAGS) $(STD_LDFLAGS)
 
+sem: sem.c
+	$(CC) -o $@ $< $(STD_CFLAGS) $(STD_LDFLAGS)
+
 satch_sim: satch_sim.o
 	$(GCIC) -o $@ $< $(SIM_LDFLAGS)
 

--------------070307050402050707090907--

