Date: Mon, 25 Jun 2007 17:51:07 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070625175107.438849fa@domain.hid>
In-Reply-To: <46693B6B.1010201@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_apUbdagxpNGU1zLgLGEZWmh
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--MP_apUbdagxpNGU1zLgLGEZWmh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 08 Jun 2007 13:20:11 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

Hello,

> Well, the best (==most comfortable :o) ) way from my POV would be if you
> could try rebasing your work on your own first. Questions, even on minor
> details, are always welcome, review on patches will be provided. Should
> be no problem to get this into Xenomai 2.4.
> 
> The rough to-do list would be:
> 
>  o add some persistent runtimer counter to xnthread::stat and maintain
>    it
>  o introduce an xnpod service (inline function) to obtain it (let that
>    thing return [0..LONGLONG_MAX] when stats are available, -1
>    otherwise)
>  o export the runtime via struct rt_task_info, maybe also the task start
>    time

Coming back on this topic:
please find attached a first draft of a patch following (more or less)  your
suggestions:
-there is an additional field "exectime" in  TASK_INFO, which can be set by
rt_task_inquire and read in the info structure (the computation is slightly
different for self and remote measurement);
-xnthread_get_exectime() and xnthread_get_lastswitch() pass the values of the
current thread's  timing out of xn;
-exectime and lastswitch times are stored in an extended xnstat_runtime_t,
updated by xnstat_runtime_update() (but not exactly like the "total" item)

it has been tested (only on  P3 single core cpu) with the testexec program also
attached : there are 2 periodic tasks, clockit and loop, which measure
either their exectime, or the one of the other task: the measures 
seems reasonable, except when the clockit task measures itself, in that case the
first and second printed values are always absurd for a reason I cannot
understand...)

Only works in primary mode... (also I hope that the tsc is monotonic?)

I have no idea of what may happen on a smp or when on the fly migrating tasks!

	Daniel

-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



--MP_apUbdagxpNGU1zLgLGEZWmh
Content-Type: text/x-patch; name=exec-info-2.3.1.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=exec-info-2.3.1.patch

diff -urN xenomai-2.3.1-orig/include/native/task.h xenomai-2.3.1/include/native/task.h
--- xenomai-2.3.1-orig/include/native/task.h	2006-12-26 19:38:57.000000000 +0100
+++ xenomai-2.3.1/include/native/task.h	2007-06-22 16:08:10.000000000 +0200
@@ -91,6 +91,8 @@
     
     char name[XNOBJECT_NAME_LEN];  /**< Symbolic name assigned at creation. */
 
+    xnticks_t exectime; /**<execution time in tsc ticks since the task started. */
+
 } RT_TASK_INFO;
 
 #define RT_MCB_FSTORE_LIMIT  64
diff -urN xenomai-2.3.1-orig/include/nucleus/stat.h xenomai-2.3.1/include/nucleus/stat.h
--- xenomai-2.3.1-orig/include/nucleus/stat.h	2006-12-26 19:38:59.000000000 +0100
+++ xenomai-2.3.1/include/nucleus/stat.h	2007-06-25 15:48:25.000000000 +0200
@@ -31,6 +31,10 @@
 
 	xnticks_t total; /* Accumulated execution time */
 
+	xnticks_t exectime; /* Overall execution time from taskspawn upto lastswitch*/
+
+	xnticks_t lastswitch; /* Last time the task was made active */
+
 } xnstat_runtime_t;
 
 /* Return current date which can be passed to other xnstat services for
@@ -42,6 +46,10 @@
 do { \
 	(sched)->current_account->total += \
 		start - (sched)->last_account_switch; \
+	(sched)->current_account->exectime += \
+                xnstat_runtime_now() - (sched)->last_account_switch; \
+	(sched)->current_account->lastswitch = \
+                xnstat_runtime_now(); \
 	(sched)->last_account_switch = start; \
 } while (0)
 
diff -urN xenomai-2.3.1-orig/include/nucleus/thread.h xenomai-2.3.1/include/nucleus/thread.h
--- xenomai-2.3.1-orig/include/nucleus/thread.h	2007-03-15 15:10:30.000000000 +0100
+++ xenomai-2.3.1/include/nucleus/thread.h	2007-06-22 16:17:24.000000000 +0200
@@ -228,6 +228,7 @@
 
     void *cookie;		/* Cookie to pass to the entry routine */
 
