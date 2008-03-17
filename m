Message-ID: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
Date: Mon, 17 Mar 2008 15:43:09 +0100 (CET)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Application crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I ve got a problem with my application. I use the Xenomai 2.3.4 kernel
(disable priority coupling option -> deactivate).
I wrote a test program to show you the problem.

There are T1 thread with the highest priority and T2 thread.
T1 thread sleeps during 5ms and uses the console function to display its
current state.
T2 uses the console function to display its current state.
To use the console function, the threads need lockConsole mutex.

#include <sys/mman.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdarg.h>
#include <semaphore.h>

// Console
pthread_mutex_t lockConsole;
unsigned char bufferConsole[2048];
// Start of tasks
pthread_cond_t  start_signal;
pthread_mutex_t main_start_lock;

void console(char * chaine,...)
{
    if (pthread_mutex_lock(&lockConsole)!=3D0)
    {
       printf("Error:pthread_mutex_lock\n");
    }
    pthread_t p0;
    va_list ArgConsole;
    va_start(ArgConsole, chaine);
    vsprintf((char *)bufferConsole,chaine,ArgConsole);
    if (write(2, (char*)bufferConsole, strlen((char *)bufferConsole)) =3D=
=3D -1)
    {
       printf("Error:write\n");
    }
    pthread_mutex_unlock(&lockConsole);
}

int func(volatile int* i)
{
	return (*i)++;
}

/************************ tasks ****************************/
void* thread1(void * cookie) {
    volatile int i=3D0;
    volatile int result;

    pthread_mutex_lock(&main_start_lock);
    pthread_cond_wait(&start_signal, &main_start_lock);
    pthread_mutex_unlock(&main_start_lock);

    while (i < 10) {
        usleep(5000);
        result =3D func(&i);
        console ("T1 : %d \n",result);
    }

    return NULL;
}

void* thread2(void * cookie) {
    volatile int i=3D0;
    volatile int result;

    pthread_mutex_lock(&main_start_lock);
    pthread_cond_wait(&start_signal, &main_start_lock);
    pthread_mutex_unlock(&main_start_lock);

    while (i < 200) {
        result =3D func(&i);
        console ("T2 : %d \n",result);
    }

    return NULL;
}

/************************** main *****************************/
int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_mutexattr_t attr_proto;
    struct sched_param sch;
    pthread_t p1;
    pthread_t p2;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    pthread_mutexattr_init(&attr_proto);
    pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_INHERIT);
    pthread_mutex_init(&lockConsole, &attr_proto);

    pthread_cond_init(&start_signal, NULL);
    pthread_mutex_init(&main_start_lock, NULL);

    pthread_attr_init(&attr);
    pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

    // creation of task 1
    sch.sched_priority =3D 80;
    pthread_attr_setschedparam(&attr, &sch);
    pthread_create(&p1, &attr, thread1, NULL);

    // creation of task 2
    sch.sched_priority =3D 75;
    pthread_attr_setschedparam(&attr, &sch);
    pthread_create(&p2, &attr, thread2, NULL);

    // Start of tasks
    pthread_mutex_lock(&main_start_lock);
    pthread_cond_broadcast(&start_signal);
    pthread_mutex_unlock(&main_start_lock);

    pthread_attr_destroy(&attr);

    while (1){
        sleep(500);
    }

    return 0;
}



Result in Xenomai environment(Xenomai 2.3.4 kernel) :
T2 : 0
T2 : 1
T2 : 2
T2 : 3
T2 : 4
T2 : 5
T2 : 6
T2 : 7
T2 : 8
T2 : 9

And the application crashes without error message.
When the application crashes, I think that T1 thread runs in the console
function and it will be put in hold (mutex or write). Thanks to an other
test program, I saw that there is a wait in the write function

So, there is a preemption possibility.

I try different configurations :
- When I delete the console call in T1, my application doesn't crash.
- When I use a clock thread which sleeps during 5ms and wakes up T1 thank=
s
to a semaphore, my application doesn't crash. (T1 doesn't call usleep)

So there is something strange. I think there is a problem when a thread
changes of domain (Xenomai to linux) after time out function use (when yo=
u
use these functions, is there a signal emission when the time out is
finished? maybe, this signal crashes my application...)

I would like to know why I ve got this problem. If you ve got an idea,
please , give me your opinion.

Thanks a lot.









