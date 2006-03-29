Message-ID: <442A7D19.2000009@domain.hid>
Date: Wed, 29 Mar 2006 14:27:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
References: <1143612388.32703.257789950@domain.hid>
In-Reply-To: <1143612388.32703.257789950@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Saul <xeno@domain.hid>
Cc: xenomai@xenomai.org

Saul wrote:
> Hi,
> 
> I'm trying to run a short test program, just to get into the swing
> of this shiny new real-time system. I'm running Xenomai 2.1.0 on
> kernel 2.6.15.6
> 
> The following program runs a busy delay in primary mode (verified by
> enabling the primary mode switch warning) and calculates the time taken.
> Another task is resumed and prints the time.
> 
> I get output something like this:
>   1:  40.017 ms
>   2:  40.017 ms
>   3:  53.357 ms
>   4:  53.356 ms
>   5:  40.017 ms
>   6:  40.020 ms
>   7:  53.355 ms
>   8:  40.020 ms
>   9:  40.017 ms
>  10:  53.356 ms
>  11:  40.020 ms
>  12:  40.019 ms
>  13:  106.710 ms
>  14:  40.017 ms
>  15:  40.018 ms ...
> 
> I assume I've done something silly but I can't find anything wrong. My
> computer is a 3GHz P4. Xenomai is built-in statically, and at boot says
> "Xenomai: SMI-enabled Intel chipset found, enabling SMI workaround."
> 

It would be nice to known whether the latency test from the testsuite 
has correct latency figures, so that we could rule out any SMI issue.

> Anyway, the erratic execution times come and go with the smallest
> changes in the program e.g. moving the delay into it's own function or
> creating functions for timing the delay loop, so I wouldn't be too
> surprised if the problem can't be reproduced.
> 

What /proc/xenomai/stat says during execution btw?

> Also, I found that using rt_timer_spin() instead of a real busy loop
> does not have the same problem, which indicates that the simple busy
> loop is in fact being interrupted during execution.
> 

Just to rule this out, maybe you could try something along these lines:

		iopl(3)
...
		asm("cli");
                  RTIME prev_tsc = rt_timer_tsc();
                  my_processing();
                  RTIME tsc = rt_timer_tsc();
		asm("sti");

Out of curiosity, I'd also be interested in looking at the assembly dump 
of my_process in the working and non-working cases.

> Is it a problem that I'm not explicitly destroying the tasks? They don't
> linger in /proc/xenomai/sched once the program is killed. How much
> is automatically cleaned up upon process exit?

Only tasks are automatically wiped out by the nucleus, basically because 
they could not exist anymore after their parent process terminates. 
OTOH, other objects of the native API can linger since they do not 
depend on process resources, until they are explicitely destroyed or the 
API module is unloaded.

> 
> #include <stdio.h>
> #include <stdlib.h> // exit
> #include <unistd.h> // pause
> #include <sys/mman.h> // mlockall
> #include <signal.h>
> #include <xenomai/native/task.h>
> #include <xenomai/native/timer.h>
> 

I'll look at this on my side too.

-- 

Philippe.

