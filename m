Message-Id: <s56c97a4.095@domain.hid>
Date: Tue, 28 Nov 2006 20:09:37 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: =?ISO-8859-1?Q?R=E9p.=20:=20Re:=20[Xenomai-help]=20Switch=20mode?=
	=?ISO-8859-1?Q?=20with=20x86?=
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

>>>> Jan Kiszka <jan.kiszka@domain.hid> 28/11/06 19:02 >>>
>Nicolas BLANCHARD wrote:
>> Hi ! 
>> 
>> I'm newbie in xenomai world,
>> I've write an application which make a lot of switch mode
>> (Primary->secondary ...)
>> and sometime tasks are block in secondary mode (/proc/xenomai/sched
->
>> stat X).
>> (no watchod message in dmesg, it's block in secondary mode).
>> 
>> I use xenomai 2.2.5, adeos 1.5.02 (same probleme with 2.2.3 et adeos
>> 1.4)
>> It' run on x86 (486 vortex 166Mhz).
>> So, i've write an litle example that failed.  It failed on my x86 (in
>> less than 2 minutes),
>> but this example run corectly with a pentium 4 or an Amd processor :
>
>How does it fail precisely? Which tasks are stuck? Attach
>/proc/xenomai/sched output e.g. Already tried to attach gdb to that
>process after the lock-up?

I've no "crash", Tasks are blocked :

/proc/xenomai/stat -> state of TASK_1 (Hight priority) : X
                   -> state of TASK_2 (Low priority) : R or sometime X
/proc/xenomai/sched -> period of TASK_1 always 0, CPU 0%
                    -> period of TASK_2 always 0, CPU 0%

In my original program, all others tasks which don't switch to secondary
mode
are still alive and runs correctly ...

I've tested gdb, nothing special, it's like if it was normal,
But block tasks seems to be in a infinite sleep under secondary mode.

>
>
>One difference of vortex vs. P4 might be (besides speed) that for the
>former Xenomai uses TSC emulation, for the latter the CPU already comes
>with this support. You can force the high-end systems into that mode by
>compiling the kernel with CONFIG_M586. Or did you use the same kernel
>images on all systems?
>

No, kernel are not similar(both xenomai 2.2.5 + adeos 1.5-02 + linux
2.6.17.13),
   ->Pentium 4 under windowsXP with Vmware worstation vm ubuntu,
different kernel config
     for run with Vmware, it's run fine.
     In xenomai options there is nothing different.

I will try CONFIG_M586 (actually 486)

>Your .config would be interesting. You can already check if
>CONFIG_INPUT_PCSPKR is set. Must be off for TSC emulation (Xenomai 2.2
>doesn't check for this conflict, 2.3 will do so).
>>

Ok
(With Xenomai configure script i've passed options : disable-x86-tsc and
disable-x86-sep)

>> 
>> #include <sys/mman.h>
>> #include <stdio.h>
>> #include <signal.h>
>> #include <native/task.h>
>> #include <string.h>
>> 
>> static int iStop = 0;
>> RT_TASK Task_1, Task_2;
>>
//----------------------------------------------------------------------THREAD
>> 1
>> void thread_1(void *arg)
>> {
>> 	while(1)
>> 	{
>> 		unsigned long overruns;
>> 		int iErr;
>> 
>> 		iErr = rt_task_wait_period(&overruns);
>> 		if (iErr || overruns)
>> 			printf("Echec wait_period task_1 err %d,
>> overruns: %lu\n",iErr,overruns);
>
>
>Would have been better to attach the program instead of inlining it. :)
>
>> 
>> 		//iErr = rt_task_set_mode(T_PRIMARY, 0, NULL);
>> 		if(iErr)
>> 			printf("Echec set_mod Secondary task_1\n");
>> printf("r\n");
>> 		if(iStop == 1)
>> 		{
>> 			iErr = rt_task_delete(&Task_1);
>> 			if (iErr ) 
>> 				printf("Echec delete task_1 err %d\n",
>> iErr);
>> 			break;
>> 		}
>> 	}
>
>There is no mode switch in this thread and the second one. Is this not
>required to cause the lock-up???
>
>...

There is a switch with printf, if you comment this line and uncomment
rt_task_set_mode line the probleme is the same.


>> 
>> If thoses two task have the same priority it looks to not failed,
>> perhaps a problem
>> with the scheduler in secondary mode when two task comes from primary
>> mode ?
>> Is it a know probleme with x86 ?
>
>
>Nope. Fairly unusual. Does the switchtest from the Xenomai test-suite
>fail as well?
>

Nothing failed with xenomai 2.2.5 (FPU problem with switchtest and
xenomai 2.2.3) 


>> Or perhaps a big error in my example ...
>
>Nothing I can see.
>
>> 
>>Have you an idea ? 
>> thanks in advance
>> 
>> nicolas blanchard
>> 
>
>Jan
>

I will post /proc/xenomai/stat and sched and attach the example program
tomorrow.

thanks
nicolas blanchard



