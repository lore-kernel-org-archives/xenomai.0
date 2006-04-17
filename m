Message-ID: <4443AB1F.2060405@domain.hid>
Date: Mon, 17 Apr 2006 16:50:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
	<4443992C.5000808@domain.hid>
In-Reply-To: <4443992C.5000808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "Brian L." <bluczkie@domain.hid>

Jan Kiszka wrote:
> Brian L. wrote:
> 
>>If I create a native-skin RT_TASK from userspace with no flags, i.e.
>>
>>void task(void*)
>>{
>>    for (;;) ;
>>}
>>int main()
>>{
>>   RT_TASK t;
>>   rt_task_create(&t, 0, 3, 0);
>>   rt_task_start(&t,task,0);
>>   (do something which blocks)
>>}
> 
> 
> mlockall left out for simplicity? Or is it also missing on your real
> test? In the latter case, occasional application crashes are "normal"
> (as described below).
> 
> Philippe, you suggested some code for detecting this. We should really,
> really add this soon (maybe to the exception path)!
> 

The submitted patch works pretty well detecting unlocked memory, I'm 
using it right now, but I'd like something a bit more self-explanatory 
than just receiving SIGXCPU. I don't think the execption path is the 
right place to put this, since the mlockall issue causes random bugs, 
and you likely want to detect them early and unconditionally.

> 
>>Should that task starve all other tasks? In what ways is it different
>>behaviorally from an ordinary posix thread? I ask because I have a
>>thread that might be spinning and a frozen system (back in the rtlinux
>>days, spinning in the real-time domain was a surefire way to freeze
>>without any other sign of trouble). If it is the case that this task
>>outweighs an ordinary linux thread/task, how can I make it the same?
> 
> 
> A task that has high priority than other system tasks has to outweigh
> them. This has nothing to to with POSIX (standard Linux included!),
> RTLinux, Xenomai, or whatever. But Xenomai has a simple watchdog to
> recover from run-away RT threads.
> 
> 
>>Also,  I haven't completely tracked this down yet, but xenomai seems
>>to be page-faulting in a loop and exploding rather spectacularly in a
>>native-skin multithreaded program that doesn't do anything outside of
>>relatively ordinary queue/mutex/task stuff. I'm upgrading to trunk to
>>see if it goes away.
>>
>>Short of a serial cable, is there a way to capture Oops/Panic text as
>>it flies by?
> 
> 
> linux/Documentation/networking/netconsole.txt is another option.
> 
> Jan
> 


-- 

Philippe.