+
     XNARCH_DECL_DISPLAY_CONTEXT();
 
 } xnthread_t;
@@ -277,7 +278,8 @@
 #define xnthread_user_pid(thread) \
     (xnthread_test_state((thread),XNROOT) || !xnthread_user_task(thread) ? \
     0 : xnarch_user_pid(xnthread_archtcb(thread)))
-
+#define xnthread_get_exectime(thread)      ((thread)->stat.account.exectime)
+#define xnthread_get_lastswitch(thread)    ((thread)->stat.account.lastswitch)
 #ifdef __cplusplus
 extern "C" {
 #endif
diff -urN xenomai-2.3.1-orig/ksrc/nucleus/thread.c xenomai-2.3.1/ksrc/nucleus/thread.c
--- xenomai-2.3.1-orig/ksrc/nucleus/thread.c	2007-02-02 02:17:32.000000000 +0100
+++ xenomai-2.3.1/ksrc/nucleus/thread.c	2007-06-22 16:55:08.000000000 +0200
@@ -89,7 +89,10 @@
 	thread->registry.waitkey = NULL;
 #endif /* CONFIG_XENO_OPT_REGISTRY */
 	memset(&thread->stat, 0, sizeof(thread->stat));
-
+#ifdef CONFIG_XENO_OPT_STATS
+	thread->stat.account.exectime = 0;
+	thread->stat.account.lastswitch = 0;
+#endif
 	/* These will be filled by xnpod_start_thread() */
 	thread->imask = 0;
 	thread->imode = 0;
diff -urN xenomai-2.3.1-orig/ksrc/skins/native/task.c xenomai-2.3.1/ksrc/skins/native/task.c
--- xenomai-2.3.1-orig/ksrc/skins/native/task.c	2007-02-28 18:25:52.000000000 +0100
+++ xenomai-2.3.1/ksrc/skins/native/task.c	2007-06-25 16:20:58.000000000 +0200
@@ -1102,15 +1102,22 @@
 
 int rt_task_inquire(RT_TASK *task, RT_TASK_INFO *info)
 {
-	int err = 0;
-	spl_t s;
-
-	if (!task) {
+  int err = 0;
+  spl_t s;
+	/* xnprintf("1- task value ptr = %p \n", (task)); */
+	if (!task) {		
+	 /*  xnprintf("if(!task) est vrai\n"); */
 		if (!xnpod_primary_p())
 			return -EPERM;
-
 		task = xeno_current_task();
 	}
+/* 	else  */
+/* 	  { */
+/* 	     xnprintf("if(!task) est fx\n"); */
+/* 	  } */
+
+/* 	xnprintf("2- task value ptr = %p\n",(task)); */
+	
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -1126,7 +1133,12 @@
 	info->cprio = xnthread_current_priority(&task->thread_base);
 	info->status = xnthread_state_flags(&task->thread_base);
 	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
-
+	if(task == xeno_current_task()){
+	  info->exectime = xnthread_get_exectime(&task->thread_base) + (xnstat_runtime_now() - xnthread_get_lastswitch(&task->thread_base));
+	  xnprintf("self inquire runtime_now %llu lastswitch %llu exectime %llu\n", (xnstat_runtime_now()), xnthread_get_lastswitch(&task->thread_base), (info->exectime));}
+	else {
+	  info->exectime = xnthread_get_exectime(&task->thread_base);
+	  xnprintf("not self %lld \n", (long long)info->exectime);}
       unlock_and_exit:
 
 	xnlock_put_irqrestore(&nklock, s);

--MP_apUbdagxpNGU1zLgLGEZWmh
Content-Type: text/x-csrc; name=testexec.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=testexec.c

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <native/types.h>
#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/timer.h>
#include <native/sem.h>
#include <native/alarm.h>
#include <native/heap.h>
#include <native/queue.h>
#include <native/syscall.h>
#define STACK_SIZE 8192
#define MIN_PRIO 1
#define MAX_PRIO 99
#define PRI_MT_MAX MAX_PRIO - 6
#define PRI_MT_MIN MIN_PRIO

typedef void * (*FUNCPTR) (void *);
typedef void (*SOSO) (void *); /**< Special type to be used for casting in task_create() */
#define ORCMSGQ RT_QUEUE *  /**< Message Queue Type */
#define ORCSEM_ID RT_SEM *  /**< Semaphore Type */
#define ORCFULL  1        /**< State of a Full Binary Semaphore */
#define ORCEMPTY 0        /**< State of a Empty Binary Semaphore */
#define ORCFOREVER TM_INFINITE     /**< State of a ??? Binary Semaphore */
#define SIZE_QUEUE  100       /**< Size of the Message Queue */
#define SIZE_MES_MAX 4056    /**< Maximum size of a message in Message Queue */
#define SIZE_MES_MIN 128     /**< Minimum size of a message in Message Queue */ 
/*-------Tasks----------*/
#define ORCTHR_ID RT_TASK * /**< Xeno RT-Task Type */
#define STACKSIZE int      /**< Stack size Type */
#define SCHED_OTHER             0
#define SCHED_FIFO              1
#define SCHED_RR                2
#define SCHEDPOLICY SCHED_FIFO  /**< Scheduling policy (see schedbits.h, sched.h )*/
#define SMALL_STACK  1000           /**< Small task stack size PTHREAD_STACK_MIN not defined */
#define NORMAL_STACK (5*SMALL_STACK)  /**< Normal task stack size */
#define BIG_STACK    (15*SMALL_STACK) /**< Big task stack size */ 
//                     --s-ms-us-ns
RTIME task_period_ns = 500000000llu;
#define NSEC_PER_SEC 1000000000

#define OK 0
#define ERROR -1
#define STATUS int

#define FALSE 0
#define TRUE 1
#define POLICY 1

static int ji = 0;
//static int togparport = 0;
static RTIME startime, now; // inittime, nexttime;
struct timespec clock_resolution;
static int message_counter = 0;

RT_ALARM BaseClk;
int status, err, end = 0, loops = 10;

char *dummy;

ORCTHR_ID thr_clockit;
ORCTHR_ID thr_loop;
ORCMSGQ Queue;

ORCSEM_ID SynchroSem;

static int cpt_sem = 10000;
char nameSem[10];
int crexec, cr;
long past = 0;
ORCTHR_ID MAIN_RT;
/*-------Message Queues----------*/
/**
 * Function to create a message queue
 *
 * @param
 * @return ORCMSGQ pointer if message queue created, NULL otherwise and errno is set
 * @see ORCMSGQ
 * @see <sys/msg.h>#msgget
 * @see <sys/msg.h>#msgctl
 */
ORCMSGQ orcMsgQCreate()
{
    size_t size;
    ORCMSGQ OrcQueue;
    message_counter = 0;
    size = SIZE_MES_MAX;
    int err;

    OrcQueue = malloc(sizeof(RT_QUEUE));
    if (OrcQueue == 0)
    {
        printf("ERROR  orcMsgQCreate malloc\n");
        return 0;
    }
    memset(OrcQueue, 0, sizeof(RT_QUEUE));
    if ((err = rt_queue_create(OrcQueue, "OrcRTQ", SIZE_MES_MAX*SIZE_QUEUE, SIZE_QUEUE, Q_FIFO | Q_SHARED)) != 0)
    {
      printf("orcMsgQCreate ERROR %d \n", err);
    }
    else printf("orcMsgQCreate OK\n");
    return OrcQueue;
}

/**
 * Function to get the number of messages pending in a message queue
 *
 * @param queue pointer to the message queue 
 * @return long number of messages if no error occurs otherwise ERROR and errno is set
 * @see <sys/msg.h>#msgctl
 */
long orcMsgQNumMsgs(ORCMSGQ queue)
{
    return (long)message_counter;
}

/**
 * Function to send a message on a message queue
 * Sending the message is done according to a priority level such as :
 *
 * @param queue pointer to the message queue
 * @param msg message to be sent
 * @param prio message priority level
 * @return OK if successfull, ERROR otherwise and errno is set
 * @see <sys/msg.h>#msgsnd
 */
int orcMsgQSend(ORCMSGQ OrcQueue, int msg, int prio)
{
    int i;
    void * tmpbuf;
    size_t orcEventSize;
    orcEventSize = (size_t)sizeof(int);
    if ((tmpbuf = rt_queue_alloc(OrcQueue, orcEventSize)) == 0)
    {
        printf("ERROR orcMsgQSend tmpbuf not created \n");
        return ERROR;
    }
    memcpy(tmpbuf, &msg, orcEventSize);
    if ((i = rt_queue_send(OrcQueue, tmpbuf, orcEventSize, Q_NORMAL)) < 0)
    {
        printf("ERROR orcMsgQSend %d \n", i);
        return ERROR;
    }
    message_counter++;
    return OK;
}

/**
 * Function to receive messages on a message queue
 *
 * @param queue pointer to the message queue
 * @param msg pointer to the received message 
 * @return OK if successfull, ERROR otherwise and errno is set
 * @see <sys/msg.h>#msgrcv
 *
 */
int orcMsgQReceive(ORCMSGQ OrcQueue, int *msg)
{
    ssize_t i;
    void *message;

    if ((i = rt_queue_receive(OrcQueue, &message, TM_INFINITE )) < 0)
    {
        printf("ERREUR orcMsgQReceive %d \n", i);
        return ERROR;
    }
    else
    {
      memcpy(msg, message, i);
        rt_queue_free(OrcQueue, message);
        message_counter--;
        return OK;
    }
}

/**
 * Function to close and erase a message queue
 *
 * @param queue pointer to the message queue 
 * @return OK if successfull, ERROR otherwise and errno is set
 * @see <sys/msg.h>#msgctl
 */
int orcMsgQClose(ORCMSGQ OrcQueue)
{
    int i;
    if (OrcQueue == 0)
        return ERROR;
    if ((i = rt_queue_delete(OrcQueue)) != 0)
    {
        printf("ERREUR orcMsgQClose %d \n", i);
        return ERROR;
    }

    else
    {
        free(OrcQueue);
        return OK;
    }
}

/*-------Semaphores----------*/
/**
 * Function to create a semaphore
 *
 * @param initState semaphore initial creation state, eg ORCFULL, ORCEMPTY
 * @return ORCSEM_ID semaphore pointer created if successfull, NULL otherwise 
 * @see ORCFULL
 * @see ORCEMPTY
 * @see <semaphore.h>#sem_init
 */

ORCSEM_ID orcSemCreate(int initState)
{
    ORCSEM_ID newSem;
    int status;

    sprintf(nameSem,"%d",cpt_sem);
    newSem = malloc(sizeof(RT_SEM));
    if (newSem == 0)
    {
        printf("ERROR orcSem init \n");
        return 0;
    }
    memset(newSem, 0, sizeof(RT_SEM));
    if(initState == ORCFULL)
{
        status = rt_sem_create(newSem, nameSem, initState, S_FIFO);
#ifdef DEBUG
        printf("WARNING binary Sem created FULL \n");
#endif 
}
    else
        status = rt_sem_create(newSem, nameSem, initState, S_FIFO|S_PULSE);
    if (status == OK)
    {
#ifdef DEBUG
        printf("orcSemCreate %p\n", newSem);
#endif
        cpt_sem++;
        return newSem;
    }
    else
    {
#ifdef DEBUG
        printf("orcSemCreate ERROR %d\n", status);
#endif
        return NULL;
    }
}

ORCSEM_ID orcSemCreate_count(int initState)
{
    RT_SEM * newSem;
    int status;

    sprintf(nameSem,"%d",cpt_sem);
    newSem = malloc(sizeof(RT_SEM));
    if (newSem == 0)
    {
        printf("ERROR SemCreate_count init \n");
        return 0;
    }
    memset(newSem, 0, sizeof(RT_SEM));

    status = rt_sem_create(newSem, nameSem, initState, S_FIFO);
    if (status == OK)
    {
#ifdef DEBUG
        printf("orcSemCreate_count %p\n", newSem);
#endif
        cpt_sem++;
        return newSem;
    }
    else
    {
#ifdef DEBUG
        printf("orcSemCreate ERROR %d \n", status);
#endif
        return NULL;
    }

}

/**
 * Function to delete a given semaphore
 * 
 * @param sem semaphore to be deleted
 * @return sem_destroy() returned value
 * @see <semaphore.h>#sem_destroy
 */
int orcSemDelete(ORCSEM_ID sem)
{
    if (sem == 0)
        return ERROR;
    if (rt_sem_delete(sem) == 0)
    {
        free(sem);
        return OK;
    }
    printf("Erreur:orcSemDelete\n");
    return ERROR;
}

/**
 * Function to give a semaphore
 *
 * @param sem semaphore id
 * @return sem_post) returned value
 * @see <semaphore.h>#sem_post
 */
int orcSemGive(ORCSEM_ID sem)
{
#ifdef DEBUG
    printf("SemGive %p\n", sem);
#endif
    return (rt_sem_v(sem));
}

/**
 * Function to take a semaphore
 * TODO : no timeout in Posix semaphores
 *
 * @param sem semaphore
 * @param timeout value 
 * @return sem_wait() returned value
 * @see <semaphore.h>#sem_wait
 */
int orcSemTake(ORCSEM_ID sem, int timeout)
{
#ifdef DEBUG
    printf("SemTake %p\n", sem);
#endif
    return (rt_sem_p(sem, timeout));
}

/*-------Tasks----------*/
/**
 * Function for suspending current process
 * TODO : no taskDelay in Posix (sleep uses seconds, delay ?, nanosleep ?)
 *
 * @param delay
 * @return OK
 */
int orcTaskDelay(int delay)
{
    //int dummy = delay; // set to avoid compilation warnings

    return OK;
}

/// Function to set relative linux task priority
int orcScalePriority(int os_priority)
{
    if ((PRI_MT_MIN + os_priority < PRI_MT_MAX) && os_priority > 0)
        return ( PRI_MT_MIN + os_priority );
    printf("ERROR orcScalePriority, priority=%d\n", os_priority);
    return PRI_MT_MAX;
}


/**
 * Function to check if a task is still valid or not
 *
 * @param Id task identifier 
 * @return OK if task is valid, ERROR otherwise
 * @see ORCTHR_ID
 * @see pthread_kill
 */
int orcTaskIdVerify(ORCTHR_ID Id)
{
    if (Id != NULL)
    {
        return OK;
    }
    printf("orcTaskIdVerify ERROR \n");
    return ERROR;
}

/**
 * Function to kill a task (pthread)
 *
 * @param Id task identifier
 * @return ERROR or pthread_cancel returned value
 * @see ORCTHR_ID
 * @see <pthread.h>#pthread_kill
 * @see <pthread.h>#pthread_cancel
 */
int orcTaskDelete(ORCTHR_ID task)
{
    int result;

    if (task == 0)
    {
        printf("ERROR rt_task_delete, task == 0\n");
        return ERROR;
    }
    result = rt_task_delete(task);
    if (result != 0)
    {
        printf("ERROR rt_task_delete  %p error %d\n", task, result);
        return ERROR;
    }
    //    if (result == 0)
    free(task);
    return OK;
}

/**
 * Function to spawn a task
 *
 * @param tid task identifier
 * @param name name descripting the task
 * @param prio task priority level
 * @param stackSize stack size to be allocated for the task
 * @param funcptr routine to be spawn by the task
 * @param arg argument needed for the routine to be spawn
 * @return pthread_create returned value
 * @see ORCTHR_ID
 * @see STACKSIZE
 * @see FUNCPTR
 * @see <pthread.h>#pthread_create
 */
int orcSpawn(ORCTHR_ID *tid, const char *name, int prio, STACKSIZE stackSize, SOSO funcptr, void * arg)
{
    int err;

    //Allocate memory
    if (((*tid) = (RT_TASK*) malloc (sizeof(RT_TASK))) == NULL)
    {
        printf("Error malloc orcspawn\n" );
        return ERROR;
    }
    if ((err = rt_task_spawn(*tid, name, stackSize, prio, T_FPU|T_JOINABLE|T_CPU(0), (SOSO) funcptr, arg)) != 0)
      //if ((err = rt_task_spawn(*tid, name, stackSize, prio, T_FPU, (SOSO) funcptr, arg)) != 0)

    {
        printf("ERROR %d rt_task_init\n", err);
        return ERROR;
    }
    //#ifdef DEBUG
    printf("rt_task create %s prio %d StackSize %d Id %p \n", name, prio, stackSize, tid);
    //#endif
    return OK;
}
int orcSpawn1(ORCTHR_ID *tid, const char *name, int prio, STACKSIZE stackSize, SOSO funcptr, void * arg)
{
    int err;

    //Allocate memory
    if (((*tid) = (RT_TASK*) malloc (sizeof(RT_TASK))) == NULL)
    {
        printf("Error malloc orcspawn\n" );
        return ERROR;
    }
    if ((err = rt_task_spawn(*tid, name, stackSize, prio, T_FPU|T_JOINABLE|T_CPU(1), (SOSO) funcptr, arg)) != 0)
      //if ((err = rt_task_spawn(*tid, name, stackSize, prio, T_FPU, (SOSO) funcptr, arg)) != 0)

    {
        printf("ERROR %d rt_task_init\n", err);
        return ERROR;
    }
    //#ifdef DEBUG
    printf("rt_task create %s prio %d StackSize %d Id %p \n", name, prio, stackSize, tid);
    //#endif
    return OK;
}

/**
 * Function to lock a task
 * This function does nothing : defined for interoperability between OS needs
 * 
 * @param 
 * @return OK
 */
int orcTaskLock()
{
    return OK;
}

/**
 * Function to unlock a task
 * This function does nothing : defined for interoperability between OS needs
 * 
 * @param 
 * @return OK
 */
int orcTaskUnlock()
{
    return OK;
}

int orcTaskSuspend(ORCTHR_ID task)
{
    return rt_task_suspend(task);
}

///Function that returns the cpu time in nanoseconds
inline long long GetCpuTime(void)
{
    return (long long)rt_timer_ticks2ns(rt_timer_read());
}

inline  unsigned long long orcGetExecTime(ORCTHR_ID task)
{
RT_TASK_INFO info;
crexec = rt_task_inquire(task,&info);
  if (crexec != 0){
    printf("rt_task_get_exectime error %d \n", crexec);
    return (unsigned long long)0;}
  else return (unsigned long long)rt_timer_tsc2ns((SRTIME)info.exectime);
}

inline long long orcGetStartTime(ORCTHR_ID task)
{
    return (long long)0;
}

int orcMakeRealTime(void)
{
int prio_main = PRI_MT_MAX + 1;
    mlockall(MCL_CURRENT | MCL_FUTURE);
    if ((cr = rt_task_shadow(MAIN_RT, "MAIN_PRR", prio_main, T_FPU | T_JOINABLE)) != 0)
      {printf("rt_task_shadow error %d \n", cr);}
    else {printf("rt_task_shadow done priority %d \n", prio_main);}
    return cr;
}

int orcTaskJoin(ORCTHR_ID task)
{
cr = rt_task_join(task);
 if (cr != 0){
   printf("rt_task_join error %d on task %p \n", cr, task);
   return cr;}
 else return OK;
}

// Trap Ctrl C Interruption
void clean_exit(int dummy)
{
    printf("Ctrl C Interrupt\n");
    end = 1;
    err = rt_task_join(thr_clockit);
    if (err != 0)printf("rt_task_join() error %d \n", err);
    err = rt_task_join(thr_loop);
    if (err != 0)printf("rt_task_join() error %d \n", err);

    printf("deleting rt devices \n");
    err = rt_alarm_delete(&BaseClk);
    if (err != 0)printf("rt_alarm_delete() error %d \n", err);

    orcMsgQClose(Queue);
    orcSemDelete(SynchroSem);
    return ;
}

int orcTimerSigMask(void)
{
    sigset_t set;
    sigfillset(&set);
    if ((err = pthread_sigmask(SIG_BLOCK, &set, NULL)) != OK)
    {
        printf("pthread_sigmask Failed %d \n", err);
        return ERROR;
    }
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    sigaddset(&set, SIGTERM);
    if ((err = pthread_sigmask(SIG_UNBLOCK, &set, NULL)) != OK)
    {
        printf("pthread_sigmask Failed %d \n", err);
        return ERROR;
    }

    return OK;
}

void setTimer(void)
{
    /***starting timer ***/
    err = rt_alarm_create(&BaseClk, "BaseClock");
    if (err != 0)printf("rt_alarm_create() error %d \n", err);
    err = rt_alarm_start(&BaseClk,
                         rt_timer_ns2ticks(task_period_ns),
                         rt_timer_ns2ticks(task_period_ns));
    if (err != 0)printf("rt_alarm_start() error %d \n", err);

    else printf("alarm started with period %llu ns \n", task_period_ns);
    printf("period in ticks %ld \n", (long)rt_timer_ns2ticks(task_period_ns));
    return ;

}

void clock_it(void)
{
    int msg = 1;    
    unsigned long long clockexectime, clockdiff;
    static unsigned long long clockpast = 0;
    while (!end)
    {
        err = rt_alarm_wait(&BaseClk);

	//rt_timer_spin((RTIME)rt_timer_ns2ticks(100000000));	
/*       clockexectime = orcGetExecTime(NULL); */
/*       if(msg > 2){ */
/*       clockdiff = clockexectime - clockpast; */
/*       clockpast  = clockexectime; */
/*       printf("clockexectime %llu clockdiff %llu \n", clockexectime, clockdiff );} */
/*       else clockpast  = clockexectime; */

            orcMsgQSend(Queue, msg, 0);
            msg++;
    }
/*     printf("clocktotal %llu clockdiffexec moyen %llu \n", clockexectime, (clockexectime/msg)); */
    return ;
}
void func_loop()
{
    int msg;
    unsigned long long loopexectime, loopdiff;
    static unsigned long long looppast;
    while (!end)
    {
      //printf("WAITING FOR MESSAGE  \n");
      orcMsgQReceive(Queue, &msg);
      printf("RECEIVED MESSAGE  \n");
      rt_timer_spin((RTIME)rt_timer_ns2ticks(100000000));
      loopexectime = orcGetExecTime(NULL);
      if(msg > 2){
	  loopdiff = loopexectime - looppast;
	  looppast  = loopexectime;
      printf("loopexectime  %llu loopdiff %llu \n", loopexectime, loopdiff );}
      else looppast  = loopexectime;
      printf("received msg = %d \n", msg);
	    }
    printf("ENDING msg = %d \n", msg); 
/*     printf("looptotal %llu loopdiffexec moyen %llu \n", loopexectime, (loopexectime/msg)); */
    printf("convert 1000 ticks = %llu ns \n", rt_timer_tsc2ns(1000));
    return;
}
int main(void)
{

    orcTimerSigMask();

    signal(SIGTERM, clean_exit);
    signal(SIGINT, clean_exit);

    orcMakeRealTime();

    setTimer();

    SynchroSem = orcSemCreate(ORCEMPTY);
    Queue = orcMsgQCreate();
    
    orcSpawn(&thr_clockit, "AlarmServer", MAX_PRIO, NORMAL_STACK, (SOSO) clock_it, NULL);
    orcSpawn(&thr_loop, "Loop", MAX_PRIO - 1, NORMAL_STACK, (SOSO) func_loop, NULL);

    pause();
    fflush(NULL);

    return 0;
}




--MP_apUbdagxpNGU1zLgLGEZWmh--

