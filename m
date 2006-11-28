Message-Id: <s56c6ea0.008@domain.hid>
Date: Tue, 28 Nov 2006 17:15:14 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: [Xenomai-help] Switch mode with x86
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

Hi ! 

I'm newbie in xenomai world,
I've write an application which make a lot of switch mode
(Primary->secondary ...)
and sometime tasks are block in secondary mode (/proc/xenomai/sched ->
stat X).
(no watchod message in dmesg, it's block in secondary mode).

I use xenomai 2.2.5, adeos 1.5.02 (same probleme with 2.2.3 et adeos
1.4)
It' run on x86 (486 vortex 166Mhz).
So, i've write an litle example that failed.  It failed on my x86 (in
less than 2 minutes),
but this example run corectly with a pentium 4 or an Amd processor :

#include <sys/mman.h>
#include <stdio.h>
#include <signal.h>
#include <native/task.h>
#include <string.h>

static int iStop = 0;
RT_TASK Task_1, Task_2;
//----------------------------------------------------------------------THREAD
1
void thread_1(void *arg)
{
	while(1)
	{
		unsigned long overruns;
		int iErr;

		iErr = rt_task_wait_period(&overruns);
		if (iErr || overruns)
			printf("Echec wait_period task_1 err %d,
overruns: %lu\n",iErr,overruns);

		//iErr = rt_task_set_mode(T_PRIMARY, 0, NULL);
		if(iErr)
			printf("Echec set_mod Secondary task_1\n");
printf("r\n");
		if(iStop == 1)
		{
			iErr = rt_task_delete(&Task_1);
			if (iErr ) 
				printf("Echec delete task_1 err %d\n",
iErr);
			break;
		}
	}
}
//----------------------------------------------------------------------THREAD
2
void thread_2(void *arg)
{
	while(1)
	{
		unsigned long overruns;
		int iErr;

		iErr = rt_task_wait_period(&overruns);
		if (iErr || overruns)
			printf("Echec wait_period task_2 err %d,
overruns: %lu\n",iErr,overruns);

		//iErr = rt_task_set_mode(T_PRIMARY, 0, NULL);
		if(iErr)
			printf("Echec set_mod Secondary task_2\n");
printf("u\n");

		if(iStop == 1)
		{
			iErr = rt_task_delete(&Task_2);
			if (iErr ) 
				printf("Echec delete task_2 %d\n",
iErr);
			break;
		}
	}
}
//----------------------------------------------------------------------CLEANUP
UPON SIG
void cleanup_upon_sig(int sig)
{
	iStop = 1;
}
//----------------------------------------------------------------------MAIN
int main(int argc, char *argv[]) 
{
	sigset_t mask, oldmask;
	int iErr;

	mlockall(MCL_CURRENT | MCL_FUTURE);

	sigemptyset(&mask);
	sigaddset(&mask, SIGINT);
	signal(SIGINT, cleanup_upon_sig);
	sigaddset(&mask, SIGTERM);
	signal(SIGTERM, cleanup_upon_sig);
	sigaddset(&mask, SIGHUP);
	signal(SIGHUP, cleanup_upon_sig);

	pthread_sigmask(SIG_BLOCK, &mask, &oldmask);

		// Task 1 *******************************
	iErr = rt_task_create(&Task_1,"TASK1", 0, 99, 0);
	if(iErr)
		printf("Echec create Task_1
%d\n",iErr);			
	iErr = rt_task_set_periodic(
&Task_1,rt_timer_read()+100*1000000llu,rt_timer_ns2ticks(10*1000000llu)
); //period 10 ms
	if(iErr)
		printf("Echec set_periodic Task_1 %d\n",iErr);
	iErr = rt_task_start(&Task_1,(void *)thread_1,NULL);
	if(iErr)
		printf("Echec start Task_1 %d\n", iErr);

		// Task 2 ******************************
	iErr = rt_task_create(&Task_2,"TASK2", 0, 0, 0);
	if(iErr)
		printf("Echec create task_2
%d\n",iErr);			
	iErr = rt_task_set_periodic(
&Task_2,rt_timer_read()+100*1000000llu,rt_timer_ns2ticks(11*1000000llu)
); //period 11 ms
	if(iErr)
		printf("Echec set_periodic task_2 %d\n", iErr);
	iErr = rt_task_start(&Task_2,(void *)thread_2,NULL);
	if(iErr)
		printf("Echec start task_2 %d\n", iErr);

	sigsuspend(&oldmask);
	return 0;
}

If thoses two task have the same priority it looks to not failed,
perhaps a problem
with the scheduler in secondary mode when two task comes from primary
mode ?
Is it a know probleme with x86 ?
Or perhaps a big error in my example ...

Have you an idea ? 
thanks in advance

nicolas blanchard



