Mime-Version: 1.0 (Apple Message framework v753.1)
In-Reply-To: <mailman.13966.1293037981.32598.xenomai@xenomai.org>
References: <mailman.13966.1293037981.32598.xenomai@xenomai.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40767404-D45D-43EF-A547-63278CC78AF7@domain.hid>
Content-Transfer-Encoding: 7bit
From: Andreas Glatz <andi.glatz@domain.hid>
Date: Thu, 23 Dec 2010 00:10:45 +0100
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi again,

>
>> Check whether the thread manager does attempt to call into the  
>> Xenomai
>> replacement for the pthread_cond_wait call.
>
> I have to apologize; the pthread_cond_wait -> EPERM appeared after  
> enabling
> debug output to trace the actual problem I had when I started this  
> mail thread,
> but is seems unrelated. I have completely disabled that part of  
> code, and with
> it also disabled the use of all pthread* functions. Only native  
> skin functions
> are used by my remaining code and I'm back to the original problem  
> (gdb hangs
> at some point when stepi'ing through rt_task_start).
>
> Even though debugging is enabled, nothing is printed on the  
> console. The target
> cannot be reached on the console (Ctrl-C doesn't work) and GDB also  
> doesn't
> react on Ctrl-C. telnet to the target works, however. cat /proc/ 
> xenomai/sched
> shows the half started task as "X Console_Output_Thread":
>
> / # cat /proc/xenomai/sched
> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>    0  0      rt      49      -         master     R          ROOT
>    0  303    rt      49      -         master     RT         main
>    0  305    rt      49      -         master     X           
> Console_Output_Thread
>

I forgot to describe our problem: Gdb hung at rt_task_start() when  
trying to step through it. But debugging worked fine if I set a  
breakpoint in the task body, way after any rt_task_start(). Btw, do  
you call rt_task_start() from a RT task body?

Andreas

