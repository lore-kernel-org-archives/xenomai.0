From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <ff1d78710905130504h2588d8c5te0b918dce3a8f0da@domain.hid>
References: <ff1d78710905130504h2588d8c5te0b918dce3a8f0da@domain.hid>
Content-Type: text/plain
Date: Wed, 13 May 2009 14:59:37 +0200
Message-Id: <1242219577.26544.952.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Periodic threads not scheduled
 anymore during debug session
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Kauffmann <steven.kauffmann@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

On Wed, 2009-05-13 at 14:04 +0200, Steven Kauffmann wrote:
> Hi all,
> 
> If I connect a debugger to my application, other Xenomai periodic
> threads (threads that not belong to the current process I'm debugging
> ) are not scheduled anymore. Attached you can find a simple example
> that reproduces the problem. I run the program 2 times in a different
> terminal and connected a debugger to one of them. When a breakpoint is
> reached both programs stops their execution but I would expect that
> only the program that I'm debugging should stop and not both.
> 
> $ cat /proc/xenomai/sched
> 
> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>   0  0       -1      0          0          master    R          ROOT
>   0  5469     0      1000000001 331274938  master    D
>   0  5471     0      1000000001 0          master    XT
> 
> This looks normal one thread is stopped ( thread that reaches the
> breakpoint ) and the other one is delayed because it's a periodic
> thread. Every time I call this command the timeout of the delayed
> thread changes so it looks like this thread is still running but in
> reality it is not.

This behavior is wanted (I mean, the implementation does freeze all
thread timers when a break state is reached on purpose), so that you
don't get tons of overruns once the debuggee is restarted.

However, I'm now wondering if we should not be a bit smarter than this,
and narrow the scope of such action. We do have the mechanisms to do so,
it is just a matter of using them.

> 
> I'm using the xenomai 2.4 branch and kernel linux-2.6.28.9 patched
> with adeos-ipipe-2.6.28.9-x86-2.2-07.
> 
> Regards
> 
> Steven
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



