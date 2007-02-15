Message-ID: <45D431CF.5090201@domain.hid>
Date: Thu, 15 Feb 2007 11:11:27 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>	<45D0666C.8070409@domain.hid>	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>	<45D171F9.7000705@domain.hid>	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>	<45D192EB.9030608@domain.hid>	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>	<45D2CE22.5010105@domain.hid>	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>	<45D421EA.5070507@domain.hid>
	<e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>
In-Reply-To: <e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Preetam Joshi <j.preetam@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Preetam Joshi wrote:
> ok,
> 
> here is the code.
> The code essentially cerates two tasks low and high priority task.
> The low priority task has priority as 3 and high as 98
> 
> When i execute this initally everything goes smoothly as low priority task
> starts running with priority thread 3 , it sleeps so then the high priority
> thread runs with priority 98. But before the high priority thread finishes
> the for loop for 7 times the low priority thread prempts it and starts
> running with priority = 98.
Nope, you just don't read the state (using a global is also a bad idea).

> 
> This is what has baffled me?
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/timer.h>
> 
> RT_TASK task1;
> RT_TASK task2;
> RT_TASK_INFO info;
> 
> void low_task(void *arg)
> {
          RT_TASK_INFO info;
>        rt_task_inquire(&task1, &info);
>        printf("Priority of low task %d\n", info.cprio);
> 
>        rt_task_sleep(3000000000);
> 
>       while(1)
>        {
                  rt_task_inquire(&task1, &info);
>                printf("Priority of Low task %d\n",info.cprio);
>        }
> 
> }
> 
> void high_task(void *arg)
> {
>        unsigned int i;
>        rt_task_inquire(&task2, &info);
>        printf("Priority of high task before sleep %d\n", info.cprio);
>        for(i=0;i<7;i++)
>        {
> 
>                printf("Priority of High Priotity task1 %d\n",info.cprio);
>                rt_task_sleep(1000000000);
>        }
> 
>        printf("High priority thread goin to sleep %d\n",info.cprio);
>        rt_task_sleep(3000000000);
> 
>        for(i=0;i<100;i++)
>        {
>                printf("Priority of High task2 %d\n",info.cprio);
>        }
> 
>       int main(int argc, char* argv[])
> {
>        mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>        rt_task_create(&task1, "Low Priority Task", 0, 3, 0);
>        rt_task_create(&task2, "High Priority Task", 0, 98, 0);
> 
>        rt_task_start(&task1, &low_task, NULL);
>        rt_task_start(&task2, &high_task, NULL);
> 
>        pause();
> 
>        rt_task_join(&task1);
>        rt_task_join(&task2);
> 
> }
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> On 2/15/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> Preetam Joshi wrote:
>> > Hi,
>> >
>> > Do u mean to say that if i have created my tasks using native xenomai
>> API's
>> > like rt_task_create , then inside those tasks i will have to use posix
>> skin
>> > calls like pthread_setschedpolicy, etc...?
>> >
>> > Is that so.
>>
>> Nope. If you picked the native skin API, all scheduler setup for a RT
>> task should be done through that interface.
>>
>> >
>> > Cant i just have context switch between the tasks themselves say low
>> > priority and a high priority task created by rt_task_create.
>> >
>> > Reason being i have created two tasks using the rt_task_create API and
>> my
>> > high priority task is runnning and my low priority task has slept, 
>> so as
>> > soon as my low priority task has expired its sleep time and gets ready
>> to
>> > run,
>> >
>> > The low priority task preempts my high priority task and even its
>> priority
>> > gets raised to that of the high priority task and starts executing. The
>> > higgh priority task gets suspended altogether amidst its running. 
>> Simply
>> > baffled by the behavior?
>>
>> If you have found a weird behaviour of Xenomai, please post some
>> as-small-as-possible demo code that exposes the issue. We will have a
>> look at it.
>>
Regards

Anders

