Subject: Re: rt_task_self() return value
References: <1574177353.6990.5.camel@smigroup.net>
 <4d3fa642-8ac7-cd92-20cb-e755627783ab@siemens.com>
 <1574179267.6990.8.camel@smigroup.net>
 <99edf64f-e885-5c16-7852-10d3379c8483@siemens.com>
 <1574181029.6990.11.camel@smigroup.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5738d153-d1b5-fe83-e796-f7922b836899@siemens.com>
Date: Tue, 19 Nov 2019 17:33:25 +0100
MIME-Version: 1.0
In-Reply-To: <1574181029.6990.11.camel@smigroup.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 19.11.19 17:30, Mauro Salvini wrote:
> On Tue, 2019-11-19 at 17:05 +0100, Jan Kiszka wrote:
>> On 19.11.19 17:01, Mauro Salvini wrote:
>>> On Tue, 2019-11-19 at 16:41 +0100, Jan Kiszka wrote:
>>>> On 19.11.19 16:29, Mauro Salvini via Xenomai wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm using Xenomai 3.0.9 in cobalt mode and I'm facing an issue
>>>>> on
>>>>> rt_task_self() returned value.
>>>>>
>>>>> Please see this simple code:
>>>>>
>>>>> #include <stdio.h>
>>>>> #include <stdlib.h>
>>>>> #include <unistd.h>
>>>>> #include <alchemy/task.h>
>>>>>
>>>>> RT_TASK gNewTask;
>>>>>
>>>>> static void Task(void *lpArgument)
>>>>> {
>>>>> 	rt_printf("Task created.\n");
>>>>> 	gNewTask = *(rt_task_self());
>>>>
>>>> This fills the internal data structure RT_TASK with the content
>>>> of
>>>> another one. Rather than "cloning", did you try using a reference
>>>> as
>>>> the
>>>> API suggests? If that worked in Xenomai 2, it was luck.
>>>>
>>>
>>> Hi Jan,
>>>
>>> thanks for your answer.
>>> Yes, I tried it and even does not work. Changing code in this way:
>>>
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <unistd.h>
>>> #include <alchemy/task.h>
>>>
>>> RT_TASK* gNewTask;
>>>
>>> static void Task(void *lpArgument)
>>> {
>>>           rt_printf("Task created.\n");
>>>           gNewTask = rt_task_self();
>>> }
>>>
>>> int main()
>>> {
>>>           RT_TASK tNewTask;
>>>           int err = rt_task_create(&tNewTask, "TEST", 16384, 10,
>>> T_JOINABLE);
>>>           rt_printf(" task create: %d\n", err);
>>>           err = rt_task_start(&tNewTask, Task, NULL);
>>>           rt_printf(" task start: %d\n", err);
>>>           
>>>           rt_task_sleep(2000000000);
>>>
>>>           //err = rt_task_join(&tNewTask);
>>>           err = rt_task_join(gNewTask);
>>>           rt_printf(" task join : %d\n", err);
>>>
>>>           return 0;
>>> }
>>>
>>> returns:
>>>
>>> ./test
>>>    task create: 0
>>> Task created.
>>>    task start: 0
>>>    task join : -3
>>>
>>
>> OK, then we have a regression. Let me check...
>>
>> Jan
>>
> 
> Thank you Jan for the patch.

BTW, I only tested the pointer case, but copying the content of RT_TASK 
should actually work as well.

Thanks for reporting!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

