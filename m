Message-ID: <4A0ACC6A.3010205@domain.hid>
Date: Wed, 13 May 2009 15:34:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <ff1d78710905130504h2588d8c5te0b918dce3a8f0da@domain.hid>	
	<1242219577.26544.952.camel@domain.hid> <4A0AC81A.7050000@domain.hid>
	<1242221456.26544.960.camel@domain.hid>
In-Reply-To: <1242221456.26544.960.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Steven Kauffmann <steven.kauffmann@domain.hid>, xenomai@xenomai.org

Philippe Gerum wrote:
> On Wed, 2009-05-13 at 15:16 +0200, Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2009-05-13 at 14:04 +0200, Steven Kauffmann wrote:
>>>> Hi all,
>>>>
>>>> If I connect a debugger to my application, other Xenomai periodic
>>>> threads (threads that not belong to the current process I'm debugging
>>>> ) are not scheduled anymore. Attached you can find a simple example
>>>> that reproduces the problem. I run the program 2 times in a different
>>>> terminal and connected a debugger to one of them. When a breakpoint is
>>>> reached both programs stops their execution but I would expect that
>>>> only the program that I'm debugging should stop and not both.
>>>>
>>>> $ cat /proc/xenomai/sched
>>>>
>>>> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>>>>   0  0       -1      0          0          master    R          ROOT
>>>>   0  5469     0      1000000001 331274938  master    D
>>>>   0  5471     0      1000000001 0          master    XT
>>>>
>>>> This looks normal one thread is stopped ( thread that reaches the
>>>> breakpoint ) and the other one is delayed because it's a periodic
>>>> thread. Every time I call this command the timeout of the delayed
>>>> thread changes so it looks like this thread is still running but in
>>>> reality it is not.
>>> This behavior is wanted (I mean, the implementation does freeze all
>>> thread timers when a break state is reached on purpose), so that you
>>> don't get tons of overruns once the debuggee is restarted.
>>>
>>> However, I'm now wondering if we should not be a bit smarter than this,
>>> and narrow the scope of such action. We do have the mechanisms to do so,
>>> it is just a matter of using them.
>> Do we? I mean, are we able to know which process a timer belongs to?
>>
> 
> We could tag the per-thread timers (rtimer, ptimer) using their status
> field, and move back to the owner thread using container_of() when
> applicable.

What if an application uses rt_alarm_create/rt_alarm_wait?

-- 
                                                 Gilles.

