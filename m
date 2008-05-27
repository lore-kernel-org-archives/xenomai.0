MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SQ17IWaKNg"
Content-Transfer-Encoding: 7bit
Message-ID: <18491.24080.887191.908800@domain.hid>
Date: Tue, 27 May 2008 03:04:16 +0200
In-Reply-To: <2405.81.252.86.91.1211549465.squirrel@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
	<15059.81.252.86.91.1211386718.squirrel@domain.hid>
	<18484.28025.505865.374746@domain.hid>
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org


--SQ17IWaKNg
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Fabien MAHOT wrote:
 > I hope that you can help me. I will try to execute this program without
 > your patch to see what kernel traces I will have if the kernel crashes.
 > I wonder why my system is so unsteady...

Ok. I finally got the crash. Please find attached a version of your
program rewritten in "return value paranoid" mode. It is a good idea to
always check the return value of any function you call, especially in
test code. And especially in production code too. So, all the time in
fact.

-- 


					    Gilles.

--SQ17IWaKNg
Content-Type: text/plain
Content-Disposition: inline;
	filename="foo.c"
Content-Transfer-Encoding: 7bit

#include <sys/mman.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <time.h>
#include <math.h>
#include <signal.h>
#include <semaphore.h>
#include <errno.h>

#define NB_PTR_TEMPO 3  // 5 tempos maximum
#define STACKSIZE 350

// stack
static int Stack[STACKSIZE];
static unsigned short Write_ptr = 0;
static unsigned short Read_ptr = 0;

// Display
pthread_mutex_t lockDisplay;
unsigned char bufferDisplay[2048];

// Timer
struct stTimeOut {
    timer_t timer_h;
    struct sigaction    sa;
    struct sigevent     sig_spec;
    struct itimerspec   tmr_setting;
    int number;
}*timeOut0_ptr, *timeOut1_ptr, *timeOut2_ptr, *timeOut3_ptr, *timeOut4_ptr;

// TimeOut_ptr
struct stTimeOut* tabTimeOut_ptr[STACKSIZE];
static unsigned short Write_to_ptr = 0;
static unsigned short Read_to_ptr = 0;

// Thread start
pthread_cond_t  start_signal;
pthread_mutex_t main_start_lock;
bool bMainStart = false;
// Time-out end
pthread_cond_t   TimeOutEnd_signal;
pthread_mutex_t  timeOutEnd_lock;
bool bTimeOutEnd = false;
sem_t  TimeOutWait_sem;

// Stack mutex
pthread_mutex_t Stack_lock;

void check(const char *file, int line, const char *service, int status, int err)
{
    if (status >= 0)
	return;

    fprintf(stderr, "%s:%d: %s: %s\n", file, line, service, strerror(err));
    exit(EXIT_FAILURE);
}

