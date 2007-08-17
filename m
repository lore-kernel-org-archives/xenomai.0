Message-ID: <46C57FBF.9050108@domain.hid>
Date: Fri, 17 Aug 2007 13:00:15 +0200
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
References: <18116.37871.209453.702969@domain.hid>
In-Reply-To: <18116.37871.209453.702969@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Time for rt_mutex_acquire
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

gilles.chanteperdrix@xenomai.org wrote:
> Dirk Eibach wrote:
>  > Hello,
>  > 
>  > I'm wondering how long a rt_mutex_acquire is supposed to take on a PPC405 
>  > platform. I'm getting times about 50 usec here, which is too much for my 
>  > application. Is anything wrong in my kernel/xenomai configuration or is 
>  > this time to expected?
> 
> How do you measure this ? Are you sure the mutex is free when you try to
> acquire it ?
> 

I prepared a small testcase. It shows about 8.300 ticks, which is about 30 
usec on my platform (266MHz).

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/mutex.h>
#include <native/task.h>
#include <native/timer.h>

#include <rtdm/rtserial.h>

#define TOGGLE \
	do {rt_dev_ioctl(0, _IOR(RTIOC_TYPE_SERIAL, 0xdf, int), 0);} while(0);

RT_TASK demo_task;

/* NOTE: error handling omitted. */
static void
ppc_getcounter(unsigned long long *v)
{
	register unsigned long tbu, tb, tbu2;

     loop:
	asm volatile ("mftbu %0" : "=r" (tbu) );
	asm volatile ("mftb  %0" : "=r" (tb)  );
	asm volatile ("mftbu %0" : "=r" (tbu2));
	if (__builtin_expect(tbu != tbu2, 0)) goto loop;

	/* The slightly peculiar way of writing the next lines is
	compiled better by GCC than any other way I tried. */
	((long*)(v))[0] = tbu;
	((long*)(v))[1] = tb;
}

void demo(void *arg)
{
	RT_MUTEX mutex;

	rt_mutex_create (&mutex, NULL);
	int file_descriptor = rt_dev_open("rtser0", O_RDWR | O_NOCTTY);
	
	unsigned long long count0, count1;
	
	while (1) {
		ppc_getcounter(&count0);
		rt_mutex_acquire(&mutex, TM_INFINITE);
		ppc_getcounter(&count1);
		printf("ticks for rt_mutex_acquire: %lld\n", count1- count0);
		rt_task_sleep(rt_timer_ns2ticks(1 * 1000000000llu));
		rt_mutex_release(&mutex);
		rt_task_sleep(rt_timer_ns2ticks(1 * 1000000000llu));
	}
}

void catch_signal(int sig)
{
}

int main(int argc, char* argv[])
{
	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);

	/* Avoids memory swapping for this program */
	mlockall(MCL_CURRENT|MCL_FUTURE);

	/*
	 * Arguments: &task,
	 *            name,
	 *            stack size (0=default),
	 *            priority,
	 *            mode (FPU, start suspended, ...)
	 */
	rt_task_create(&demo_task, "trivial", 0, 99, 0);

	/*
	 * Arguments: &task,
	 *            task function,
	 *            function argument
	 */
	rt_task_start(&demo_task, &demo, NULL);

	pause();

	rt_task_delete(&demo_task);
}


-- 
Dirk Eibach
Entwicklung
Guntermann & Drunck GmbH Systementwicklung




