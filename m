Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200608031628.31584@domain.hid>
References: 200608021808.18076@domain.hid> <200608021808.18076@domain.hid>
	<44D0F72E.3020406@domain.hid>  <200608031628.31584@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 20:01:10 +0200
Message-Id: <1154628070.5010.146.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Thu, 2006-08-03 at 16:28 +0200, Petr Cervenka wrote:
> >Petr Cervenka wrote:
> >> I have Xenomai snapshot (18.5.2006, 2.1.1 ~ 2.1.2) and userspace 
> >> application. I need to exchange lot of data between two tasks 
> >> (producer -> consumer) with some buffer in the middle. I used 
> >> rt_pipe/linux device scheme, but I realised that the preformance is 
> >> very low. (At least some performance monitor showed it)
> >
> >Could you elaborate on this? Does the performance monitor (which one?)
> >tell you more details? What is the characteristic of your transferred
> >data (size, frequency)?
> performace editor: KSysGuard, graphs of System Load and User Load
> Frequency: 10000Hz(100us period), cca 50-100bytes
> I tried to remove the pipe. The producer didn't send data in pipe and the consumer was synchronized by timer instead of read from pipe. The cpu load was much lower (50+% -> 10-%).
> 

I'm not sure to understand which kind of impact you would expect from an
IPC that does at the very least a kernel-to-user copy of the transmitted
data, but also crosses boundaries between RT and non-RT domains.

This said, I agree that queues are likely the best way to exchange large
amount of data between RT tasks, specifically if you can prepare the
largest possible data bulks to be sent in place (i.e. directly in the
transmission buffer obtained by rt_queue_alloc), so that there is no
other copy needed for transmission.

> >
> >> So I tried to use rt_queue. But when I tried to read from queue with
> >> timeout (or TM_INFINITE), I got an EPERM error. That means: "service
> >> should block, but was called from a context, which cannot sleep.".
> >> But I want to sleep (and wait for new data). Where is the problem? Do
> >> you have any advice?
> >
> >Is the read of the queue a Xenomai thread? It has to be, even if it will
> >mostly run in secondary (Linux) mode. Check also /proc/xenomai/sched
> >when you think it should be.
> Both tasks are created by rt_task_create and started by rt_task_start. They are also in /proc/xenomai/sched:
> CPU  PID    PRI      TIMEOUT  STAT       NAME
>   0  0       -1      0        R          ROOT/0
>   1  0       -1      0        R          ROOT/1
>   1  313     20      0        X          main_task
>   1  314     30      30195788906 w          hw_task
> Note: I'm still using your patch allowing to call rtdm_event_timedwait even in nrt.
> 
> >Maybe what you really want is shared memory between producer and
> >consumer. If the consumer is mapped to Xenomai, you can even use normal
> >synchronisation (mutexes/semaphores) to control the access - or design
> >something lock-less.
> I think, that pipes or queues are exactly what I need (FIFO). Every atempt to use shared memory and synchronization will probably bring only more errors made by myself.
> 
> Petr
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