#define check_pthread(expr)		\
    ({						\
	int _status = (expr);                 \
	check(__FILE__, __LINE__, #expr, -_status, _status);	\
    })

#define check_unix(expr) \
    check(__FILE__, __LINE__, #expr, (expr), errno)

/************************ Stack functions *************************/

int StackCreation(void)
{
    Write_ptr = 0;
    Read_ptr  = 0;
    return 0;
}

void StackWrite(int number)
{
    if (Write_ptr >= STACKSIZE)
	Write_ptr = 0;
    Stack[Write_ptr++] = number;
}

int StackRead(void)
{
    int number;
    if (Read_ptr >= STACKSIZE)
	Read_ptr = 0;
    number = Stack[Read_ptr++];
    return number;
}

unsigned short GetWritePtr(void)
{
    return Write_ptr;
}

unsigned short GetReadPtr(void)
{
    return Read_ptr;
}

/************************ Functions ******************************/
void display(char * chaine,...)
{
    check_pthread(pthread_mutex_lock(&lockDisplay));
    va_list ArgDisplay;
    va_start(ArgDisplay, chaine);
    check_unix(vsprintf((char *)bufferDisplay,chaine,ArgDisplay));
    check_unix(write(2,(char*)bufferDisplay, strlen((char *)bufferDisplay)));
    //printf(bufferDisplay);
    check_pthread(pthread_mutex_unlock(&lockDisplay));
}

int func(volatile int* i)
{
    return (*i)++;
}

void DeleteTimer(timer_t timer)
{
    if (timer!=NULL)
	check_unix(timer_delete(timer));
}

void EndTimeOut (int signo,siginfo_t *info,void*context)
{
    volatile int i, result = 0;

    DeleteTimer(((struct stTimeOut*)(info->si_value.sival_ptr))->timer_h);

    StackWrite(((struct stTimeOut*)(info->si_value.sival_ptr))->number);

    check_unix(sem_post(&TimeOutWait_sem));
}

void StartTimeOut (int nb_Sec, int nb_nSec, struct stTimeOut* timeOut)
{
    (timeOut->sa).sa_flags = SA_SIGINFO;
    (timeOut->sa).sa_sigaction = EndTimeOut;

    check_unix(sigaction(SIGRTMIN, &(timeOut->sa), NULL));

    (timeOut->sig_spec).sigev_notify = SIGEV_SIGNAL;
    (timeOut->sig_spec).sigev_signo = SIGRTMIN;
    (timeOut->sig_spec).sigev_value.sival_ptr = timeOut;

    check_unix(timer_create(CLOCK_REALTIME, &(timeOut->sig_spec),
			    &(timeOut->timer_h)));

    (timeOut->tmr_setting).it_value.tv_sec = nb_Sec;
    (timeOut->tmr_setting).it_value.tv_nsec = nb_nSec;
    (timeOut->tmr_setting).it_interval.tv_sec = 0;
    (timeOut->tmr_setting).it_interval.tv_nsec = 0;

    check_unix(timer_settime((timeOut->timer_h), 0,
			     &(timeOut->tmr_setting),NULL));
}

/************************** Threads ********************************/
void* threadTimeOutEnd(void * arg) {

    int NbSem = 0;
    bool bSemWaitError;

    display("TimeOutCreation thread\n");
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart) {
	check_pthread(pthread_cond_wait(&start_signal, &main_start_lock));
    }
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    display("TimeOutCreation thread\n");

    while (1) {
	while ((bSemWaitError = sem_wait(&TimeOutWait_sem)) < 0
	       && errno == EINTR)
	    ;
	if (bSemWaitError) {
	    fprintf(stderr, "sem_wait(&TimeOutWait_sem): %s\n", strerror(errno));
	    exit(EXIT_FAILURE);
	}

	check_pthread(pthread_mutex_lock(&timeOutEnd_lock));
	check_pthread(pthread_cond_broadcast(&TimeOutEnd_signal));
	bTimeOutEnd = true;
	check_pthread(pthread_mutex_unlock(&timeOutEnd_lock));
    }
}

void* threadTimeOut(void * arg) {
    int i=1;
    int j, k, NbTimeOut, numTimeOut;

    timeOut0_ptr = timeOut1_ptr = timeOut2_ptr = timeOut3_ptr =
	timeOut4_ptr = NULL;

    display("TimeOut thread\n");
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart)
	check_pthread(pthread_cond_wait(&start_signal, &main_start_lock));
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    display("TimeOut thread\n");

    while (i < 100) {
	// Malloc and start of time out
	for (j=0 ; j < NB_PTR_TEMPO; j++) {
	    switch(j) {
	    case 0 : if (timeOut0_ptr == NULL) {
		    timeOut0_ptr=(struct stTimeOut*)malloc(sizeof(struct stTimeOut));
		    if (timeOut0_ptr == NULL) exit(1);
		    timeOut0_ptr->number = i;
		    i++;
		    display("Start of time out %d - 5ms\n",
			    timeOut0_ptr->number);
		    StartTimeOut(0,500000000,timeOut0_ptr);
		}
		break;
	    case 1 : if (timeOut1_ptr == NULL) {
		    timeOut1_ptr=(struct stTimeOut*)malloc(sizeof(struct stTimeOut));
		    if (timeOut1_ptr == NULL) exit(1);
		    timeOut1_ptr->number = i;
		    i++;
		    display("Start of time out %d - 5ms\n",
			    timeOut1_ptr->number);
		    StartTimeOut(0,500000000,timeOut1_ptr);
		}
		break;
	    case 2 : if (timeOut2_ptr == NULL) {
		    timeOut2_ptr=(struct stTimeOut*)malloc(sizeof(struct stTimeOut));
		    if (timeOut2_ptr == NULL) exit(1);
		    timeOut2_ptr->number = i;
		    i++;
		    display("Start of time out %d - 5ms\n",
			    timeOut2_ptr->number);
		    StartTimeOut(0,500000000,timeOut2_ptr);
		}
		break;
	    case 3 : if (timeOut3_ptr == NULL) {
		    timeOut3_ptr=(struct stTimeOut*)malloc(sizeof(struct stTimeOut));
		    if (timeOut3_ptr == NULL) exit(1);
		    timeOut3_ptr->number = i;
		    i++;
		    display("Start of time out %d - 5ms\n",
			    timeOut3_ptr->number);
		    StartTimeOut(0,500000000,timeOut3_ptr);
		}
		break;
	    case 4 : if (timeOut4_ptr == NULL) {
		    timeOut4_ptr=(struct stTimeOut*)malloc(sizeof(struct stTimeOut));
		    if (timeOut4_ptr == NULL) exit(1);
		    timeOut4_ptr->number = i;
		    i++;
		    display("Start of time out %d - 5ms\n",
			    timeOut4_ptr->number);
		    StartTimeOut(0,500000000,timeOut4_ptr);
		}
		break;
	    }
	}

	check_pthread(pthread_mutex_lock(&timeOutEnd_lock));
	while (!bTimeOutEnd)
	    check_pthread(pthread_cond_wait(&TimeOutEnd_signal,
					    &timeOutEnd_lock));
	bTimeOutEnd = false;

	check_pthread(pthread_mutex_unlock(&timeOutEnd_lock));

	NbTimeOut = GetWritePtr() - GetReadPtr();
	display("Number of time-outs ends : %d\n", NbTimeOut);
	for (j=0; j < NbTimeOut; j++) {
	    numTimeOut = StackRead();
	    display("TimeOut%d ends\n", numTimeOut);
	    for (k=0; k < NB_PTR_TEMPO; k++) {
		switch(k) {
		case 0 : if (timeOut0_ptr != NULL) {
			if (timeOut0_ptr->number == numTimeOut) {
			    free(timeOut0_ptr);
			    timeOut0_ptr = NULL;
			}
		    }
		    break;
		case 1 : if (timeOut1_ptr != NULL) {
			if (timeOut1_ptr->number == numTimeOut) {
			    free(timeOut1_ptr);
			    timeOut1_ptr = NULL;
			}
		    }
		    break;
		case 2 : if (timeOut2_ptr != NULL) {
			if (timeOut2_ptr->number == numTimeOut) {
			    free(timeOut2_ptr);
			    timeOut2_ptr = NULL;
			}
		    }
		    break;
		case 3 : if (timeOut3_ptr != NULL) {
			if (timeOut3_ptr->number == numTimeOut) {
			    free(timeOut3_ptr);
			    timeOut3_ptr = NULL;
			}
		    }
		    break;
		case 4 : if (timeOut4_ptr != NULL) {
			if (timeOut4_ptr->number == numTimeOut) {
			    free(timeOut4_ptr);
			    timeOut4_ptr = NULL;
			}
		    }
		    break;
		}
	    }
	}
    }
    while(1) {
	sleep(10);
    }
    return NULL;
}

