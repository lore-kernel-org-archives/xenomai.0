Message-ID: <47B0D165.4080709@domain.hid>
Date: Mon, 11 Feb 2008 23:51:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47B0371E0200000100192400@domain.hid>	<47B093D8.2050605@domain.hid>
	<47B06F8C0200000100192434@domain.hid>
In-Reply-To: <47B06F8C0200000100192434@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?R=E9p=2E_=3A_Re=3A__T=5FRRB?=
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

Hubert Talbot wrote:
> There is something I don't understand.
> 
> Does Xenomai really implement RRB?
>

Yes it does, and it even happens to work, provided it is used properly.

> Here is my code:
> 
> //****************************************************
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/timer.h>
> #include <native/sem.h>
> 
> #define NBTASK 2
> #define NSEC 	1
> #define USEC 	1000
> #define MSEC 	1000000
> #define SEC 	1000000000
> 
> RT_TASK tasks[NBTASK];
> RT_SEM sem;
> 
> void my_sleep(int nSec)
> {
> 	struct timeval tv_start, tv_current;
> 	
> 	gettimeofday(&tv_start, 0);
> 	
> 	do
> 	{
> //		rt_task_wait_period(NULL);
> 		struct timeval;
> 		gettimeofday(&tv_current, 0);
> 	} while (tv_current.tv_sec - tv_start.tv_sec <= nSec);
> }
>

Xenomai RRB will work for tasks controlled by the Xenomai scheduler. By
calling gettimeofday(), your tasks switch to a runtime mode where they
depend on the Linux scheduler, so there is no way for the round-robin
swap to take place properly at Xenomai level. Your tasks will just run
in FIFO order due to Linux scheduling.

The code below will exhibit RRB scheduling controlled by the Xenomai
core; the point is to use the real-time API to perform the busy-wait,
and never call into any Linux service in the meantime:

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>

#define NBTASK 2
#define NSEC 	1
#define USEC 	1000
#define MSEC 	1000000
#define SEC 	1000000000
#define PERIOD  (10 * MSEC)

RT_TASK tasks[NBTASK];
RT_SEM sem;

static inline unsigned tick_delta(RTIME t0, RTIME t1)
{
	return ((unsigned)(t1 - t0) * PERIOD) / SEC;
}

void my_sleep(int nSec)
{
	RTIME start_ticks, wait_ticks;
	
	wait_ticks = (nSec * SEC) / PERIOD;
	start_ticks = rt_timer_read();

	while (rt_timer_read() - start_ticks <= wait_ticks)
		;
}

void task(void *arg)
{
	int taskID = (int)(long)arg;
	RTIME start_date, end_date;
	
	rt_sem_p(&sem, TM_INFINITE);
   	printf("task %d start...\n", taskID);

	rt_task_slice(NULL, rt_timer_ns2ticks(PERIOD));
	rt_task_set_mode(0, T_RRB, 0);

	start_date = rt_timer_read();
	my_sleep(1);
	end_date = rt_timer_read();

	printf("task %d end (%u sec)\n", taskID, tick_delta(start_date, end_date));
}

int main(void)
{
	int rc;
	int i;
	RTIME tv1, tv2;

	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	rc = rt_timer_set_mode(1 * MSEC);
	if (rc != 0)
	{
		printf("failed to rt_timer_set_mode: %d\n", rc);
		return rc;
	}

	rt_sem_create(&sem, "sem", 0, S_FIFO);
	
	for (i = 0; i < NBTASK; i++)
	{
		char szTaskID[20];
		sprintf(szTaskID, "Task%02d", i);
		rt_task_create(&tasks[i],
				szTaskID,
				4096,
				99,
				T_JOINABLE);
	}

	tv1 = rt_timer_read();

	for (i = 0; i < NBTASK; i++)
	{
	   	RT_TASK_INFO info;
	
		rt_task_start(&tasks[i], &task, (void *)(long)i);
	}	
	
	rt_sem_broadcast(&sem);

	for (i = 0; i < NBTASK; i++)
	{
    		rt_task_join(&tasks[i]);
    	}

	tv2 = rt_timer_read();

	printf("****** total time: %u (sec)\n\n", tick_delta(tv1, tv2));

	rt_sem_delete(&sem);

	return 0;
}

-- 
Philippe.

