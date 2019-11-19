Subject: Re: rt_task_self() return value
References: <1574177353.6990.5.camel@smigroup.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4d3fa642-8ac7-cd92-20cb-e755627783ab@siemens.com>
Date: Tue, 19 Nov 2019 16:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <1574177353.6990.5.camel@smigroup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 19.11.19 16:29, Mauro Salvini via Xenomai wrote:
> Hi all,
> 
> I'm using Xenomai 3.0.9 in cobalt mode and I'm facing an issue on
> rt_task_self() returned value.
> 
> Please see this simple code:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <alchemy/task.h>
> 
> RT_TASK gNewTask;
> 
> static void Task(void *lpArgument)
> {
> 	rt_printf("Task created.\n");
> 	gNewTask = *(rt_task_self());

This fills the internal data structure RT_TASK with the content of 
another one. Rather than "cloning", did you try using a reference as the 
API suggests? If that worked in Xenomai 2, it was luck.

Jan

> }
> 
> int main()
> {
> 	RT_TASK tNewTask;
> 	int err = rt_task_create(&tNewTask, "TEST", 16384, 10,
> T_JOINABLE);
> 	rt_printf(" task create: %d\n", err);
> 	err = rt_task_start(&tNewTask, Task, NULL);
> 	rt_printf(" task start: %d\n", err);
> 	
> 	rt_task_sleep(2000000000);
> 
> 	//err = rt_task_join(&tNewTask);
> 	err = rt_task_join(&gNewTask);
> 	rt_printf(" task join : %d\n", err);
> 
> 	return 0;
> }
> 
> Code is compiled using xeno-config --alchemy.
> 
> Using the rt_task_self() returned value with rt_task_join(), the latter
> returns -ESRCH (no such process). Obviously if I use the local tNewTask
> variable, return value is 0.
> 
> I'm pretty sure that this works without errors with Xenomai2.
> 
> Is it the expected behavior with Xenomai3?
> 
> Thanks in advance, regards
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