void* threadDisplay(void * arg) {
    volatile int i=0;
    volatile int result;
    display("Display thread\n");
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart)
	check_pthread(pthread_cond_wait(&start_signal, &main_start_lock));
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    display("Display thread\n");

    while (i <= 200000) {
	result = func(&i);
	display("Display thread :%d \r",result);
    }
    display("End of display thread\n");
    return NULL;
}

/***********************************************************************/
void cleanup_upon_sig(int sig __attribute__((unused)))
{
    if (timeOut0_ptr)
	DeleteTimer(timeOut0_ptr->timer_h);
    if (timeOut1_ptr)
	DeleteTimer(timeOut1_ptr->timer_h);
    if (timeOut2_ptr)
	DeleteTimer(timeOut2_ptr->timer_h);
    exit(0);
}

int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_mutexattr_t attr_proto;
    pthread_t p0;
    pthread_t p1;
    pthread_t p2;
    struct sched_param sch;

    // Stack & TabTImeOutptr creation
    StackCreation();

    check_unix(signal(SIGINT, cleanup_upon_sig));
    check_unix(signal(SIGTERM, cleanup_upon_sig));
		   
    check_unix(mlockall(MCL_CURRENT|MCL_FUTURE));

    // mutex and sem initialisation
    check_pthread(pthread_cond_init(&start_signal, NULL));
    check_pthread(pthread_mutex_init(&main_start_lock, NULL));
    check_pthread(pthread_cond_init(&TimeOutEnd_signal, NULL));
    check_pthread(pthread_mutex_init(&timeOutEnd_lock, NULL));
    check_unix(sem_init (&TimeOutWait_sem, 0,0));
    check_pthread(pthread_mutexattr_init(&attr_proto));
    check_pthread(pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_INHERIT));
    check_pthread(pthread_mutex_init(&lockDisplay, &attr_proto));

    check_pthread(pthread_attr_init(&attr));
    check_pthread(pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED));
    check_pthread(pthread_attr_setschedpolicy(&attr, SCHED_FIFO));

    // TimeOutCreation thread creation
    sch.sched_priority = 85;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p0, &attr, threadTimeOutEnd, NULL));

    // TimeOut thread creation
    sch.sched_priority = 80;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p1, &attr, threadTimeOut, NULL));

    // Display thread creation
    sch.sched_priority = 70;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p2, &attr, threadDisplay, NULL));

    check_pthread(pthread_attr_destroy(&attr));

    display("Main condition broadcast\n");
    // Start of all threads
    check_pthread(pthread_mutex_lock(&main_start_lock));
    bMainStart = true;
    check_pthread(pthread_cond_broadcast(&start_signal));
    check_pthread(pthread_mutex_unlock(&main_start_lock));

    while (1) {
	sleep(5);
    }

    return 0;
}

--SQ17IWaKNg--

