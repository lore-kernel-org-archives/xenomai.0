Message-ID: <4F0B530A.80905@domain.hid>
Date: Mon, 9 Jan 2012 15:50:18 -0500
From: Makarand Pradhan <makarandpradhan@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030602050205020700030501"
Subject: [Xenomai-help] Issue with Auto relax and nested mutexes
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

--------------030602050205020700030501
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am running kernel 3.0.0, xenomai: 2.6, powerpc 8360.

I am noticing an issue while using the auto relax feature related to 
mutexes. I am using nested mutexes. The code is attached to this email.

The problem is that I am not relaxing after a RT thread grabs and 
releases a mutex. On further investigation, it was noted that the rescnt 
is not going down to 0. Another observation is that I do not hit 
rt_mutex_release in the kernel in the problem scenario, I believe when 
the thread undergoes a priority inversion. This may be a problem as the 
rescnt would not get decremented.  Not sure how the mutex is releasing 
wiithout hitting rt_mutex_relase or am I missing anything?

If I have both the tasks running at priority 0, I stay in the secondary 
domain, rt_mutex_release is invoked as expected, the rescnt goes down to 
0 when all the mutexes are released.

Has anyone faced this problem?

Rgds,
Makarand





-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


--------------030602050205020700030501
Content-Type: text/x-csrc; name="prio.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="prio.c"

#include <xenomai/asm-generic/bits/current.h>
#include <sys/syscall.h>
#include <sys/mman.h>
#include <stdio.h>
#include <native/task.h>
#include <native/mutex.h>
#include <nucleus/thread.h>
#include <rtdk.h>
#include <stdlib.h>
#include <unistd.h>

RT_TASK task0, task1, task2; 
RT_MUTEX mux1, mux2, mux3, mux4;
char buff[8192];

void task1_func(void *arg)
{
	RT_TASK_INFO info;
	int current_in_primary = 0;

	while(true)
	{
		rt_task_inquire(&task1, &info);
		current_in_primary = !(xeno_get_current_mode() & XNRELAX);
		rt_printf("bP: %i, cp: %i, mode: %i\n", 
			info.bprio, info.cprio, current_in_primary);
                rt_mutex_acquire(&mux1, TM_INFINITE);
                rt_mutex_acquire(&mux2, TM_INFINITE);
                rt_mutex_acquire(&mux3, TM_INFINITE);
		rt_printf("Acquire complete\n");

		rt_task_sleep(2222222222LL);
		rt_mutex_release(&mux3);
		rt_mutex_release(&mux2);
		rt_mutex_release(&mux1);
		rt_printf("Release complete\n");
	}
}

void task2_func(void *arg)
{
	int counter = 0;
	while(true)
	{
		if (2 == counter)
		{
			rt_printf("Grabbing mux in HP\n");
			rt_mutex_acquire(&mux1, TM_INFINITE);
			rt_mutex_acquire(&mux2, TM_INFINITE);
			rt_mutex_acquire(&mux3, TM_INFINITE);
			rt_printf("Mux held by Task2\n");
		}
		rt_mutex_acquire(&mux4, TM_INFINITE);
		rt_task_sleep(4444444444LL);
		if (2 == counter)
		{
			rt_mutex_release(&mux3);
			rt_mutex_release(&mux2);
			rt_mutex_release(&mux1);
		}
		rt_mutex_release(&mux4);
		counter++;
	}
}

int main(int argc, char **argv)
{
	int prio1, prio2;

	if (argc == 1)
	{
		printf("Pl enter prio1 prio1\n");
		exit (0);
	}

	prio1 = atoi(argv[1]);
	prio2 = atoi(argv[2]);

	mlockall(MCL_CURRENT|MCL_FUTURE);

	rt_print_auto_init(1);

	rt_task_shadow(&task0, "Task 0", 10, 0);

	rt_mutex_create(&mux1, "test_mux1");
	rt_mutex_create(&mux2, "test_mux2");
	rt_mutex_create(&mux3, "test_mux3");
	rt_mutex_create(&mux4, "test_mux4");

	printf("Spawning: tasks\n");
	rt_task_spawn(&task1, "TTTTTTTTTTT", 0, prio1, 0, task1_func, NULL);
	rt_task_spawn(&task2, "TASK2", 0, prio2, 0, task2_func, NULL);

	while (1) {
		rt_task_sleep(5000000LL);
	}
}

--------------030602050205020700030501--

