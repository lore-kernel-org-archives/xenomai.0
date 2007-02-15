Subject: Re: [Xenomai-help] Make error
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <e45fe62b0702150216y6f6f98cdydfb4bab685f2478d@domain.hid>
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<45D171F9.7000705@domain.hid>
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
	<45D192EB.9030608@domain.hid>
	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>
	<45D2CE22.5010105@domain.hid>
	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
	<45D421EA.5070507@domain.hid>
	<e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>
	<45D431CF.5090201@domain.hid>
	<e45fe62b0702150216y6f6f98cdydfb4bab685f2478d@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 13:00:10 +0100
Message-Id: <1171540811.11100.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Preetam Joshi <j.preetam@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2007-02-15 at 15:46 +0530, Preetam Joshi wrote:
> Hi using it inside the task loop wwud give me RT_TASK_info as
> undeclared its a global structure even as mentioned in the API
> documentation

This is stated nowhere in the doc. Please read again.

>  and the behavior wud neways still remain the same as i mentioned in
> the code?
> 

Of course not, that's why Anders showed you the way.

> Please execute the code and comment.

Your code does not compile properly. There's a missing brace to close
the high priority task's body to start with. Additionally, 3000000000
only starts to be an implicitely unsigned value with the ISO C90
standard, so adding the 'ULL' qualifier would be a nice hint given to
the compiler that you really now what your are doing here.

Now, aside of those basic issues, the trivial one that bugs you is that:

1) the low priority task starts first, sets "info", then sleeps
2) the high priority task starts next while the low one is aslept,
overwrites "info", then sleeps,
3) which in turn causes the low priority task to print out the
overwritten value indefinitely after wakeup, which relates to the high
priority one, because it does this without ever reloading this variable
with its own priority information.

Please read your code again, make the "info" variable a local one for
both threads, then post anew if anything remains unclear.

> 
> Thanks.
> 
> On 2/15/07, Anders Blomdell <anders.blomdell@domain.hid> wrote:
>         Preetam Joshi wrote:
>         > ok,
>         >
>         > here is the code.
>         > The code essentially cerates two tasks low and high priority
>         task.
>         > The low priority task has priority as 3 and high as 98
>         >
>         > When i execute this initally everything goes smoothly as low
>         priority task 
>         > starts running with priority thread 3 , it sleeps so then
>         the high priority
>         > thread runs with priority 98. But before the high priority
>         thread finishes
>         > the for loop for 7 times the low priority thread prempts it
>         and starts 
>         > running with priority = 98.
>         Nope, you just don't read the state (using a global is also a
>         bad idea).
>         
>         >
>         > This is what has baffled me?
>         >
>         > #include <stdio.h>
>         > #include < unistd.h>
>         > #include <sys/mman.h>
>         > #include <native/task.h>
>         > #include <native/timer.h>
>         >
>         > RT_TASK task1;
>         > RT_TASK task2;
>         > RT_TASK_INFO info;
>         >
>         > void low_task(void *arg) 
>         > {
>                   RT_TASK_INFO info;
>         >        rt_task_inquire(&task1, &info);
>         >        printf("Priority of low task %d\n", info.cprio);
>         >
>         >        rt_task_sleep(3000000000); 
>         >
>         >       while(1)
>         >        {
>                           rt_task_inquire(&task1, &info);
>         >                printf("Priority of Low task %d
>         \n",info.cprio);
>         >        }
>         >
>         > } 
>         >
>         > void high_task(void *arg)
>         > {
>         >        unsigned int i;
>         >        rt_task_inquire(&task2, &info);
>         >        printf("Priority of high task before sleep %d\n",
>         info.cprio );
>         >        for(i=0;i<7;i++)
>         >        {
>         >
>         >                printf("Priority of High Priotity task1 %d
>         \n",info.cprio);
>         >                rt_task_sleep(1000000000);
>         >        } 
>         >
>         >        printf("High priority thread goin to sleep %d
>         \n",info.cprio);
>         >        rt_task_sleep(3000000000);
>         >
>         >        for(i=0;i<100;i++)
>         >        {
>         >                printf("Priority of High task2 %d\n",
>         info.cprio);
>         >        }
>         >
>         >       int main(int argc, char* argv[])
>         > {
>         >        mlockall(MCL_CURRENT|MCL_FUTURE);
>         >
>         >        rt_task_create(&task1, "Low Priority Task", 0, 3,
>         0); 
>         >        rt_task_create(&task2, "High Priority Task", 0, 98,
>         0);
>         >
>         >        rt_task_start(&task1, &low_task, NULL);
>         >        rt_task_start(&task2, &high_task, NULL);
>         >
>         >        pause();
>         >
>         >        rt_task_join(&task1);
>         >        rt_task_join(&task2);
>         >
>         > }
>         >
>         >
>         >
>         >
>         >
>         >
>         >
>         >
>         >
>         >
>         > 
>         >
>         >
>         > On 2/15/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>         >>
>         >> Preetam Joshi wrote:
>         >> > Hi,
>         >> >
>         >> > Do u mean to say that if i have created my tasks using
>         native xenomai 
>         >> API's
>         >> > like rt_task_create , then inside those tasks i will have
>         to use posix
>         >> skin
>         >> > calls like pthread_setschedpolicy, etc...?
>         >> >
>         >> > Is that so. 
>         >>
>         >> Nope. If you picked the native skin API, all scheduler
>         setup for a RT
>         >> task should be done through that interface.
>         >>
>         >> >
>         >> > Cant i just have context switch between the tasks
>         themselves say low 
>         >> > priority and a high priority task created by
>         rt_task_create.
>         >> >
>         >> > Reason being i have created two tasks using the
>         rt_task_create API and
>         >> my
>         >> > high priority task is runnning and my low priority task
>         has slept, 
>         >> so as
>         >> > soon as my low priority task has expired its sleep time
>         and gets ready
>         >> to
>         >> > run,
>         >> >
>         >> > The low priority task preempts my high priority task and
>         even its 
>         >> priority
>         >> > gets raised to that of the high priority task and starts
>         executing. The
>         >> > higgh priority task gets suspended altogether amidst its
>         running.
>         >> Simply
>         >> > baffled by the behavior? 
>         >>
>         >> If you have found a weird behaviour of Xenomai, please post
>         some
>         >> as-small-as-possible demo code that exposes the issue. We
>         will have a
>         >> look at it.
>         >>
>         Regards
>         
>         Anders
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



