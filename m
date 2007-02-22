Message-ID: <bc4264770702220523r6af8f8at6d709a0e9079bd6c@domain.hid>
Date: Thu, 22 Feb 2007 13:23:09 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Hello world with questions
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

Hi,

I have copy-pasted the trivial app into the body of this mail. To
understand what is
going on I have sprinkled and garnished it with questions.


[These are standard headers I presume]
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>


[These are xenomai headers. What libraries must be linked in with them?]
#include <native/task.h>
#include <native/timer.h>

[I see this macro is called later as an argument. What is its function?]
RT_TASK demo_task;

/* NOTE: error handling omitted. */

void demo(void *arg)
{

       	RTIME now, previous;

	/*
	 * Arguments: &task (NULL=self),
	 *            start time,
	 *            period (here: 1 s)
	 */
	rt_task_set_periodic(NULL, TM_NOW, 1000000000);

	previous = rt_timer_read();

	while (1) {
		rt_task_wait_period(NULL);
		now = rt_timer_read();

		/*
		 * NOTE: printf may have unexpected impact on the timing of
		 *       your program. It is used here in the critical loop
		 *       only for demonstration purposes.
		 */
		printf("Time since last turn: %ld.%06ld ms\n",
		       (long)(now - previous) / 1000000,
		       (long)(now - previous) % 1000000);
		       previous = now;
	}
}


[The purpose of this function eludes me ?]
void catch_signal(int sig)
{
}

int main(int argc, char* argv[])
{

[What is happening here?]
	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);

[Does this mean I cannot access global variables if this program is
running in a thread? That would be a disastrous limitation!]
	/* Avoids memory swapping for this program */
	mlockall(MCL_CURRENT|MCL_FUTURE);

	/*
	 * Arguments: &task,
	 *            name,
	 *            stack size (0=default),
	 *            priority,
	 *            mode (FPU, start suspended, ...)
	 */
[I presume this sets the function "demo" as a real-time task?]
	rt_task_create(&demo_task, "trivial", 0, 99, 0);

	/*
	 * Arguments: &task,
	 *            task function,
	 *            function argument
	 */
	rt_task_start(&demo_task, &demo, NULL);
[Is RTASK a task label? What happens if there are more than 1 task to
run in separate threads?]

[How is the loop broken to get to this part of the program?]
	pause();

	rt_task_delete(&demo_task);
}


Kindly,

Roland.

