Message-ID: <4E8981F9.9090105@domain.hid>
Date: Mon, 3 Oct 2011 11:35:53 +0200
From: Michael Bernhard <michael.bernhard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] SIGILL when calling pthread_cleanup_push()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

We are using Xenomai-2.5.6 together with Linux-2.6.35 on a PXA270 
processor. Xenomai works fine so far. However we get SIGILL when using 
pthread_cleanup_push() in a RT-thread. I now tried the same over 
Xenomai-2.6 and the behavior is still the same.

Here's a simple example which shows the problem (for Xenomai-2.6):

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <signal.h>
#include <execinfo.h>
#include <sys/mman.h>

pthread_t thread_id;

void sig_handler(int signal)
{
   void *bt[32];
   int nentries;

   printf("Cought signal: %d\n", signal);

   nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
   backtrace_symbols_fd(bt,nentries,fileno(stdout));
}

void cancel_func(void * arg)
{
}

void * thread_func(void * arg)
{
   /* When forcing a mode switch to Linux, SIGILL is not generated */
#if 0
   __real_printf("Force mode switch\n");
#endif

   pthread_cleanup_push (cancel_func, NULL);
   pthread_cleanup_pop(1);

   return NULL;
}

int main (int argc, char * argv[])
{
   pthread_attr_t attr;
   struct sched_param prio = {.sched_priority = 99};
	
   signal(SIGILL, sig_handler);
	
   mlockall(MCL_CURRENT | MCL_FUTURE);
	
   pthread_attr_init(&attr);
   pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
   pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
   pthread_attr_setschedparam(&attr, &prio);
	
   pthread_create(&thread_id, &attr, thread_func, NULL);

   sleep(1);
	
   pthread_join(thread_id, NULL);
	
   return 0;
}

SIGILL is not raised, when a mode switch to Linux is forced prior to 
call pthread_cleanup_push(). It is also not rised when the RT-thread 
runs under SCHED_OTHER.

The "Undefined instruction" gets incremented in /proc/xenomai/faults.

The backtrace does not reveal much information:
Cought signal: 4
./sigill[0x89bc]
/lib/libc.so.6(__default_sa_restorer_v2+0x0)[0x8bda90]
/lib/libc.so.6(__sigsetjmp+0x38)[0x8bc4f8]
./sigill[0x8a44]
/usr/xenomai/lib/libpthread_rt.so.1(+0x4448)[0x82c448]
/lib/libpthread.so.0(+0x5b60)[0x852b60]
/lib/libc.so.6(clone+0x88)[0x967c58]

What is going wrong here?

--
Michael

