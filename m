Message-ID: <47B2FF58.9060002@domain.hid>
Date: Wed, 13 Feb 2008 15:31:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47B2B0D102000001001924EB@nwque-vm-gwia.criq.qc.ca>
In-Reply-To: <47B2B0D102000001001924EB@nwque-vm-gwia.criq.qc.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help]
 =?iso-8859-1?q?R=E9p=2E_=3A_Re=3A__R=E9p=2E_=3A_Re?=
 =?iso-8859-1?q?=3A__T=5FRRB?=
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
> Thanks for explanations. It's clearer now.
> 
> But...
> 
> In the following code (almost the same), there is one task that dies prematurely.
>

Use GDB to know why.

> 
> //******************************************************************************
> #include <stdio.h>
> 
> #include <sys/mman.h>
> 
> #include <native/task.h>
> 
> #include <native/timer.h>
> 
> #include <native/sem.h>
> 
> 
> #define NBTASK 1
> 
> #define NSEC 	1
> 
> #define USEC 	1000
> 
> #define MSEC 	1000000
> 
> #define SEC 	1000000000LL
> 
> #define PERIOD  (10 * MSEC)
> 
> RT_TASK tasks[NBTASK];
> 
> RT_SEM sem;
> 
> unsigned long counts[NBTASK];
> 
> 
> 
> static inline unsigned tick_delta(RTIME t0, RTIME t1)
> 
> {
> //	return ((unsigned)(t1 - t0) * PERIOD) / SEC;
> 
> 	return rt_timer_ticks2ns(t1 - t0) / SEC;
> 
> }
> 
> 
> 
> void my_sleep(int nSec, int taskID)
> 
> {
> 
> 	RTIME start_ticks, wait_ticks;
> 
> 	
> //	wait_ticks = (nSec * SEC) / PERIOD;
> 
> 	wait_ticks = nSec * rt_timer_ns2ticks(SEC);
> 
> 	start_ticks = rt_timer_read();
> 	
> 	while (rt_timer_read() - start_ticks <= wait_ticks)
> 	{
> 		counts[taskID]++;
> 	}
> 
> }
> 
> 
> 
> void task(void *arg)
> 
> {
> 
> 	int taskID = (int)(long)arg;
> 
> 	RTIME start_date, end_date;
> 
> 	RTIME start_ticks, wait_ticks;
> 
> 	
> 
> 	rt_task_slice(NULL, rt_timer_ns2ticks(PERIOD));
> 
> 	rt_task_set_mode(0, T_RRB, 0);
> 	
>    	printf("task %d start...\n", taskID);
> 
> 	rt_sem_p(&sem, TM_INFINITE);
> 
> 
> 
> 	start_date = rt_timer_read();
> 	my_sleep(5, taskID);
> 	end_date = rt_timer_read();
> 
> 
> 
> 	printf("task %d end (%u sec) --> %u\n", taskID, tick_delta(start_date, end_date), counts[taskID]);
> 
> }
> 
> 
> 
> int main(void)
> 
> {
> 
> 	int rc;
> 
> 	int i;
> 
> 	RTIME tv1, tv2;
> 
> 
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
> 	
> 	memset(counts, 0, NBTASK * sizeof(unsigned long));
> 
> 
> 	rc = rt_timer_set_mode(1 * MSEC);
> 
> 	if (rc != 0)
> 
> 	{
> 
> 		printf("failed to rt_timer_set_mode: %d\n", rc);
> 
> 		return rc;
> 
> 	}
> 	
> 	rt_sem_create(&sem, "sem", 0, S_FIFO);
> 
> 	
> 
> 	for (i = 0; i < NBTASK; i++)
> 
> 	{
> 
> 		char szTaskID[20];
> 
> 		sprintf(szTaskID, "Task%02d", i);
> 
> 		rt_task_create(&tasks[i],
> 
> 				szTaskID,
> 
> 				4096,
> 
> 				99,
> 
> 				T_JOINABLE);
> 
> 	}
> 
> 
> 
> 	tv1 = rt_timer_read();
> 
> 
> 	for (i = 0; i < NBTASK; i++)
> 
> 	{
> 
> 	   	RT_TASK_INFO info;
> 
> 	
> 
> 		rt_task_start(&tasks[i], &task, (void *)(long)i);
> 
> 	}	
> 
> 	
> 	rt_sem_broadcast(&sem);
> 
> 
> 
> 	for (i = 0; i < NBTASK; i++)
> 
> 	{
> 
>    		rt_task_join(&tasks[i]);
> 
> 		printf("task %d count = %u\n", i, counts[i]);
> 
>    	}
> 
> 	tv2 = rt_timer_read();
> 
> 	printf("****** total time: %u (sec)\n\n", tick_delta(tv1, tv2));
> 
> 
> 	rt_sem_delete(&sem);
> 	
> /*
> 	tv1 = rt_timer_read();
> 
> 
> 	my_sleep(10, 9);
> 
> 	tv2 = rt_timer_read();
> 
> 	printf("****** total time: %u (sec)\n\n", tick_delta(tv1, tv2));
> 
> */
> 
> 	return 0;
> 
> }
> 
> //******************************************************************************
> 
> 
> With...
> 
> #define NBTASK 5
> ------------------------
> 
> 
> output is (task 2 died prematurely):
> 
> task 0 start...
> task 1 start...
> task 2 start...
> task 3 start...
> task 4 start...
> task 0 end (5 sec) --> 4452399
> task 1 end (5 sec) --> 4456435
> task 3 end (5 sec) --> 4497016
> task 4 end (5 sec) --> 4513423
> task 0 count = 4452399
> task 1 count = 4456435
> task 2 count = 2687455
> task 3 count = 4497016
> task 4 count = 4513423
> ****** total time: 5 (sec)
> 
> #define NBTASK 3
> ------------------------
> 
> 
> output is (task 2 died prematurely):
> 
> task 0 start...
> task 1 start...
> task 2 start...
> task 0 end (5 sec) --> 8130524
> task 1 end (5 sec) --> 8140688
> task 0 count = 8130524
> task 1 count = 8140688
> task 2 count = 4211880
> ****** total time: 5 (sec)
> 
> #define NBTASK 1
> ------------------------
> 
> 
> output is (task 0 died prematurely):
> 
> task 0 start...
> task 0 count = 14200778
> ****** total time: 3 (sec)
> 
> 
> I think it's abnormal. Isn't it?
> 
> 
> Thanks
> 
> Hubert
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

