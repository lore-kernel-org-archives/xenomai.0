Message-ID: <2ff1a98a0802140546w502ed375k445729b47d4c3077@domain.hid>
Date: Thu, 14 Feb 2008 14:46:45 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <12460.62.39.72.60.1202995942.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <12460.62.39.72.60.1202995942.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix
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

On Thu, Feb 14, 2008 at 2:32 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hi,
>
>  I need your help to understand why my application doesn't work correctly.
>
>  I use the Xenomai 2.3.4 kernel with its POSIX skin to develop a real time
>  application. In this program, I create several threads thanks to a main
>  thread which has the highest priority (SCHED_FIFO configuration). The aim
>  is that the main thread stays in execution during the creation of all the
>  other threads.
>
>  However, in my program, when the main thread calls the posix function
>  pthread_create to create a new thread, it's preempted by a thread created
>  previously. In spite of the main thread has the highest priority.
>
>  To illustrate my problem, I wrote a test program. I execute this
>  application in my xenomai environment and in a linux environment (linux
>  2.6.20 kernel configured preemptive)  :
>
>  My test program : The main function creates Main Thread. After Main Thread
>  creates T1 thread and next T2 thread. Main priority : 30, T1 priority :
>  25, T2 priority : 20.
>
>
>  #include <sys/mman.h>
>  #include <pthread.h>
>  #include <unistd.h>
>  #include <sys/time.h>
>  #include <string.h>
>  #include <stdio.h>
>
>  void console(char * chaine)
>  {
>         write(2, chaine, strlen(chaine));
>         fflush(stderr);
>  }
>
>  int func(volatile int* i)
>  {
>         return (*i)++;
>  }
>
>  void* thread1(void * context) {
>         volatile int i;
>         volatile int result;
>
>         console("T1 : start\n");
>         while (i < 10000) {
>               result = func(&i);
>         }
>         console("T1 : finish\n");
>
>         return NULL;
>  }
>
>  void* thread2(void * context) {
>         volatile int i;
>         volatile int result;
>
>         console("T2 : start\n");
>         while (i < 10000) {
>               result = func(&i);
>         }
>         console("T2 : finish\n");
>
>         return NULL;
>  }
>
>  void* thread_main(void *arg) {
>         pthread_attr_t attr;
>         pthread_t p1;
>         pthread_t p2;
>         struct sched_param sch;
>         struct sched_param sch1;
>         int result;
>
>         pthread_attr_init(&attr);
>         pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
>         pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>
>         sch.sched_priority = 25;
>         pthread_attr_setschedparam(&attr, &sch);
>
>         console("M : before pthread_create T1\n");
>         pthread_create(&p1, &attr, thread1, NULL);
>         console("M : after pthread_create T1\n");
>
>         sch.sched_priority = 20;
>         pthread_attr_setschedparam(&attr, &sch);
>
>         console("M : before pthread_create T2\n");
>         result = pthread_create(&p2, &attr, thread2, NULL);
>         if (result != 0)
>         {
>                 console("creation of thread 2 impossible\n");
>         }
>         console("M : after pthread_create T2\n");
>
>         pthread_attr_destroy(&attr);
>
>         while (1) {
>                 sleep(500);
>         }
>         return NULL;
>  }
>
>  int main(int argc, char** argv) {
>         pthread_attr_t attr;
>         pthread_t p;
>         struct sched_param sch;
>
>         mlockall(MCL_CURRENT|MCL_FUTURE);
>
>         pthread_attr_init(&attr);
>         pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
>         pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>
>         sch.sched_priority = 30;
>         pthread_attr_setschedparam(&attr, &sch);
>         pthread_create(&p, &attr, thread_main, NULL);
>         pthread_attr_destroy(&attr);
>
>         while (1) {
>                 sleep(500);
>         }
>
>         return 0;
>  }
>
>
>
>  Result in Linux environment :
>
>  M : before pthread_create T1
>  M : after pthread_create T1
>  M : before pthread_create T2
>  M : after pthread_create T2
>  T1 : start
>  T1 : finish
>  T2 : start
>  T2 : finish
>
>  Result in Xenomai environment :
>
>  M : before pthread_create T1
>  M : after pthread_create T1
>  M : before pthread_create T2
>  T1 : start
>  T1 : finish
>  M : after pthread_create T2
>  T2 : start
>  T2 : finish
>
>  In the Linux environment, the thread creation is correct, Main thread is
>  not preempted by T1.
>  But in the Xenomai environment, we can see that Main thread is preempted
>  by T1 thread during the T2 creation.
>
>  I would like to know why I ve got this problem with Xenomai. If you ve got
>  an idea, please , give me your opinion.

pthread_create suspends the caller for a short time, I do not think
that it contradicts the posix standard. Besides, there are other calls
in your example that may suspend their caller: write and fflush.

-- 
 Gilles Chanteperdrix

