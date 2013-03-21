Message-ID: <514B754C.4080800@yahoo.com>
Date: Thu, 21 Mar 2013 16:02:04 -0500
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] questions regarding context switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have a user-space program that spawns 8 periodic RT_TASKs for 
execution. Each RT_TASK's code is very simple: it just loops for 10 
periods during each of which rt_timer_spin is called to consume some 
CPU. The periods of these RT_TASKs vary from 150 ms to 1 s, and during 
each of their periods, the RT_TASKs consume CPU for from 20 ms to 100 
ms, At the end of the program, I read rt_task_info::ctxswitches 
<http://www.xenomai.org/documentation/xenomai-2.6/html/api/structrt__task__info.html#a8d72c536900a743d462c8566ec28cab8> 
of one RT_TASK, and got 12, which means, if I understand it correctly, 
this task has 12 context switches during the program's execution. (The 
number of context switches of an RT_TASK should vary during each run of 
the program, but since my program is running only for a very short time, 
and only 8 RT_TASKs are running, this number should not vary much each 
time, and actually I got 12 each time I ran my program )

Now in addition to the execution of the above 8 RT_TASKs, I did an extra 
thing: I create a kernel module that setup a periodic RT_ALARM with a 
period of 250 us. This RT_ALARM starts immediately after the kernel 
module is loaded.The handler of this RT_ALARM simply increases a global 
counter by 1, so it gives the number of ALARM shots (expires).  Then I 
run the above user-space program again with the RT_ALARM being active, 
and after it finishes, I find that while the RT_ALARM has thousands of 
shots, the number of context switches ( rt_task_info::ctxswitches 
<http://www.xenomai.org/documentation/xenomai-2.6/html/api/structrt__task__info.html#a8d72c536900a743d462c8566ec28cab8>) 
of the task mentioned above is still 12. Here is what I don't 
understand: when an RT_ALARM expires and executes a handler, shouldn't 
there be a context switch if an RT_TASK is running? The task mentioned 
above executes rt_timer_spin for 100ms during each period, and the 
highest priority among all the 8 tasks, so while it is executing, the 
RT_ALARM must expire for many times -- but why does it NOT increase the 
number of the tasks' context switches?

Thanks,
Tom
