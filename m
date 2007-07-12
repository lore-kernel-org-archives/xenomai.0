Date: Thu, 12 Jul 2007 11:30:39 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20070712113039.14050727@domain.hid>
In-Reply-To: <469549AF.5090102@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<20070608124927.1b789a9e@domain.hid>
	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
	<467FF391.8020401@domain.hid>
	<20070627105726.7db7a459@domain.hid>
	<46825054.7030800@domain.hid>
	<20070629164326.15579570@domain.hid>
	<4690B86C.1000907@domain.hid>
	<20070711155932.4b88699e@domain.hid>
	<4694E96B.5020801@domain.hid>
	<20070711173545.709225f1@domain.hid>
	<4694FD99.3030405@domain.hid>
	<20070711185529.62544380@domain.hid>
	<469549AF.5090102@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_MUBRZk8Nca62.fTwIn/AXZR"
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

--MP_MUBRZk8Nca62.fTwIn/AXZR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 11 Jul 2007 23:20:47 +0200
Jan Kiszka <jan.kiszka@domain.hid> wrote:

> I've merge you changes (whitespaces...)
sorry for bad formatting, my dev. tool is emacs, which sometimes refuse to
understand tabs...

>http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/enhance-thread-stats-v2.patch

this patch seems ok:
-patched against release 2764 (with 2 self-corrected hunks), compiled on a
2.6.20 kernel and test on a P3/UP

 -my former basic tests (2 periodic tasks providing remote or self
exectime probing) still give consistent measures (exectime.c in attachment)

-I am thinking about more demanding tests, with intertasks preemption and
overloads, but in that case the problem is how to assess the measurements?
Logic analyzer? Be care also with rt_timer_spin, which is not busy-sleeping for
all the specified time when it is preempted...

	Daniel
-- 
       Daniel SIMON    Projet NeCS  INRIA Rhone-Alpes
        Inovallee, 655 avenue de l'Europe, Montbonnot
             38 334 Saint Ismier Cedex France
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
          http://necs.inrialpes.fr/people/simon/



--MP_MUBRZk8Nca62.fTwIn/AXZR
Content-Type: text/x-csrc; name=exectime.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=exectime.c

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <signal.h>
#include <math.h>
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
#define ORCFOREVER TM_INFINITE     /**< Waiting forever in sem_wait */
#define SIZE_QUEUE  100       /**< Size of the Message Queue */
#define SIZE_MES_MAX 4056    /**< Maximum size of a message in Message Queue */
#define SIZE_MES_MIN 128     /**< Minimum size of a message in Message Queue */
/*-------Tasks----------*/
#define ORCTHR_ID RT_TASK * /**< Xeno RT-Task Type */
#define STACKSIZE int      /**< Stack size Type */
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
static RTIME startime, now;
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

ORCMSGQ orcMsgQCreate()
{
        size_t size;
        ORCMSGQ OrcQueue;
        message_counter = 0;
        size = SIZE_MES_MAX;
        int err;

        OrcQueue = malloc(sizeof(RT_QUEUE));
        if (OrcQueue == 0) {
                printf("ERROR  orcMsgQCreate malloc\n");
                return 0;
        }
        memset(OrcQueue, 0, sizeof(RT_QUEUE));
        if ((err = rt_queue_create(OrcQueue, "OrcRTQ", SIZE_MES_MAX*SIZE_QUEUE, SIZE_QUEUE, Q_FIFO | Q_SHARED)) != 0) {
                printf("orcMsgQCreate ERROR %d \n", err);
        } else printf("orcMsgQCreate OK\n");
        return OrcQueue;
}

int orcMsgQSend(ORCMSGQ OrcQueue, int msg, int prio)
{
        int i;
        void * tmpbuf;
        size_t orcEventSize;
        orcEventSize = (size_t)sizeof(int);
        if ((tmpbuf = rt_queue_alloc(OrcQueue, orcEventSize)) == 0) {
                printf("ERROR orcMsgQSend tmpbuf not created \n");
                return ERROR;
        }
        memcpy(tmpbuf, &msg, orcEventSize);
        if ((i = rt_queue_send(OrcQueue, tmpbuf, orcEventSize, Q_NORMAL)) < 0) {
                printf("ERROR orcMsgQSend %d \n", i);
                return ERROR;
        }
        message_counter++;
        return OK;
}

