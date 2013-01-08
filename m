Date: Tue, 08 Jan 2013 12:12:46 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50ebff2e488690.18102992@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi GIlles,

As you suggested, I have prepared simple test case that demonstrate how Xenomai is utilized by OROCOS. This test case behaves exactly the same like helloword example. Scheduler is chosen before any mutex are processed, so in my opinion it is not the case which you defined. What is really surprising is that the replacing TM_NONBLOCK with TM_INFINITE, in one before last line, do magic and suppress signal generation. Furthermore, there is no call to 'rt_task_set_mode(0, T_WARNSW, NULL);' so why 
signal is generated? If we enable T_WARNSW in the thread, SIGXCPU is generated when mutex is locked first time in the thread. 

Code is following:

/*****************************************************************************
 * mutexTest.c
 * Xenomai mutex test for SIGXCPU
 * Mariusz Janiak
 * Wroclaw 2013
 *****************************************************************************/

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <execinfo.h>
#include <sched.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/sem.h>

#define ORO_SCHED_OTHER 1 /** Soft real-time */

#ifdef UNUSED
#elif defined(__GNUC__)
# define UNUSED(x) UNUSED_ ## x __attribute__((unused))
#else
# define UNUSED(x) x
#endif

void test(void *UNUSED(arg));
void warn_upon_switch(int UNUSED(sig));

RT_TASK  mainTask, testTask; 
RT_MUTEX mutex;
RT_SEM   sem;

void warn_upon_switch(int UNUSED(sig))
{
  void *bt[32];
  int nentries;
  
  nentries = backtrace(bt, sizeof(bt) / sizeof(bt[0]));
  backtrace_symbols_fd(bt, nentries, fileno(stderr));
}

void test(void *UNUSED(arg))
{
  
  /* thread_function() in Thread.cpp:83 -- Thread::configure() in 
     Thread.cpp:489 -- rtos_task_set_period(...) in fosi_internal.cpp:387 --
     rtos_task_make_periodic(...) in fosi_internal.cpp:378*/
  rt_task_set_periodic(NULL, TM_NOW, TM_INFINITE);
  /* thread_function() in Thread.cpp:86 -- rtos_sem_signal(...) in fosi.h:188*/
  rt_sem_v(&sem);
  /* thread_function() in Thread.cpp:89 -- MutexLock */
  rt_mutex_acquire(&mutex, TM_INFINITE);
  rt_mutex_release(&mutex);
  /* hread_function() in Thread.cpp:116 -- rtos_sem_wait(...) in fosi.h:194 */
  rt_sem_p(&sem, TM_INFINITE);
}

int main(int UNUSED(argc), char *UNUSED(argv[]))
{
  int                ret=0;
  struct sched_param param;
  struct sigaction   sa;

  /* rtos_task_create_main(...) in fosi_internal.cpp:82 */
  mlockall(MCL_CURRENT|MCL_FUTURE);
  /* rtos_task_create_main(...) in fosi_internal.cpp:91 */
  param.sched_priority = sched_get_priority_max(ORO_SCHED_OTHER);
  if (param.sched_priority != -1 ){
    sched_setscheduler(0, ORO_SCHED_OTHER, &param);
  }
  /* rtos_task_create_main(...) in fosi_internal.cpp:102 */
  ret = rt_task_shadow(&mainTask, "MutexTest", 0, 0);
  if(ret < 0){
    printf("ERROR: rt_task_shadow(...)\n");
    return -1;
  }
  /* rtos_task_create_main(...) in fosi_internal.cpp:162 */
  sa.sa_sigaction = warn_upon_switch;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = 0;
  sigaction(SIGXCPU, &sa, 0);

  /* Thread::Thread(...) in Thread.cpp:238 -- automatic in constructor */
  rt_mutex_create(&mutex, "breaker");
  /* Thread::setup(...) in Thread.cpp:257 -- in MutexLock constructor */
  ret = rt_mutex_acquire(&mutex, TM_INFINITE);
  /* Thread::setup(...) in Thread.cpp:264 -- rtos_sem_init(...) in fosi.h:176*/
  rt_sem_create(&sem, "sem", 0, S_PRIO);
  /* Thread::setup(...) in Thread.cpp:293 -- rtos_task_create(...) in 
     fosi_internal.cpp:240 */
  ret = rt_task_spawn(&testTask, "testTask", 128000, 1, T_JOINABLE | (0 & T_CPUMASK), test, NULL);
  if(ret < 0){
    printf("ERROR: rt_task_spawn(...)\n");
    return -1;
  }
  /* Thread::setup(...) in Thread.cpp:309 -- rtos_sem_wait(...) in fosi.h:194 */
  rt_sem_p(&sem, TM_INFINITE);
  /* Thread::setup(...) in Thread.cpp:324 --  in MutexLock destructor */
  rt_mutex_release(&mutex);

  /* Do something */
  sleep(1);

  /* Thread::terminate() in Thread.cpp:614 -- rtos_sem_signal(...) in 
     fosi.h:188*/
  rt_sem_v(&sem);
  /* Thread::terminate() in Thread.cpp:616 -- rtos_task_delete(...) in 
     fosi_internal.cpp:490*/
  rt_task_join(&testTask); 
  rt_task_delete(&testTask);
  /* Thread::~Thread() in Thread.cpp:326 -- automatic in destructor when 
     TaskContext::setActivity(...) is called by HelloWord object (default 
     activity created in object constructor is replaced by new activity)*/
  rt_mutex_acquire(&mutex, TM_NONBLOCK); /* rtos_mutex_trylock(...) in 
                                            fosi.h:247 */
  rt_mutex_release(&mutex);              /* we get the SIG here!!! */
  return 0;
}

Building procedure (you need Obj, Dep and Bin dirs in the current path, and Xenomai in /usr/xenomai)

gcc -c -Wp,-MM,-MP,-MT,mutexTest.o,-MF,Dep/mutexTest.d -O2 -ggdb3 -DDEBUG_EN   -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -Wextra -Wcast-align -Wimplicit -Wpointer-arith  -Wswitch -Wredundant-decls -Wreturn-type  -Wunused  -Wsign-compare -Waggregate-return  -Wnested-externs  -Wmissing-prototypes -Wstrict-prototypes -Wmissing-declarations -Wbad-function-cast mutexTest.c -o Obj/mutexTest.o

gcc -o Bin/mutexTest.run Obj/mutexTest.o  -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lm

Mariusz




