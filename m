Message-ID: <46DC7553.8040602@domain.hid>
Date: Mon, 03 Sep 2007 23:57:55 +0300
From: Ravid Baruch Naali <ravidbn@domain.hid>
MIME-Version: 1.0
References: <46DC2484.6040004@domain.hid>
	<2ff1a98a0709030832m77661616qfb36eff16b0115b@domain.hid>
In-Reply-To: <2ff1a98a0709030832m77661616qfb36eff16b0115b@domain.hid>
Content-Type: multipart/mixed; boundary="------------000503060109060008050502"
Subject: Re: [Xenomai-core] [PATCH] VxWorks semaphore usage demo
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000503060109060008050502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Re sending the patch following Gilles comments


Gilles Chanteperdrix wrote:

> On 9/3/07, Ravid Baruch Naali <ravidbn@domain.hid> wrote:
>   
>> Hello again,
>>     
>
> Hi,
>
>   
>> I'm not sure what is the preferred way to commit my changes, so before I
>> commit i'm Attaching my patch in order to get you remarks and further
>> instructions
>>     
>
> The synchronization on tasks completion with the semID semaphore seems
> broken. The main thread will get the semahore when the first task
> completes, not when all the tasks complete.
>
> I see too many comments, for instance:
> // Checking for failures
> if (error == ERROR)
>
> is useless, it is pretty obvious from reading the code that you are
> checking for failure. Comments should tell us things that are not
> obvious.
>
> Now, about the style, this is C code, so use C style comments. I would
> also prefer that you use the kernel coding style, but this is not
> kernel code, so I am not sure the rule is to use the kernel coding
> style.
>   


-- 
Ravid Baruch Naali
ravidbn@domain.hid
+972 4 6732729
+972 52 5830021


--------------000503060109060008050502
Content-Type: text/x-patch;
 name="vxworks_demo.2960.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vxworks_demo.2960.patch"

Index: ksrc/skins/vxworks/demos/sem.c
===================================================================
--- ksrc/skins/vxworks/demos/sem.c	(revision 0)
+++ ksrc/skins/vxworks/demos/sem.c	(revision 0)
@@ -0,0 +1,138 @@
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
+#define LOOPS 10
+#define xnarch_printf printf
+#define TOP_PRIORITY 25
+
+SEM_ID task_counter_sem;
+SEM_ID task_sync_sem;
+
+static errno_to_messgae(char *failing_func);
+
+/*
+ * A shared main routine for all tasks other then the main
+ * each task waits for the signal from the main task
+ * then it notify it's existing 
+ *
+ * It then loops and prints out LOOPS times it's name and tid
+ * when done it notifies
+ * 
+ * None of the parameters are being used
+ */
+void task_main_routine(long arg1, long arg2, long arg3, long arg4, long arg5, long arg6,
+	long arg7, long arg8, long arg9, long arg10)
+{
+	int localerrno;
+	STATUS result;
+	int priority;
+	int i = LOOPS;
+	int ownID = taskIdSelf();
+
+	/*Waiting to start synchronized with all other spawned tasks*/
+	result = semTake(task_sync_sem, WAIT_FOREVER);
+	if (result == ERROR) {
+		errno_to_messgae("semTake counter");	
+		return;
+	}
+	/*Taking the counting semaphore to indicate task started running stall
+	 * main from exiting */
+	result = semTake(task_counter_sem, WAIT_FOREVER);
+	if (result == ERROR) {
+		errno_to_messgae("semTake counter");	
+		return;
+	}
+	result = taskPriorityGet(ownID, &priority);
+	
+	xnprintf( "Task priority is %d\n", priority);
+	while (i) {
+		xnprintf("Task name is %s tid=%d\n", taskName(ownID), ownID);
+		sleep(1);
+		i--;
+	}
+	/*Signaling this task is done*/
+	semGive(task_counter_sem);
+}
+
+/*
+ * Main task:
+ * spawns TASK_NUM tasks synchronize their operation 
+ * exit and clean up when all tasks are done
+ */
+int main(int argc, char **argv)
+{
+	/*array holding all tasks ids*/
+	int tids[TASK_NUM];
+	int i;
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+	/* counting semaphore inital value set to the number of tasks*/
+	task_counter_sem = semCCreate(SEM_Q_PRIORITY, TASK_NUM);
+	if (!task_counter_sem) {
+		xnprintf( "Failed to create semaphore\n");
+		exit(1);
+	}
+	/* semaphore to synchronize all task operation */
+	task_sync_sem = semBCreate(SEM_Q_PRIORITY, SEM_EMPTY);
+	if (!task_sync_sem) {
+		xnprintf( "Failed to create binary semaphore\n");
+		exit(1);
+	}
+	for (i = 0; i < TASK_NUM; i++) {
+		tids[i] = taskSpawn(NULL, (TOP_PRIORITY - i), 0, STACK_SIZE , 
+				task_main_routine,0,0,0,0,0,0,0,0,0,0);
+		xnprintf( "Spawned task: %d\n", tids[i]);
+	}
+	/* Signaling all tasks to run */
+	semFlush(task_sync_sem);
+	/* Waiting for all task to complete their main routine */
+	for (i = 0; i < TASK_NUM; i++)
+		semTake(task_counter_sem, WAIT_FOREVER);
+	/* Cleanup */
+	for (i = 0; i < TASK_NUM; i++)
+		taskDelete(tids[i]);
+	semDelete(task_counter_sem);
+	semDelete(task_sync_sem);
+}
+
+
+/*
+ * Prints out the meaning of an error with relation to the failing function
+ *
+ * parameter:
+ * a prefix string to the failure reason 
+ */
+static errno_to_messgae(char *failing_func)
+{
+	int localerrno = errnoGet();
+	xnprintf("%s: ", failing_func);
+	switch(localerrno){
+	case S_objLib_OBJ_ID_ERROR:
+		xnprintf( "Semaphore ID is invalid\n");
+		break;
+	case S_objLib_OBJ_UNAVAILABLE:
+		xnprintf( "Semaphore unavailable (NO_WAIT)\n");
+		break;
+	case S_objLib_OBJ_TIMEOUT:
+		xnprintf( "Timeout occured before semaphore was"
+				" released\n");
+		break;
+	case S_semLib_INVALID_OPTION:
+		xnprintf( "Semaphore type is invalid\n");
+		break;
+	case EINTR:
+		xnprintf( "Received interup\n");
+		break;
+	default:
+		break;
+	}
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
 

--------------000503060109060008050502--