int orcMsgQReceive(ORCMSGQ OrcQueue, int *msg)
{
        ssize_t i;
        void *message;

        if ((i = rt_queue_receive(OrcQueue, &message, TM_INFINITE )) < 0) {
                printf("ERREUR orcMsgQReceive %d \n", i);
                return ERROR;
        } else {
                memcpy(msg, message, i);
                rt_queue_free(OrcQueue, message);
                message_counter--;
                return OK;
        }
}

int orcMsgQClose(ORCMSGQ OrcQueue)
{
        int i;
        if (OrcQueue == 0)
                return ERROR;
        if ((i = rt_queue_delete(OrcQueue)) != 0) {
                printf("ERREUR orcMsgQClose %d \n", i);
                return ERROR;
        }

        else {
                free(OrcQueue);
                return OK;
        }
}

ORCSEM_ID orcSemCreate(int initState)
{
        RT_SEM * newSem;
        int status;

        sprintf(nameSem,"%d",cpt_sem);
        newSem = malloc(sizeof(RT_SEM));
        if (newSem == 0) {
                printf("ERROR SemCreate_count init \n");
                return 0;
        }
        memset(newSem, 0, sizeof(RT_SEM));

        status = rt_sem_create(newSem, nameSem, initState, S_FIFO);
        if (status == OK) {
                cpt_sem++;
                return newSem;
        } else {
                return NULL;
        }

}

int orcSemDelete(ORCSEM_ID sem)
{
        if (sem == 0)
                return ERROR;
        if (rt_sem_delete(sem) == 0) {
                free(sem);
                return OK;
        }
        printf("Erreur:orcSemDelete\n");
        return ERROR;
}

int orcSemGive(ORCSEM_ID sem)
{
        return (rt_sem_v(sem));
}

int orcSemTake(ORCSEM_ID sem, int timeout)
{
        return (rt_sem_p(sem, timeout));
}

int orcTaskIdVerify(ORCTHR_ID Id)
{
        if (Id != NULL) {
                return OK;
        }
        printf("orcTaskIdVerify ERROR \n");
        return ERROR;
}

int orcTaskDelete(ORCTHR_ID task)
{
        int result;

        if (task == 0) {
                printf("ERROR rt_task_delete, task == 0\n");
                return ERROR;
        }
        result = rt_task_delete(task);
        if (result != 0) {
                printf("ERROR rt_task_delete  %p error %d\n", task, result);
                return ERROR;
        }
        free(task);
        return OK;
}

