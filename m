Message-ID: <52D505B8.70907@xenomai.org>
Date: Tue, 14 Jan 2014 10:39:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteBOh9yTRsWSBxpO+orgwLztR+i_2YiZ4UaM4bVYSTMWg@mail.gmail.com>
In-Reply-To: <CAKKWdteBOh9yTRsWSBxpO+orgwLztR+i_2YiZ4UaM4bVYSTMWg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai test for rt_task_suspend() and
	rt_task_resume()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai <xenomai@xenomai.org>

On 01/14/2014 07:57 AM, ali hagigat wrote:
> I am using kernel-3.5.7 with xenomai-2.6.3.
> I think the scheduler should schedule task1 and task2(for 3 times
> alltogether) and then both tasks should be suspended

You overlooked the fact that both tasks have equal priority. With the 
SCHED_FIFO policy, task2 resuming task1 does not mean that task1 will 
preempt task2 immediately upon rt_task_resume(), this will happen only 
when task2 suspends itself upon rt_task_suspend(), and conversely.

So what happens is that both tasks enter a run-away state by waking up 
each other indefinitely, with task2 saturating the kernel log with 
printk output. This probably ends when the oldest one (task1) is kicked 
out by the watchdog.

  but as it has
> been indicated in output.txt , there are many "inside task2..."
> messages (part of them were copied to the file) and then sudenly task1
> is killed!!
> Xenomai function seems incorrect(though i may have ignored some facts
> as usual, i apologize in advance)

No need to apologize, giving explanations and fixing bugs is part of our 
self-inflicted job (the other major part is to actually _implement_ 
those bugs).

However, you can help too in this Sisyphean process by submitting 
detailed, accurate and consistent information, e.g.

> Jan 14 09:58:47 localhost kernel: inside task2...
> Jan 14 09:58:47 localhost kernel: inside task2...
> Jan 14 09:58:47 localhost kernel: Clocksource tsc unstable (delta = 3922090473 ns)
> Jan 14 09:58:47 localhost kernel: Switching to clocksource jiffies
>

According to your report, I would have expected a message like "watchdog 
triggered -- killing runaway thread 'KTask1'" appearing in the log. If 
so, then you should definitely paste it in your description, it's quite 
important.

>
>
> cat /proc/xenomai/sched
> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>    0  0      idle    -1      -         master     R          ROOT/0
>    1  0      idle    -1      -         master     R          ROOT/1
>    2  0      idle    -1      -         master     R          ROOT/2
>    3  0      idle    -1      -         master     R          ROOT/3
>    0  0      rt      50      -         master     Sf         KTask1
>

KTask1 is suspended and KTask2 is gone in this status report, this does 
not match the behavior you described.

Sidenotes:

- you are using the native Xenomai 2.x API in kernel space, which is 
obsolete, and was already phased out from the upcoming Xenomai 3.x 
specs. If you really need kernel-based support, make it a RTDM driver, 
and move the application level code to userland, issuing requests to 
this driver.

- please, do __check__ the return codes of __any__ API call you happen 
to use in your code, particularly in kernel space context, especially 
when something looks wrong to you in the behavior you observe. This 
helps ruling out common issues, focusing on the real problem.

-- 
Philippe.

