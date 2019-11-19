Message-ID: <1574177353.6990.5.camel@smigroup.net>
Subject: rt_task_self() return value
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Tue, 19 Nov 2019 16:29:13 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi all,

I'm using Xenomai 3.0.9 in cobalt mode and I'm facing an issue on
rt_task_self() returned value.

Please see this simple code:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alchemy/task.h>

RT_TASK gNewTask;

static void Task(void *lpArgument)
{
	rt_printf("Task created.\n");
	gNewTask = *(rt_task_self());
}

int main()
{
	RT_TASK tNewTask;
	int err = rt_task_create(&tNewTask, "TEST", 16384, 10,
T_JOINABLE);
	rt_printf(" task create: %d\n", err);
	err = rt_task_start(&tNewTask, Task, NULL);
	rt_printf(" task start: %d\n", err);
	
	rt_task_sleep(2000000000);

	//err = rt_task_join(&tNewTask);
	err = rt_task_join(&gNewTask);
	rt_printf(" task join : %d\n", err);

	return 0;
}

Code is compiled using xeno-config --alchemy.

Using the rt_task_self() returned value with rt_task_join(), the latter
returns -ESRCH (no such process). Obviously if I use the local tNewTask
variable, return value is 0.

I'm pretty sure that this works without errors with Xenomai2.

Is it the expected behavior with Xenomai3?

Thanks in advance, regards
-- 
Mauro