int orcSpawn(ORCTHR_ID *tid, const char *name, int prio, STACKSIZE stackSize, SOSO funcptr, void * arg)
{
        int err;
        //Allocate memory
        if (((*tid) = (RT_TASK*) malloc (sizeof(RT_TASK))) == NULL) {
                printf("Error malloc orcspawn\n" );
                return ERROR;
        }
        if ((err = rt_task_spawn(*tid, name, stackSize, prio, T_FPU|T_JOINABLE|T_CPU(0), (SOSO) funcptr, arg)) != 0) {
                printf("ERROR %d rt_task_init\n", err);
                return ERROR;
        }
        printf("rt_task create %s prio %d StackSize %d Id %p \n", name, prio, stackSize, tid);
        return OK;
}
int orcSpawn1(ORCTHR_ID *tid, const char *name, int prio, STACKSIZE stackSize, SOSO funcptr, void * arg)
{
        int err;
        //Allocate memory
        if (((*tid) = (RT_TASK*) malloc (sizeof(RT_TASK))) == NULL) {
                printf("Error malloc orcspawn\n" );
                return ERROR;
        }
        if ((err = rt_task_spawn(*tid, name, stackSize, prio, T_FPU|T_JOINABLE|T_CPU(1), (SOSO) funcptr, arg)) != 0) {
                printf("ERROR %d rt_task_init\n", err);
                return ERROR;
        }
        printf("rt_task create %s prio %d StackSize %d Id %p \n", name, prio, stackSize, tid);
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
///Function that returns the task accumulated excectime in nanoseconds
inline long long orcGetExecTime(ORCTHR_ID task)
{
        RT_TASK_INFO info;
        crexec = rt_task_inquire(task,&info);
        if (crexec != 0) {
                printf("rt_task_get_exectime error %d \n", crexec);
                return (long long)0;
        } else return (long long)info.exectime;
}
///Function that shadows main in real time
int orcMakeRealTime(void)
{
        int prio_main = PRI_MT_MAX + 1;
        mlockall(MCL_CURRENT | MCL_FUTURE);
        if ((cr = rt_task_shadow(MAIN_RT, "MAIN_PRR", prio_main, T_FPU | T_JOINABLE)) != 0) {
                printf("rt_task_shadow error %d \n", cr);
        } else {
                printf("rt_task_shadow done priority %d \n", prio_main);
        }
        return cr;
}

// Traps Ctrl C Interruption
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
        return ;
}
/// Masking all signals but SIGINT and SIGTERM
int orcTimerSigMask(void)
{
        sigset_t set;
        sigfillset(&set);
        if ((err = pthread_sigmask(SIG_BLOCK, &set, NULL)) != OK) {
                printf("pthread_sigmask Failed %d \n", err);
                return ERROR;
        }
        sigemptyset(&set);
        sigaddset(&set, SIGINT);
        sigaddset(&set, SIGTERM);
        if ((err = pthread_sigmask(SIG_UNBLOCK, &set, NULL)) != OK) {
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
long long loopbusytime, clockbusytime;
void clock_it(void)
{
        int msg = 1;

        long long clockexectime, clockdiff;
        static long long clockpast = 0;
        while (!end) {
                err = rt_alarm_wait(&BaseClk);
                clockbusytime = llabs(30000000*(cos((double)GetCpuTime()/NSEC_PER_SEC)));
                //clockbusytime = 30000000;
                rt_timer_spin((RTIME)clockbusytime);
                clockexectime = orcGetExecTime(NULL);
                /*       clockexectime = orcGetExecTime(thr_loop); */
                if (msg > 2) {
                        clockdiff = clockexectime - clockpast;
                        clockpast  = clockexectime;
			/*clockdiff should me busytime + a handfull of usecs, be carefull to print the busytime of the measured task!!!*/
                        printf("clockexectime %lld clockdiff %lld  busytime %lld \n", clockexectime, clockdiff, clockbusytime );
                } else clockpast  = clockexectime;

                orcMsgQSend(Queue, msg, 0);
                msg++;
        }
        return ;
}
void func_loop()
{
        int msg;
        long long loopexectime, loopdiff;
        static long long looppast;
        while (!end) {
                orcMsgQReceive(Queue, &msg);
                loopbusytime = llabs(20000000*(cos((double)GetCpuTime()/NSEC_PER_SEC)));
                //loopbusytime = 20000000;
                rt_timer_spin((RTIME)loopbusytime);
                /*       loopexectime = orcGetExecTime(thr_clockit); */
                /*       loopexectime = orcGetExecTime(NULL); */
                /*       if(msg > 2){ */
                /* 	  loopdiff = loopexectime - looppast; */
                /* 	  looppast  = loopexectime; */
		/*clockdiff should me busytime + a handfull of usecs, be carefull to print the busytime of the measured task!!!*/
                /* 	  printf("loopexectime  %lld loopdiff %lld busytime %lld \n", loopexectime, loopdiff, loopbusytime );} */
                /*       else looppast  = loopexectime; */
                printf("received msg = %d \n", msg);
        }
        return;
}
int main(void)
{

        orcTimerSigMask();

        signal(SIGTERM, clean_exit);
        signal(SIGINT, clean_exit);

        orcMakeRealTime();

        setTimer();

        Queue = orcMsgQCreate();

        orcSpawn(&thr_clockit, "AlarmServer", MAX_PRIO -2, NORMAL_STACK, (SOSO) clock_it, NULL);
        orcSpawn(&thr_loop, "Loop", MAX_PRIO - 3, NORMAL_STACK, (SOSO) func_loop, NULL);

        pause();
        fflush(NULL);

        return 0;
}




--MP_MUBRZk8Nca62.fTwIn/AXZR--

