Message-ID: <44427A4A.9050208@domain.hid>
Date: Sun, 16 Apr 2006 19:09:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG?] stalled xeno domain
References: <4437D2EE.4040902@domain.hid>
	<4437E704.4010607@domain.hid>	<443A437B.6010403@domain.hid>
	<443A5212.7020001@domain.hid> <443A56E2.1010204@domain.hid>
	<443A5D7B.2040707@domain.hid> <443A9410.50402@domain.hid>
In-Reply-To: <443A9410.50402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>>>Philippe, do you see any remaining issues, e.g. that the leak survived
>>>>>the task termination? Does this have any meaning for correct driver and
>>>>>skin code?
>>>>>
>>>>
>>>>The only way I could see this leakage survive a switch transition would
>>>>require it to happen over the root context, not over a primary context.
>>>>Was it the case?
>>>>
>>>
>>>
>>>The task had to leave from primary mode. If I forced it to secondary
>>>before terminating, the problem did not show up.
>>>
>>
>>But does the code causing the leakage could have been run by different
>>contexts in sequence, including the root one?
>>
> 
> 
> I don't think so. Bugs in our software aside, there should be no switch
> to secondary mode until termination. Moreover, we installed a SIGXCPU
> handler, and that one didn't trigger as well.
> 
> 
> I just constructed a simple test by placing rthal_local_irq_disable() in
> rt_timer_spin and setting up this user space app:
> 
> #include <stdio.h>
> #include <signal.h>
> #include <native/task.h>
> #include <native/timer.h>
> 
> RT_TASK task;
> 
> void func(void *arg)
> {
>     rt_timer_spin(0);
> }
> 
> 
> void terminate(int sig)
> {
>     printf("joining...\n");
>     rt_task_join(&task);
>     rt_task_delete(&task);
>     printf("done\n");
> }
> 
> 
> int main()
> {
>     signal(SIGINT, terminate);
>     rt_task_spawn(&task, "lockup", 0, 10, T_FPU | T_JOINABLE | T_WARNSW,
>                   func, NULL);
>     pause();
>     return 0;
> }
> 
> 
> Should this lock up (as it currently does) or rather continue to run
> normally after the RT-task terminated? BTW, I'm still not sure if we are
> hunting shadows (is IRQs off a legal state for user space in some skin?)
> or a real problem - i.e. is it worth the time.
> 

I've just tested this frag against the current SVN head, patching 
rt_timer_spin() as required, and cannot reproduce the lockup. As 
expected, the incoming root thread reinstates the correct stall bit 
(i.e. clears it) after the RT thread terminates. Any chance some 
potentially troublesome stuff exists in your setup?

-- 

Philippe.

