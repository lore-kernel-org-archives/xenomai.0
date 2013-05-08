Message-ID: <518AB018.5010301@xenomai.org>
Date: Wed, 08 May 2013 22:05:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
	<5187F3AA.6040801@xenomai.org> <51880134.1000208@gmail.com>
	<5188059C.9030106@xenomai.org> <51881CC0.5060300@gmail.com>
	<5188E58D.7070304@xenomai.org> <5188F546.5090001@gmail.com>
	<518A50D8.20709@xenomai.org> <518A9BE9.2040105@gmail.com>
	<518A9E20.9020400@xenomai.org> <518AAA8F.6010309@gmail.com>
In-Reply-To: <518AAA8F.6010309@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Doubts about priorities with periodic tasks (Posix
 Skin)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/08/2013 09:42 PM, Sebastian Pavez wrote:

> Just some points to clarify,
> 
> - First of all my problem isn't with the functioning of Xenomai. That 
> works jus fine ... I think.
> - The whole idea of my code is to explain the theory behind a real time 
> system
> - In the theory if you have 2 tasks, the one with the highest priority 
> (T1) will execute before the other (T2), if there's sometime left it 
> will be executed


You are assuming the tasks are activated at the same time, which would
be true with a periodic timer, but is not true with a one-shot timer,
which is xenomai default, not if you do not use the second argument of
pthread_make_periodic_np to get the tasks to be activated at the same
time. The definition of the "FIFO" scheduler, is that at any given time,
the task with the highest priority, which has been runnable for the
longest time runs. No more, no less. So, you see, how the scheduler
works has nothing to do with any notion of period. A task can run for as
much time as it likes, even miss its next "activation point", in such a
case the next call to pthread_wait_np will return with a non null count
of "overruns".

> - On the other hand, if there's not enough time to execute the task with 
> lowest priority (T2) it will be paused by the other one.


A task preempts another when it becomes runnable and the other is still
runnable but as a lower (strictly) priority. So, depending on the time
when the periodic activations of your two tasks were started, the task
with the high priority may preempt the task with the lowest priority
even if the sum of their execution times is not equal to the period.
Again, you are assuming periodic timer, which Xenomai does not use.

> - I do that with a same period for both tasks and increasing the 
> execution time of T1 order to reduce the time left to T2.
> - So for instance, if I have a period of 50us for each task. The 
> execution time for T2 is 20us, and for T1 is variable (call it 'E1').
> - If 'E1' is less than 30us everything will be ok, both tasks will be 
> executed entirely (Case1)
> - But, when 'E' is over 30us T2 will not have enough time to complete 
> (Case2)


No, both T1 and T2 will execute, T2 will only notice some overruns.

> 
> - Whit this in mind, if I have two tasks in Xenomai (with different 
> priority) is possible to see this effect, I mean for Case1 everything 
> goes fine. But when I try Case2 the computer hangs up for a while and 
> the execution ends.


That is the effect of Xenomai watchdog, kernel configuration option
CONFIG_XENO_OPT_WATCHDOG. That is because, by default, we consider that
a system running Xenomai which leaves no time for Linux to run is a
system with a problem, a programming error, so we try to avoid a reboot
by killing the faulting application, because this behaviour is known to
cause crashes of Linux. Now, if you want to disable
CONFIG_XENO_OPT_WATCHDOG, you can, but you should know that you may
cause Linux to crash.

-- 
                                                                Gilles.

